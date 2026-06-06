INSERT OR REPLACE INTO videos (id, width, height, fps) VALUES ('wavey', 400, 400, 10) RETURNING id;

WITH RECURSIVE
  video AS (SELECT * FROM videos WHERE id = 'wavey'),
  _frames(frame) AS (
    SELECT 1 UNION ALL
    SELECT frame + 1 FROM _frames, video WHERE frame < 50
  )
INSERT INTO images (id, width, height, frame, video_id) SELECT CONCAT('wavey/', frame), width, height, frame, 'wavey' FROM _frames, video;

WITH RECURSIVE
  video AS (SELECT * FROM videos WHERE id = 'wavey'),
  horizontal(x) AS (SELECT width FROM video UNION ALL SELECT x - 1 FROM horizontal WHERE x > 1),
  vertical(y) AS (SELECT height FROM video UNION ALL SELECT y - 1 FROM vertical WHERE y > 1),
  _frames(id, frame) AS (SELECT id, frame FROM images WHERE video_id = (SELECT id FROM video)),
  _pixels(frame_id, x, y, r, g, b) AS
    (SELECT
      frames_id,
      x, y,
      ROUND(100 * value),
      ROUND(240 * value*value),
      ROUND(255 * value)
    FROM (SELECT *,
        (CASE
          WHEN SIN((x - 4.0*frame) / 20.0)*10.0 > y - 150 THEN 1.0
          WHEN SIN((x - 0.5*frame) / 20.0)*10.0 > y - 200 THEN 0.75
          WHEN SIN((x + 8.0*frame) / 20.0)*10.0 > y - 280 THEN 0.5
          ELSE 0.3
        END) AS value,
        _frames.id AS frames_id
      FROM vertical, horizontal, _frames)
  )
INSERT INTO pixels (image_id, x, y, r, g, b) SELECT frame_id, x, y, r, g, b FROM _pixels;
