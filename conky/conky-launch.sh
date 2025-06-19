#!/bin/bash

# conky-launch.sh
# author: Klejdi Janari (klejdiLOL)
# OpenMandriva
# https://forum.openmandriva.org/
# Location: ~/.config/conky/conky-launch.sh

# Path to the Conky temp file and config file
TEMP_FILE="$HOME/.config/conky/conky.conf.temp"
CONF_FILE="$HOME/.config/conky/conky.conf"

# Kill all running Conky processes
pkill -x conky

# Wait for 0.3 seconds to ensure Conky is terminated
sleep 0.3

# Check if the .temp file exists and remove it
if [ -f "$TEMP_FILE" ]; then
    rm "$TEMP_FILE"
fi

# Get screen resolution
WIDTH=$(xrandr | grep '*' | awk '{print $1}' | cut -d 'x' -f1)
HEIGHT=$(xrandr | grep '*' | awk '{print $1}' | cut -d 'x' -f2)

# Calculate dynamic font size based on screen width (you can adjust the divisor for finer control)
FONT_SIZE=$((WIDTH / 200))  # This scales the font size as a fraction of the screen width

# Calculate dynamic gaps as a proportion of the screen width/height
GAP_X=$((WIDTH / 60))  # Horizontal gap relative to screen width
GAP_Y=$((HEIGHT / 50))  # Vertical gap relative to screen height

# Create a new temporary Conky config with dynamic values
cp "$CONF_FILE" "$TEMP_FILE"
sed -i "s/\${FONT_SIZE}/$FONT_SIZE/g" "$TEMP_FILE"
sed -i "s/\${GAP_X}/$GAP_X/g" "$TEMP_FILE"
sed -i "s/\${GAP_Y}/$GAP_Y/g" "$TEMP_FILE"

# Launch Conky with the temporary configuration
conky -c "$TEMP_FILE"
