#!/bin/bash

input=$1

export PATH=/usr/local/bin/:$PATH

scriptLocation=$(dirname "${BASH_SOURCE[0]}")

function getCurrentDisplay() {
	echo $(yabai -m query --displays --display mouse | jq '.index')
}

function getCurrentSpaceForDisplay() {
	echo $(yabai -m query --spaces --display mouse | jq 'map(select(."is-visible" == true)) | .[0] | .index')
}

function getFirstSpaceIndexForDisplay() {
	echo $(yabai -m query --spaces --display mouse | jq '.[0] | .index')
}

function getLastSpaceIndexForDisplay() {
	echo $(yabai -m query --spaces --display mouse | jq '.[-1] | .index')
}

function getGrabbedWindow() {
	MOUSE=$(yabai -m query --windows --window mouse)
	IS_GRABBED=$(echo $MOUSE | jq '."is-grabbed"')
	if [ $IS_GRABBED == "1" ]; then
		WINDOW_ID=$(echo $MOUSE | jq '.id')
		echo $WINDOW_ID
	else
		echo "FALSE"
	fi
}

function preFocus() {
	FOCUS=$(getGrabbedWindow)
}

function postFocus() {
	if [ $FOCUS != "FALSE" ]; then
		yabai -m window --focus $FOCUS
	fi
}

function focusFirstSpace() {
	yabai -m space --focus $(getFirstSpaceIndexForDisplay)
}

function focusLastSpace() {
	yabai -m space --focus $(getLastSpaceIndexForDisplay)
}

function focusSpace() {
	yabai -m space --focus $1
}

preFocus

if [ $input == 'first' ]; then
	focusFirstSpace
elif [ $input == 'last' ]; then
	focusLastSpace
else
	currentSpace=$(getCurrentSpaceForDisplay)

	if [ $input == 'next' ]; then
		lastIndex=$(getLastSpaceIndexForDisplay)
		if [ $currentSpace == $lastIndex ]; then
			focusFirstSpace
		else
			let "nextSpace = $currentSpace + 1"
			focusSpace $nextSpace
		fi
	elif [ $input == 'back' ]; then
		firstIndex=$(getFirstSpaceIndexForDisplay)
		if [ $currentSpace == $firstIndex ]; then
			focusLastSpace
		else
			let "nextSpace = $currentSpace - 1"
			focusSpace $nextSpace
		fi
	fi
fi

postFocus
