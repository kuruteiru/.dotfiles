#!/bin/sh

ghostty &

swaymsg assign [class="ticktick"] 2
ticktick &
sleep 2

swaymsg assign [app_id="zen"] 2
zen &
sleep 1

# swaymsg [class="ticktick"] focus && swaymsg resize shrink width 1000px

protonvpn-app &
