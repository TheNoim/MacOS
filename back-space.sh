#!/bin/bash
export PATH=/usr/local/bin/:$PATH
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
yabai -m space --focus prev || $DIR/last-space.sh
