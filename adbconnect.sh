#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title AdbConnect
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Port" }
# @raycast.packageName DevTools

# Documentation:
# @raycast.description Connects ADB to Android Device 
# @raycast.author Mykhailo Fomenko
# @raycast.authorURL michaelfmnk.dev

adb connect 192.168.50.171:$1

