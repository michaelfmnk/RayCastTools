#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title AfterWork
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💼
# @raycast.packageName Personal
# @raycast.needsConfirmation true

# Documentation:
# @raycast.description Quits all apps & disconnects VPNs
# @raycast.author Mykhailo Fomenko
# @raycast.authorURL michaelfmnk.dev


set appPaths to {}
tell application "System Events"
    repeat with aProcess in (get file of every process whose background only is false)
    set processPath to POSIX path of aProcess
    set end of appPaths to processPath
    end repeat
end tell

repeat with anApp in appPaths
   if anApp does not start with "/System/Library/CoreServices/Finder.app" then
        tell application anApp to quit
    end if
end repeat

tell application "Tunnelblick" to quit
tell application "Raycast" to activate



