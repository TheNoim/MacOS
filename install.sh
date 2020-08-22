#!/bin/bash

# Never reopen any windows
sudo bash -c "> $HOME/Library/Preferences/ByHost/com.apple.loginwindow*"
sudo chown root ~/Library/Preferences/ByHost/com.apple.loginwindow*
sudo chmod 000 ~/Library/Preferences/ByHost/com.apple.loginwindow*
