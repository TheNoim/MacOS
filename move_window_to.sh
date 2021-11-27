#!/bin/bash

export PATH="$HOME/.yarn/bin/:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

APP_NAME=$1

TARGET_DISPLAY=$2

TARGET_SPACE_INDEX=$3

WINDOW_ID=$(yabai -m query --windows | jq ".[] | select(.app == \"$APP_NAME\") | .id")

TARGET_SPACE=$(yabai -m query --displays | jq ".[] | select(.uuid == \"$TARGET_DISPLAY\") | .spaces[$TARGET_SPACE_INDEX]")

if [[ ! -z $WINDOW_ID && ! -z $TARGET_SPACE ]]; then
	yabai -m window $WINDOW_ID --space $TARGET_SPACE
fi
