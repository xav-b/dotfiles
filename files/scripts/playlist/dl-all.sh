#! /usr/bin/env bash

# unofficial strict mode
set -eo pipefail

YT_DEST="./downloads"
YT_PLAYLIST="$1"
YT_QUALITY=${2:-5}
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

_log() {
    printf "[${CYAN} $(date '+%H:%M:%S') ${NC}] yt-dl: ${YELLOW} $@ ${NC}\n"
}

_log "reading from playlist: ${YT_PLAYLIST}"
_log "audio quality: ${YT_QUALITY}"

videos=()
while IFS= read -r line; do
  videos+=("$line")
done < "$YT_PLAYLIST"

for video in "${videos[@]}"; do
    # partials=$(echo $video | tr "," "\n")
    # Set space as the delimiter
    OIFS=$IFS
    IFS=','
    #Read the split words into an array based on space delimiter
    read -a partials <<< "$video"
    IFS=$OIFS
    _log "downloading youtube video id #${partials[1]}: ${partials[0]}"

    youtube-dl --continue --no-overwrites --ignore-errors \
      --extract-audio \
      --audio-quality "$YT_QUALITY" \
      --audio-format mp3 \
      --output "${YT_DEST}/%(title)s.%(ext)s" \
      "https://www.youtube.com/watch?v=${partials[1]}"
done

_log "download complete (status: $?)"
