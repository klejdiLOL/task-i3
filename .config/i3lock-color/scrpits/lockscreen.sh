#!/bin/bash
# ── CONFIG ────────────────────────────────────────────

# Bold Fonts – adjust these if your system uses different naming conventions
BOLD_FONT1="JetBrainsMono Nerd Font Bold"
BOLD_FONT2="Liberation Mono Bold"
BOLD_FONT3="Noto Sans Mono Bold"

# Screenshot path
IMG="/tmp/i3lock_blur.png"

# ── DYNAMIC FONT SIZE CALCULATION ───────────────────

# Get screen resolution width (requires xrandr)
SCREEN_WIDTH=$(xrandr | grep '*' | awk '{print $1}' | head -n1 | cut -d 'x' -f1)
# Define a base width for scaling (modify if needed)
BASE_WIDTH=1920
# Calculate scaling factor (e.g., for a 1280px wide screen, scale ≈ 0.66)
SCALE=$(echo "scale=2; $SCREEN_WIDTH / $BASE_WIDTH" | bc)

# Base font sizes for a 1920-wide display
BASE_TIME_SIZE=48
BASE_DATE_SIZE=24
BASE_LAYOUT_SIZE=20
BASE_GREETER_SIZE=32
BASE_VERIF_SIZE=20
BASE_WRONG_SIZE=20

# Calculate new sizes (rounded to an integer)
TIME_SIZE=$(printf "%.0f" $(echo "$BASE_TIME_SIZE * $SCALE" | bc))
DATE_SIZE=$(printf "%.0f" $(echo "$BASE_DATE_SIZE * $SCALE" | bc))
LAYOUT_SIZE=$(printf "%.0f" $(echo "$BASE_LAYOUT_SIZE * $SCALE" | bc))
GREETER_SIZE=$(printf "%.0f" $(echo "$BASE_GREETER_SIZE * $SCALE" | bc))
VERIF_SIZE=$(printf "%.0f" $(echo "$BASE_VERIF_SIZE * $SCALE" | bc))
WRONG_SIZE=$(printf "%.0f" $(echo "$BASE_WRONG_SIZE * $SCALE" | bc))

# Optional debug info
echo "Screen width: $SCREEN_WIDTH, Scale: $SCALE"
echo "Font sizes: Time=$TIME_SIZE, Date=$DATE_SIZE, Layout=$LAYOUT_SIZE, Greeter=$GREETER_SIZE, Verif=$VERIF_SIZE, Wrong=$WRONG_SIZE"

# ── SETUP: CAPTURE AND BLUR SCREEN ───────────────────

# Capture the current screen and blur it (using ImageMagick)
import -window root "$IMG"
# For IMv7+, use "magick" (instead of the deprecated "convert")
magick "$IMG" -blur 0x8 "$IMG"

# Kill any lingering processes (e.g., any old sound listeners)
pkill -f "aplay.*click.wav" 2>/dev/null
pkill -f "evtest" 2>/dev/null

# ── LOCKSCREEN ─────────────────────────────────────────

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
    --greeter-pos="ix:iy-40" \
    --time-pos="ix:iy-10" \
    --date-pos="ix:iy+30" \
    --layout-pos="ix:iy+60" \
    --verif-pos="ix:iy+60" \
    --wrong-pos="ix:iy+60"
