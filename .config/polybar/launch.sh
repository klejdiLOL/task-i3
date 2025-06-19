#!/usr/bin/env bash

# launch.sh
# author: Klejdi Janari (klejdiLOL)
# OpenMandriva
# https://forum.openmandriva.org/
# Location: ~/.config/polybar/launch.sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.7; done

# Launch the bar
polybar -q main -c $HOME/.config/polybar/config.ini &
