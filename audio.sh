#!/usr/bin/env sh

set -eu -o pipefail

[ $# -lt 1 ] && echo "Fuck" && exit 1;
AUDIO_TRACK_ID="$1"
DB="${2:-fun.db}"

db() { sqlite3 -tabs -noheader "$DB" "$@"; }

samples() {
  audio_track_id="$1"
  db "SELECT value FROM audio_track_samples WHERE audio_track_id='$audio_track_id' ORDER BY position ASC"
}

to_pcm() {
  awk '{printf "%02x\n", $1}' | xxd -r -p
}

play() {
  format="$1"
  sample_rate="$2"
  ffplay -f "$format" -ar "$sample_rate" -b:a 128K -ch_layout mono -autoexit -
}

to_mp3() {
  id="$1"
  format="$2"
  sample_rate="$3"
  ffmpeg -y -f "$format" -ar "$sample_rate" -ch_layout mono -i - -b:a 192k "media/$id.mp3"
}

to_mp4() {
  id="$1"
  format="$2"
  sample_rate="$3"
  ffmpeg -y -f "$format" -ar "$sample_rate" -ch_layout mono -i - -b:a 192k -c:v copy -c:a aac "media/$id.mp4"
}

track_info() {
  local audio_id="$1"
  db "SELECT format, sample_rate FROM audio_tracks WHERE id='$audio_id'"
}


# ## Main stuff

data="$(track_info "$AUDIO_TRACK_ID")"
format="$(echo "$data" | cut -f1)"
sample_rate="$(echo "$data" | cut -f2)"

echo "-----------$data--------"

samples "$AUDIO_TRACK_ID" | to_pcm | \
  tee >(to_mp3 "$AUDIO_TRACK_ID" "$format" "$sample_rate") | \
  tee >(to_mp4 "$AUDIO_TRACK_ID" "$format" "$sample_rate") | \
  play "$format" "$sample_rate"

echo ""
echo "Done"
