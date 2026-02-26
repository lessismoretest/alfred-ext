#!/usr/bin/env zsh
set -euo pipefail

# Built-in defaults (so reinstall works without re-configuring workflow variables).
DEFAULT_TARGET_NAME="Openclaw"
DEFAULT_TARGET_SHORTCUT="cmd_k"
DEFAULT_SEND_MODE="enter"

text="${1:-}"
send_mode="${FEISHU_SEND_MODE:-$DEFAULT_SEND_MODE}"
target_name="${FEISHU_TARGET_NAME:-$DEFAULT_TARGET_NAME}"
target_shortcut="${FEISHU_TARGET_SHORTCUT:-$DEFAULT_TARGET_SHORTCUT}"
feishu_app=""

if [[ -z "$text" ]]; then
  text="$(pbpaste || true)"
fi

if [[ -z "$text" ]]; then
  echo "No text provided (argument and clipboard are both empty)."
  exit 1
fi

for candidate in "Feishu" "Lark"; do
  if open -Ra "$candidate" 2>/dev/null; then
    feishu_app="$candidate"
    break
  fi
done

if [[ -z "$feishu_app" ]]; then
  echo "Feishu/Lark app not found. Please install Feishu (or Lark)."
  exit 1
fi

open -ga "$feishu_app"
sleep 0.8

osascript - "$feishu_app" "$text" "$send_mode" "$target_name" "$target_shortcut" <<'APPLESCRIPT'
on run argv
  set appName to item 1 of argv
  set userText to item 2 of argv
  set sendMode to item 3 of argv
  set targetName to item 4 of argv
  set targetShortcut to item 5 of argv

  set the clipboard to userText

  tell application appName to activate
  delay 0.6

  tell application "System Events"
    if targetName is not "" then
      if targetShortcut is "cmd_k" then
        keystroke "k" using command down
      else
        keystroke "j" using command down
      end if
      delay 0.3
      keystroke targetName
      delay 0.45
      key code 125
      delay 0.1
      key code 36
      delay 0.12
      key code 76
      delay 0.55
      key code 53
      delay 0.12
    end if

    keystroke "v" using command down
    delay 0.25

    if sendMode is "cmd_enter" then
      keystroke return using command down
    else if sendMode is "both" then
      key code 36
      delay 0.15
      keystroke return using command down
    else
      key code 36
    end if
  end tell
end run
APPLESCRIPT
