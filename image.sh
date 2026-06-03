#!/usr/bin/env sh

set -eu

db() { sqlite3 -tabs -noheader "$DB" "$@"; }

ppm() {
  image_id="$1"
  echo "P3"
  db "SELECT width, height FROM images WHERE id='$image_id'"
  echo "255"
  db "SELECT r,g,b FROM pixels WHERE image_id='$image_id' ORDER BY y ASC, x ASC"
}

save_png() { magick ppm:- "media/$1.png"; }

display() { magick display ppm:-; }


[ $# -lt 1 ] && echo "Fuck" && exit 1;
image_id="$1"
DB="${2:-fun.db}"

ppm "$image_id" | tee >(save_png "$image_id") | display
