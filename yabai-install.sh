#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

if [ -f $HOME/.yabairc ]; then
	rm $HOME/.yabairc
fi

ln -s $(pwd)/.yabairc ~/.yabairc

./reload.sh
