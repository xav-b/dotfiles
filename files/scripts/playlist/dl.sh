#! /usr/bin/env bash

# unofficial strict mode
set -eo pipefail

YT_VIDEO_ID="$1"
YT_QUALITY=${2:-5}

echo -e "[yt-dl] downloading youtube id #${YT_VIDEO_ID}"
echo -e "[yt-dl] audio quality: ${YT_QUALITY}"

youtube-dl \
  --extract-audio \
  --audio-quality "$YT_QUALITY" \
  --audio-format mp3 \
  --output "%(title)s.%(ext)s" \
  "https://www.youtube.com/watch?v=${YT_VIDEO_ID}"
