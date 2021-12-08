#!/usr/bin/sh

# # polybar
# alias polybar='polybar-git'

# keyboard speed
# xset r  rate 200 60
# xset r  rate 300 65
xset r  rate 350 35

# enable touch pad's tap-to-click
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1

# input method
ibus-daemon -d --xim  # -d is daemon start optoin, --xim support multiple tty sessions
