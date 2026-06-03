PRAGMA foreign_keys = ON;
PRAGMA temp_store = MEMORY;

CREATE TABLE images (
  id TEXT PRIMARY KEY,
  width INTEGER NOT NULL,
  height INTEGER NOT NULL
);

CREATE TABLE pixels (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  image_id TEXT NOT NULL,
  x INTEGER NOT NULL,
  y INTEGER NOT NULL,
  r INTEGER NOT NULL CHECK(r >= 0 AND r <= 255),
  g INTEGER NOT NULL CHECK(g >= 0 AND g <= 255),
  b INTEGER NOT NULL CHECK(b >= 0 AND b <= 255),
  FOREIGN KEY(image_id) REFERENCES images(id),
  UNIQUE(image_id, x, y)
);

CREATE TRIGGER delete_pixels_when_image_deleted
AFTER DELETE ON images
WHEN (SELECT COUNT(*) FROM images WHERE id = OLD.id) = 0
BEGIN
  DELETE FROM pixels WHERE image_id = OLD.id;
END;
