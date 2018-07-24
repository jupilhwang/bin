#!/bin/bash
ts=$(date +%s)
echo $ts
ffmpeg -f video4linux2 -s vga -i /dev/video0 -vframes 3 /home/jhwang/tmp/vid-$ts.%01d.jpg
exit 0
