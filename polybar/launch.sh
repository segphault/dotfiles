#!/usr/bin/env bash

polybar-msg cmd quit
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar --config=~/.config/polybar/config.ini top-1 & disown
polybar --config=~/.config/polybar/config.ini top-2 & disown
