DB := "fun.db"

setup: reset-db

run file *args:
  sqlite3 "{{DB}}" {{args}} < "{{file}}"

image file *args:
  #!/usr/bin/env sh
  set -eu
  image_id=$(just run "{{file}}" {{args}})
  just gen-image "$image_id"

gen-image image_id:
  echo "Displaying {{image_id}}" 1>&2
  ./image.sh "{{image_id}}"

video file *args:
  #!/usr/bin/env sh
  set -eu
  video_id=$(just run "{{file}}" {{args}})
  just gen-video "$video_id"

gen-video video_id:
  echo "Displaying {{video_id}}" 1>&2
  ./video.sh "{{video_id}}"

repl *args:
  rlwrap sqlite3 "{{DB}}" {{args}}

reset-db:
  rm "{{DB}}"
  sqlite3 "{{DB}}" < setup.sql
