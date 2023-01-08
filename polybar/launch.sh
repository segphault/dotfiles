#!/usr/bin/env bash

polybar-msg cmd quit
polybar --config=~/.config/polybar/config.ini top-1 & disown
polybar --config=~/.config/polybar/config.ini top-2 & disown
