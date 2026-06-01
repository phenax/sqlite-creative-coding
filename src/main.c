#include <sqlite3.h>
#include <stdio.h>

int main(void) {
  sqlite3 *db;

  sqlite3_open("fun.db", &db);
  if (db == NULL) {
    printf("Unable to open db\n");
    return 1;
  }

  printf("Foobar\n");

  sqlite3_close(db);
  return 0;
}
