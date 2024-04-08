#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title VideoTrim
# @raycast.mode silent

# Optional parameters:
# @raycast.icon icons/trim.png
# @raycast.packageName VideoTools

# Documentation:
# @raycast.description Trims Videos with ffmpeg
# @raycast.author Mykhailo Fomenko
# @raycast.authorURL michaelfmnk.dev
on run argv
    -- Access the Finder application to work with file selections
    tell application "Finder"
        set selectedFiles to selection
        -- Check if no files are selected
        if (count of selectedFiles) is equal to 0 then
            display alert "No file selected" message "Please select a file in Finder first."
            return
        end if
        -- Assume the first selected file is the target
        set selectedFile to item 1 of selectedFiles as alias
        -- Convert the file path to a POSIX path
        set filePath to POSIX path of selectedFile
    end tell
    
    -- Prompt the user to enter start and end times for the trim operation
    set startTime to text returned of (display dialog "Enter start time (ss):" default answer "")
    set endTime to text returned of (display dialog "Enter end time (to):" default answer "")
    
    -- Prepare the output file name by removing the extension and appending "_trim.webm"
    tell application "System Events"
        set fileName to name of (info for selectedFile)
    end tell
    set AppleScript's text item delimiters to "."
    set fileBaseName to text items 1 through -2 of fileName as text
    set AppleScript's text item delimiters to ""
    set outputPath to (characters 1 through ((length of filePath) - (length of fileName)) of filePath as string) & fileBaseName & "_trim.webm"
    
    -- Define the path to the ffmpeg command
    set ffmpegPath to "/opt/homebrew/bin/ffmpeg"
    
    -- Construct the ffmpeg command with the user-provided start and end times
    set ffmpegCommand to ffmpegPath & " -loglevel quiet -ss " & quoted form of startTime & " -to " & quoted form of endTime & " -i " & quoted form of filePath & " -c copy " & quoted form of outputPath
    
    -- Execute the ffmpeg command
    do shell script ffmpegCommand
end run