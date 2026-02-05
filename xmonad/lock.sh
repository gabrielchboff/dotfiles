#!/bin/sh

# Ensure DISPLAY is set
export DISPLAY=${DISPLAY:-:0}

# Prevent multiple lock instances
if pgrep -f betterlockscreen >/dev/null; then
  exit 0
fi

betterlockscreen -l \
  --display 1 \
  --blur 0.8 \


