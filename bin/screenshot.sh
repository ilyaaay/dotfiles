#!/bin/bash
case "$1" in
    full)
        grim - | swappy -f -
        ;;
    area)
        grim -g "$(slurp)" - | swappy -f -
        ;;
    window)
        grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" - | swappy -f -
        ;;
    *)
        echo "Usage: screenshot.sh {full|area|window}"
        exit 1
        ;;
esac
