#!/bin/bash

input=$1

export PATH=/usr/local/bin/:$PATH

scriptLocation=$(dirname "${BASH_SOURCE[0]}")

function getCurrentDisplay() {
	displayID=$($scriptLocation/mouse-display-id)
	echo $(yabai -m query --displays | jq --argjson display "$displayID" 'map(select(.id == $display)) | .[0].index')
}

function getCurrentSpaceForDisplay() {
	local display=$1
	echo $(yabai -m query --spaces --display $display | jq 'map(select(.visible == 1)) | .[0] | .index')
}

function getFirstSpaceIndexForDisplay() {
	local display=$1
	echo $(yabai -m query --spaces --display $display | jq '.[0] | .index')
}

function getLastSpaceIndexForDisplay() {
	local display=$1
	echo $(yabai -m query --spaces --display $display | jq '.[-1] | .index')
}

function focusFirstSpace() {
	yabai -m space --focus $(getFirstSpaceIndexForDisplay $(getCurrentDisplay))
}

function focusLastSpace() {
	yabai -m space --focus $(getLastSpaceIndexForDisplay $(getCurrentDisplay))
}

function focusSpace() {
	yabai -m space --focus $1
}

if [ $input == 'first' ]; then
	focusFirstSpace
elif [ $input == 'last' ]; then
	focusLastSpace
else
	display=$(getCurrentDisplay)
	currentSpace=$(getCurrentSpaceForDisplay $display)

	if [ $input == 'next' ]; then
		lastIndex=$(getLastSpaceIndexForDisplay $display)
		if [ $currentSpace == $lastIndex ]; then
			focusFirstSpace
		else
			let "nextSpace = $currentSpace + 1"
			focusSpace $nextSpace
		fi
	elif [ $input == 'back' ]; then
		firstIndex=$(getFirstSpaceIndexForDisplay $display)
		if [ $currentSpace == $firstIndex ]; then
			focusLastSpace
		else
			let "nextSpace = $currentSpace - 1"
			focusSpace $nextSpace
		fi
	fi
fi
