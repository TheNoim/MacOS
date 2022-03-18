#!/bin/bash

if [[ -z $(which spotlight-manager) ]]; then
	if [[ -z $(which npm) ]]; then
		echo "You need to install nodejs with npm first"
		exit 1
	fi
	npm install -g spotlight-manager
fi

# Add all node_modules to blacklist
sudo spotlight-manager exclude node_modules ~/Entwicklung

# Make sure spotlight is enabled
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist

# Rebuild index
sudo mdutil -E /
