#!/bin/bash

#rtsp://yourip:8554/stream

if $ENABLE_VIDEO
then ffmpeg -loglevel error -video_size "${DISPLAY_WIDTH}x${DISPLAY_HEIGHT}" -framerate 30 -f x11grab -i $DISPLAY -f pulse -ac 2 -i default -vcodec libx264 -crf 28 -acodec libmp3lame -f rtsp $RTSP_URL
else ffmpeg -loglevel error -f pulse -ac 2 -i default -acodec libmp3lame -f rtsp $RTSP_URL
fi