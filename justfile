DB := "fun.db"

setup: reset-db

run file *args:
  sqlite3 "{{DB}}" {{args}} < "{{file}}"

image file *args:
  #!/usr/bin/env sh
  set -eu
  image_id=$(just run "{{file}}" {{args}})
  just show-image "$image_id"

show-image image_id:
  echo "Displaying {{image_id}}" 1>&2
  ./image.sh {{image_id}} | tee output.ignore.txt | magick display ppm:-

repl *args:
  rlwrap sqlite3 "{{DB}}" {{args}}

reset-db:
  rm "{{DB}}"
  sqlite3 "{{DB}}" < setup.sql
