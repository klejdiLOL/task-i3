#!/bin/bash
# ── CONFIG ────────────────────────────────────────────

# Bold Fonts – adjust these if needed
BOLD_FONT1="JetBrainsMono Nerd Font Bold"
BOLD_FONT2="Liberation Mono Bold"
BOLD_FONT3="Noto Sans Mono Bold"

# Screenshot path
IMG="/tmp/i3lock_blur.png"

# ── DYNAMIC SCREEN & FONT CALCULATION ────────────────

# Get screen width and height
SCREEN_RES=$(xrandr | grep '*' | awk '{print $1}' | head -n1)
SCREEN_WIDTH=$(echo $SCREEN_RES | cut -d 'x' -f1)
SCREEN_HEIGHT=$(echo $SCREEN_RES | cut -d 'x' -f2)

# Define base resolution
BASE_WIDTH=1920
BASE_HEIGHT=1080

# Calculate scaling factors
SCALE_W=$(echo "scale=2; $SCREEN_WIDTH / $BASE_WIDTH" | bc)
SCALE_H=$(echo "scale=2; $SCREEN_HEIGHT / $BASE_HEIGHT" | bc)

# Base sizes
BASE_TIME_SIZE=48
BASE_DATE_SIZE=24
BASE_LAYOUT_SIZE=20
BASE_GREETER_SIZE=32
BASE_VERIF_SIZE=20
BASE_WRONG_SIZE=20

# Calculate font sizes (rounded to int)
TIME_SIZE=$(printf "%.0f" $(echo "$BASE_TIME_SIZE * $SCALE_W" | bc))
DATE_SIZE=$(printf "%.0f" $(echo "$BASE_DATE_SIZE * $SCALE_W" | bc))
LAYOUT_SIZE=$(printf "%.0f" $(echo "$BASE_LAYOUT_SIZE * $SCALE_W" | bc))
GREETER_SIZE=$(printf "%.0f" $(echo "$BASE_GREETER_SIZE * $SCALE_W" | bc))
VERIF_SIZE=$(printf "%.0f" $(echo "$BASE_VERIF_SIZE * $SCALE_W" | bc))
WRONG_SIZE=$(printf "%.0f" $(echo "$BASE_WRONG_SIZE * $SCALE_W" | bc))

# Position offsets (relative to screen height)
GREETER_OFFSET=$(printf "%.0f" $(echo "-$SCREEN_HEIGHT * 0.04" | bc)) # ~4% up
TIME_OFFSET=$(printf "%.0f" $(echo "-$SCREEN_HEIGHT * 0.01" | bc))    # ~1% up
DATE_OFFSET=$(printf "%.0f" $(echo "$SCREEN_HEIGHT * 0.03" | bc))     # ~3% down
LAYOUT_OFFSET=$(printf "%.0f" $(echo "$SCREEN_HEIGHT * 0.055" | bc))  # ~5.5% down
VERIF_OFFSET=$LAYOUT_OFFSET
WRONG_OFFSET=$LAYOUT_OFFSET

# Debug info
echo "Resolution: ${SCREEN_WIDTH}x${SCREEN_HEIGHT}"
echo "Font Sizes: Time=$TIME_SIZE, Date=$DATE_SIZE, Layout=$LAYOUT_SIZE, Greeter=$GREETER_SIZE"
echo "Offsets: Greeter=$GREETER_OFFSET, Time=$TIME_OFFSET, Date=$DATE_OFFSET, Layout=$LAYOUT_OFFSET"

# ── SETUP: SCREENSHOT & BLUR ──────────────────────────

import -window root "$IMG"
magick "$IMG" -blur 0x8 "$IMG"

pkill -f "aplay.*click.wav" 2>/dev/null
pkill -f "evtest" 2>/dev/null

# ── LOCKSCREEN ────────────────────────────────────────

i3lock \
    --image "$IMG" \
    --inside-color="#21242Bcc" \
    --ring-color="#40A5DAff" \
    --line-color="#000000ff" \
    --separator-color="#AFB3BDff" \
    --keyhl-color="#40da76ff" \
    --bshl-color="#E2266Eff" \
    --ringver-color="#2080BBff" \
    --ringwrong-color="#E2266Eff" \
    --insidever-color="#21242Bcc" \
    --insidewrong-color="#21242Bcc" \
    --verif-color="#2080BBff" \
    --wrong-color="#E2266Eff" \
    --layout-color="#FFFFFFFF" \
    --time-color="#40A5DAff" \
    --date-color="#FFFFFFFF" \
    --greeter-color="#2080BBff" \
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
