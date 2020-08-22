#!/bin/bash
echo "Reload yabai"
launchctl kickstart -k "gui/${UID}/homebrew.mxcl.yabai"
echo "Reload skhd"
skhd --reload
