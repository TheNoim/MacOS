#!/bin/bash

brew services stop yabai

brew reinstall yabai.rb

sudo yabai --uninstall-sa

sudo yabai --install-sa

brew services start yabai
