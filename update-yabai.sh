#!/bin/bash

brew services stop yabai

brew uninstall yabai.rb

brew install yabai.rb

sudo yabai --uninstall-sa
sudo yabai --install-sa

brew services start yabai

sudo yabai --load-sa
