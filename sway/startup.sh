#!/bin/sh

swaymsg workspace 1
ghostty &
proton-vpn &

return

swaymsg workspace 2
zen &

swaymsg workspace 1
