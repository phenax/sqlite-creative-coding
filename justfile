setup: setup-db

run file *args: setup-db
  sqlite3 fun.db {{args}} < {{file}}

image image_id:
  ./image.sh {{image_id}} | magick display -resize 500% -

repl *args:
  rlwrap sqlite3 fun.db {{args}}

setup-db:
  rm fun.db
  sqlite3 fun.db < setup.sql
