INSERT OR REPLACE INTO images (id, width, height) VALUES ('gradient', 400, 400) RETURNING id;

WITH RECURSIVE
  image AS (SELECT * FROM images WHERE id = 'gradient'),
  horizontal(x) AS
    (SELECT width FROM image UNION ALL SELECT x - 1 FROM horizontal WHERE x > 1),
  vertical(y) AS
    (SELECT height FROM image UNION ALL SELECT y - 1 FROM vertical WHERE y > 1),
  _pixels(x, y, r, g, b) AS
    (SELECT x, y, x*255/width, y*255/height, 100 FROM vertical, horizontal, image)
INSERT INTO pixels (image_id, x, y, r, g, b) SELECT 'gradient', x, y, r, g, b FROM _pixels;
