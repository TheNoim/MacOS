#!/bin/bash

# Sometimes my display refresh rate resets to 60 on boot. This script sets it back to 99Hz.
# Requires: https://github.com/univ-of-utah-marriott-library-apple/display_manager

CURRENT_HZ=$(display_manager.py show main | grep 'refresh rate' | awk '{print $3}')

if [ "$CURRENT_HZ" != "99" ]; then
	display_manager.py res 1920 1080 99 main
else
	echo "Display is correct"
fi
