#!/usr/bin/env bash
# <bitbar.title>Yabai status</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Albert Groothedde</bitbar.author>
# <bitbar.author.github>alber70g</bitbar.author.github>
# <bitbar.desc>
# Shows the status of Yabai. Current space, and whether window is floating, sticky, on top and fullscreen.echo "setting up signals"
# ```
# yabai -m signal --add event=space_changed \
#   action="set SHELL=/bin/sh && open -g \"bitbar://refreshPlugin?name=yabai-window-info.*?.sh\""
# yabai -m signal --add event=window_resized \
#   action="set SHELL=/bin/sh && open -g \"bitbar://refreshPlugin?name=yabai-window-info.*?.sh\""
# yabai -m signal --add event=window_focused \
#   action="set SHELL=/bin/sh && open -g \"bitbar://refreshPlugin?name=yabai-window-info.*?.sh\""
# yabai -m signal --add event=application_activated \
#   action="set SHELL=/bin/sh && open -g \"bitbar://refreshPlugin?name=yabai-window-info.*?.sh\""
# echo "signals ready"
# ```
# </bitbar.desc>
# <bitbar.dependencies>yabai,jq</bitbar.dependencies>
PATH=$PATH:/usr/local/bin

space=$(yabai -m query --spaces --space | jq ".index")

echo "Space: $space"
