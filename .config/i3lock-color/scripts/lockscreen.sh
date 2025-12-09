#!/bin/bash

### --- AUTO-DETECT SCALING (HiDPI vs normal) --- ###
# Detect DPI using xdpyinfo. If it fails, assume standard DPI.
DPI_RAW="$(xdpyinfo 2>/dev/null | awk '/dots per inch/{print $4}' | cut -d'x' -f1)"

# If xdpyinfo fails or returns nothing, assume 96 DPI (normal)
if [ -z "$DPI_RAW" ]; then
    DPI_RAW=96
fi

# HiDPI threshold (you can tweak this)
if [ "$DPI_RAW" -ge 150 ]; then
    SCALE_FACTOR=2   # HiDPI
else
    SCALE_FACTOR=1   # Normal DPI
fi

export SCALE_FACTOR
### --- END AUTO-DETECT BLOCK --- ###


# ── CONFIG ────────────────────────────────────────────

# Bold Fonts – adjust these if needed
BOLD_FONT1="JetBrainsMono Nerd Font:style=Bold"
BOLD_FONT2="Noto Sans:style=Bold"
BOLD_FONT3="Liberation Sans:style=Bold"

# Screenshot path
IMG="/tmp/i3lock_blur.png"


# ── DYNAMIC SCREEN & FONT CALCULATION ────────────────

# Get screen width and height
SCREEN_RES=$(xrandr | grep '*' | awk '{print $1}' | head -n1)
SCREEN_WIDTH=$(echo $SCREEN_RES | cut -d 'x' -f1)
SCREEN_HEIGHT=$(echo $SCREEN_RES | cut -d 'x' -f2)

# Base resolution for scaling reference
BASE_WIDTH=1920
BASE_HEIGHT=1080

# Calculate scaling factors relative to base resolution
SCALE_W=$(echo "scale=4; $SCREEN_WIDTH / $BASE_WIDTH" | bc)
SCALE_H=$(echo "scale=4; $SCREEN_HEIGHT / $BASE_HEIGHT" | bc)

# Base sizes
BASE_TIME_SIZE=40
BASE_DATE_SIZE=30
BASE_LAYOUT_SIZE=20
BASE_GREETER_SIZE=25
BASE_VERIF_SIZE=30
BASE_WRONG_SIZE=30

# Apply scaling factors and HiDPI multiplier
TIME_SIZE=$(printf "%.0f" $(echo "$BASE_TIME_SIZE * $SCALE_W * $SCALE_FACTOR" | bc))
DATE_SIZE=$(printf "%.0f" $(echo "$BASE_DATE_SIZE * $SCALE_W * $SCALE_FACTOR" | bc))
LAYOUT_SIZE=$(printf "%.0f" $(echo "$BASE_LAYOUT_SIZE * $SCALE_W * $SCALE_FACTOR" | bc))
GREETER_SIZE=$(printf "%.0f" $(echo "$BASE_GREETER_SIZE * $SCALE_W * $SCALE_FACTOR" | bc))
VERIF_SIZE=$(printf "%.0f" $(echo "$BASE_VERIF_SIZE * $SCALE_W * $SCALE_FACTOR" | bc))
WRONG_SIZE=$(printf "%.0f" $(echo "$BASE_WRONG_SIZE * $SCALE_W * $SCALE_FACTOR" | bc))

# Position offsets (relative to screen height)
GREETER_OFFSET=$(printf "%.0f" $(echo "-$SCREEN_HEIGHT * 0.06" | bc))
TIME_OFFSET=$(printf "%.0f" $(echo "-$SCREEN_HEIGHT * 0.001" | bc))
DATE_OFFSET=$(printf "%.0f" $(echo "$SCREEN_HEIGHT * 0.03" | bc))
LAYOUT_OFFSET=$(printf "%.0f" $(echo "$SCREEN_HEIGHT * 0.055" | bc))
VERIF_OFFSET=$LAYOUT_OFFSET
WRONG_OFFSET=$LAYOUT_OFFSET

# Debug info
echo "Resolution: ${SCREEN_WIDTH}x${SCREEN_HEIGHT}"
echo "DPI: $DPI_RAW   ScaleFactor: $SCALE_FACTOR"
echo "Font Sizes: Time=$TIME_SIZE, Date=$DATE_SIZE, Layout=$LAYOUT_SIZE, Greeter=$GREETER_SIZE, Verif=$VERIF_SIZE, Wrong=$WRONG_SIZE"
echo "Offsets: Greeter=$GREETER_OFFSET, Time=$TIME_OFFSET, Date=$DATE_OFFSET, Layout=$LAYOUT_OFFSET"

# ── SETUP: SCREENSHOT & BLUR ──────────────────────────

# Take screenshot of the current desktop
import -window root "$IMG"

# Apply blur
magick "$IMG" -blur 0x8 "$IMG"

# Kill any leftover sound or input test processes
pkill -f "aplay.*click.wav" 2>/dev/null
pkill -f "evtest" 2>/dev/null


# ── COLORS ───────────────────────────────────────────

bg="#232627cc"        # background
fg="#ecf2ff"          # foreground
accent1="#40a5da"     # light blue
accent2="#2080bb"     # darker blue
error="#e2266e"       # red
keyhl="#72e69a"       # green accent
sep="#afb3bd"         # separator
layout="#ffffff"      # layout text


# ── LOCKSCREEN ────────────────────────────────────────

i3lock \
    --image "$IMG" \
    --inside-color="$bg" \
    --ring-color="$accent1" \
    --line-color="$bg" \
    --separator-color="$sep" \
    --keyhl-color="$keyhl" \
    --bshl-color="$error" \
    --ringver-color="$accent2" \
    --ringwrong-color="$error" \
    --insidever-color="$bg" \
    --insidewrong-color="$bg" \
    --verif-color="$accent2" \
    --wrong-color="$error" \
    --layout-color="$layout" \
    --time-color="$accent1" \
    --date-color="$fg" \
    --greeter-color="$keyhl" \
    --noinput-text="" \
    --pass-media-keys \
    --radius=130 \
    --ring-width=10 \
    --wrong-text="Nope." \
    --verif-text="Checking..." \
    --greeter-text="Type to unlock" \
    --clock --indicator \
    --time-font="$BOLD_FONT1" \
    --date-font="$BOLD_FONT2" \
    --layout-font="$BOLD_FONT3" \
    --verif-font="$BOLD_FONT1" \
    --wrong-font="$BOLD_FONT1" \
    --greeter-font="$BOLD_FONT2" \
    --time-size=$TIME_SIZE \
    --date-size=$DATE_SIZE \
    --layout-size=$LAYOUT_SIZE \
    --greeter-size=$GREETER_SIZE \
    --verif-size=$VERIF_SIZE \
    --wrong-size=$WRONG_SIZE \
    --greeter-pos="ix:iy$GREETER_OFFSET" \
    --time-pos="ix:iy$TIME_OFFSET" \
    --date-pos="ix:iy+$DATE_OFFSET" \
    --layout-pos="ix:iy+$LAYOUT_OFFSET" \
    --verif-pos="ix:iy+$VERIF_OFFSET" \
    --wrong-pos="ix:iy+$WRONG_OFFSET"
