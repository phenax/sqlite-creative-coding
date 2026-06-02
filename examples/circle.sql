CREATE TEMP TABLE variables(name TEXT PRIMARY KEY, value Text);

INSERT INTO images (width, height) VALUES (6, 6) RETURNING id;
INSERT INTO variables VALUES ('image_id', last_insert_rowid());

WITH RECURSIVE
  image_id AS (SELECT value FROM variables WHERE name = 'image_id'),
  horizontal(x) AS (
    SELECT width FROM images WHERE id = (SELECT * FROM image_id)
    UNION ALL
    SELECT x - 1 FROM horizontal
    WHERE x > 1
  ),
  vertical(y) AS (
    SELECT height FROM images WHERE id = (SELECT * FROM image_id)
    UNION ALL
    SELECT y - 1 FROM vertical
    WHERE y > 1
  ),
  pixels_temp(x, y, r, g, b) AS (
    SELECT x, y, 255, 0, 0 FROM vertical, horizontal
  )
INSERT INTO pixels (image_id, x, y, r, g, b) SELECT (SELECT * FROM image_id), x, y, r, g, b FROM pixels_temp;

DROP TABLE variables;
