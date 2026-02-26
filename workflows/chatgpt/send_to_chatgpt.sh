#!/usr/bin/env zsh
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <text>"
  exit 1
fi

text="$*"
send_mode="${SEND_MODE:-smart}"

if ! open -Ra "ChatGPT"; then
  echo "ChatGPT app is not installed in /Applications."
  exit 1
fi

# Use clipboard paste for reliable non-ASCII input.
osascript - "$text" "$send_mode" <<'APPLESCRIPT'
on clickMenuItemIfExists(appProcessName, menuBarItemNames, menuItemNames)
  tell application "System Events"
    tell process appProcessName
      set frontmost to true
      repeat with menuBarTitle in menuBarItemNames
        repeat with menuItemTitle in menuItemNames
          try
            click menu item (menuItemTitle as text) of menu 1 of menu bar item (menuBarTitle as text) of menu bar 1
            return true
          end try
        end repeat
      end repeat
    end tell
  end tell
  return false
end clickMenuItemIfExists

on run argv
  set userText to item 1 of argv
  set sendMode to item 2 of argv
  set didSend to false
  set didCreateNewChat to false
  set the clipboard to userText

  tell application "ChatGPT" to activate
  delay 0.5

  -- Prefer explicit menu action over shortcut for better stability across keybinding settings.
  try
    set didCreateNewChat to clickMenuItemIfExists("ChatGPT", {"File", "文件"}, {"New Chat", "New chat", "新建聊天", "新建对话"})
  end try

  tell application "System Events"
    if didCreateNewChat is false then
      keystroke "n" using command down
      delay 0.35
    else
      delay 0.25
    end if
    keystroke "v" using command down
    delay 0.4
  end tell

  if sendMode is "smart" then
    try
      tell application "System Events"
        tell process "ChatGPT"
          set frontmost to true
          repeat with w in windows
            repeat with b in (every button of w)
              set bName to ""
              set bDesc to ""
              try
                set bName to name of b as text
              end try
              try
                set bDesc to description of b as text
              end try
              if bName contains "Send" or bDesc contains "Send" or bName contains "发送" or bDesc contains "发送" then
                click b
                set didSend to true
                exit repeat
              end if
            end repeat
            if didSend then exit repeat
          end repeat
        end tell
      end tell
    end try
  end if

  if didSend is false then
    tell application "System Events"
      if sendMode is "enter" then
        key code 36
      else if sendMode is "cmd_enter" then
        keystroke return using command down
      else
        key code 36
        delay 0.15
        keystroke return using command down
        delay 0.15
        key code 76
      end if
    end tell
  end if
end run
APPLESCRIPT
