#!/bin/bash

cp io.noim.restic_backup.plist ~/Library/LaunchAgents

launchctl load ~/Library/LaunchAgents/io.noim.restic_backup.plist
