#include <sqlite3.h>
#include <stdio.h>
#include <string.h>

typedef struct {
  int x;
  int y;
  int r;
  int g;
  int b;
} Pixel;

void show_pixels(Pixel *pixels, int len) {
  for (int i = 0; i < len; i++) {
    Pixel p = pixels[i];
    printf("%d %d %d\n", p.r, p.g, p.b);
  }
}

void show_image(Pixel *pixels, int len) {
  printf("P3\n");
  printf("%d %d\n", 6, 6);
  printf("%d\n", 255);
  show_pixels(pixels, len);
}

int main(void) {
  sqlite3 *db;

  sqlite3_open("fun.db", &db);
  if (db == NULL) {
    printf("Unable to open db\n");
    return 1;
  }

  sqlite3_stmt *stmt;
  sqlite3_prepare_v2(db,
                     "select x, y, r, g, b from pixels ORDER BY y ASC, x ASC",
                     -1, &stmt, NULL);

  Pixel pixels[200 * 200];
  int index = 0;

  while (sqlite3_step(stmt) != SQLITE_DONE) {
    int num_cols = sqlite3_column_count(stmt);
    Pixel pixel;
    for (int col = 0; col < num_cols; col++) {
      const char *name = sqlite3_column_name(stmt, col);
      if (strcmp(name, "x") == 0)
        pixel.x = sqlite3_column_int(stmt, col);
      else if (strcmp(name, "y") == 0)
        pixel.y = sqlite3_column_int(stmt, col);
      else if (strcmp(name, "r") == 0)
        pixel.r = sqlite3_column_int(stmt, col);
      else if (strcmp(name, "g") == 0)
        pixel.g = sqlite3_column_int(stmt, col);
      else if (strcmp(name, "b") == 0)
        pixel.b = sqlite3_column_int(stmt, col);
    }
    pixels[index++] = pixel;
  }
  int frames = 1;
  for (int i = 0; i < frames; i++)
    show_image(pixels, index);

  sqlite3_finalize(stmt);
  sqlite3_close(db);

  return 0;
}
