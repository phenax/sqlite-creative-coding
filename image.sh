#!/usr/bin/env sh

DB=fun.db

[ $# -lt 1 ] && echo "Fuck" && exit 1;

db() { sqlite3 -list "$DB" "$@"; }

image_id="$1"
echo "P3"
db "SELECT width, height FROM images WHERE id=$image_id" | awk -F'|' '{ print $1 " " $2 }'
echo "255"
db "SELECT r,g,b FROM pixels WHERE image_id=$image_id ORDER BY y ASC, x ASC" | tr '|' ' '
