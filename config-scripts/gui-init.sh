#!/usr/bin/sh

# # polybar
# alias polybar='polybar-git'

# keyboard speed
xset r rate 250 50

# enable touch pad's tap-to-click
xinput set-prop "ETPS/2 Elantech Touchpad" "libinput Tapping Enabled" 1

# input method
ibus-daemon -d  # -d is daemon start optoin
