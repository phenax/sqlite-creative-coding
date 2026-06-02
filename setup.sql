PRAGMA foreign_keys = ON;
PRAGMA temp_store = 2;

CREATE TABLE images (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  width INTEGER NOT NULL,
  height INTEGER NOT NULL
);

CREATE TABLE pixels (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  image_id INTEGER NOT NULL,
  x INTEGER NOT NULL,
  y INTEGER NOT NULL,
  r INTEGER NOT NULL CHECK(r >= 0 AND r <= 255),
  g INTEGER NOT NULL CHECK(g >= 0 AND g <= 255),
  b INTEGER NOT NULL CHECK(b >= 0 AND b <= 255),
  FOREIGN KEY(image_id) REFERENCES images(id),
  UNIQUE(image_id, x, y)
);

INSERT INTO images (id, width, height) VALUES (1, 6, 6);

INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 1, 1, 0, 255, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 2, 1, 0, 255, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 3, 1, 0, 255, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 4, 1, 0, 255, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 5, 1, 0, 255, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 6, 1, 0, 255, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 1, 2, 0, 255, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 2, 2, 0, 255, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 3, 2, 0, 255, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 4, 2, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 5, 2, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 6, 2, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 1, 3, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 2, 3, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 3, 3, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 4, 3, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 5, 3, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 6, 3, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 1, 4, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 2, 4, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 3, 4, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 4, 4, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 5, 4, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 6, 4, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 1, 5, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 2, 5, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 3, 5, 255, 0, 0);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 4, 5, 0, 0, 255);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 5, 5, 0, 0, 255);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 6, 5, 0, 0, 255);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 1, 6, 0, 0, 255);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 2, 6, 0, 0, 255);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 3, 6, 0, 0, 255);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 4, 6, 0, 0, 255);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 5, 6, 0, 0, 255);
INSERT INTO pixels (image_id, x, y, r, g, b) VALUES (1, 6, 6, 0, 0, 255);
