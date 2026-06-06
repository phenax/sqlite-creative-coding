#!/usr/bin/env sh

set -eu

[ $# -lt 1 ] && echo "Fuck" && exit 1;
VIDEO_ID="$1"
DB="${2:-fun.db}"

db() { sqlite3 -tabs -noheader "$DB" "$@"; }

frame_ppm() {
  local image_id="$1"
  echo "P3"
  db "SELECT width, height FROM images WHERE id='$image_id'"
  echo "255"
  db "SELECT r,g,b FROM pixels WHERE image_id='$image_id' ORDER BY y ASC, x ASC"
}

video_info() {
  local video_id="$1"
  db "SELECT fps FROM videos WHERE id='$video_id'"
}

video_frames() {
  local video_id="$1"
  db "SELECT id FROM images WHERE video_id='$video_id' ORDER BY frame ASC" | while IFS= read image_id; do
    frame_ppm "$image_id";
  done;
}

save_video() {
  local id="$1"
  local fps="$2"
  ffmpeg -y -f image2pipe -framerate "$fps" -i pipe:0 "media/$id.gif"
}

display() {
  local fps="$1";
  ffplay - -framerate "$fps" -autoexit;
}

## Main stuff

data="$(video_info "$VIDEO_ID")"
fps="$data"

video_frames "$VIDEO_ID" | tee >(save_video "$VIDEO_ID" "$fps") | display "$fps"
