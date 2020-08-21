#!/bin/bash

function getCurrentDisplay() {
	echo $(yabai -m query --spaces | jq 'map(select(.focused == 1)) | .[0] | .display')
}

function getLastSpaceIndexForDisplay() {
	local display=$1
	echo $(yabai -m query --spaces --display $display | jq '.[-1] | .index')
}

yabai -m space --focus $(getLastSpaceIndexForDisplay $(getCurrentDisplay))
