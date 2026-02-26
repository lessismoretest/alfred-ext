#!/usr/bin/env zsh
set -euo pipefail

bot_username="${TG_BOT_USERNAME:-your_bot_username}"
text="${1:-}"
telegram_app=""

if [[ -z "$text" ]]; then
  text="$(pbpaste || true)"
fi

if [[ -z "$text" ]]; then
  echo "No text provided (argument and clipboard are both empty)."
  exit 1
fi

if [[ "$bot_username" == "your_bot_username" ]]; then
  echo "Please set TG_BOT_USERNAME in Alfred Workflow Environment Variables."
  exit 1
fi

# Support both app names used on macOS.
for candidate in "Telegram" "Telegram Desktop"; do
  if open -Ra "$candidate" 2>/dev/null; then
    telegram_app="$candidate"
    break
  fi
done

if [[ -z "$telegram_app" ]]; then
  echo "Telegram app not found. Please install Telegram Desktop."
  exit 1
fi

encoded_text="$(python3 -c 'import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))' "$text")"
url="tg://resolve?domain=${bot_username}&text=${encoded_text}"

# Explicitly launch app first for cold-start reliability.
open -ga "$telegram_app"
sleep 0.8
open "$url"

# Try auto-send after Telegram focuses the target bot chat.
osascript - "$telegram_app" <<'APPLESCRIPT'
on run argv
set appName to item 1 of argv

tell application appName to activate
delay 0.9

tell application "System Events"
  key code 36
end tell
end run
APPLESCRIPT
