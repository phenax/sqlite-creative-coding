set export

CC := "gcc"
CFLAGS := f"-std=c11 -O2 \
-Wall -Wextra -Wshadow -Wformat=2 -fsanitize=address,undefined \
{{shell('pkg-config --cflags --libs sqlite3')}}"
OUTDIR := "build"

build: compile-flags
  mkdir -p "{{OUTDIR}}"
  {{CC}} {{CFLAGS}} src/*.c -o "{{OUTDIR}}/sqlheavy"

run: build
  "./{{OUTDIR}}/sqlheavy"

@compile-flags:
  echo '{{CFLAGS}}' | tr ' ' '\n' > ./compile_flags.txt

format:
  find src/ -iname '*.h' -o -iname '*.c' | xargs clang-format -i

