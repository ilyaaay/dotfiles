#!/bin/bash
grim /tmp/lockscreen.png
magick /tmp/lockscreen.png -blur 0x8 -brightness-contrast -10 /tmp/lockscreen-blur.png
swaylock -f -i /tmp/lockscreen-blur.png
