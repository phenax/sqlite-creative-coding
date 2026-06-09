INSERT OR REPLACE INTO audio_tracks (id, sample_rate, format) VALUES ('supermariobros', 8000, 'u8') RETURNING id;

WITH RECURSIVE
  audio AS (SELECT *, 250 AS n, 100 AS total_tones, 160 AS gain FROM audio_tracks WHERE id = 'supermariobros'),
  notes AS (SELECT 659.225 AS E5, 523.2511 AS C5, 783.9909 AS G5, 391.9954 AS G4),
  tone(position) AS (SELECT 0 UNION ALL SELECT position + 1 FROM tone, audio WHERE position < total_tones * n),
  _samples(value, position) AS (
    SELECT
      (CASE
        WHEN position < 5*n THEN position * E5
        WHEN position < 6*n THEN 0
        WHEN position < 11*n THEN position * E5
        WHEN position < 17*n THEN 0
        WHEN position < 22*n THEN position * E5
        WHEN position < 28*n THEN 0
        WHEN position < (28+5)*n THEN position * C5
        WHEN position < (28+6)*n THEN 0
        WHEN position < (28+11)*n THEN position * E5
        WHEN position < (28+17)*n THEN 0
        WHEN position < (28+22)*n THEN position * G5
        WHEN position < (28+39)*n THEN 0
        WHEN position < (28+39+5)*n THEN position * G4
        ELSE 0
      END) AS value,
      position
    FROM tone, notes, audio
  ),
  samples(value, position) AS (
    SELECT MOD(FLOOR(value * 2.0 / sample_rate), 2) * gain, position
    FROM _samples, audio
  )
-- SELECT value FROM samples ORDER BY position;
INSERT INTO audio_track_samples (audio_track_id, value, position) SELECT 'supermariobros', value, position FROM samples ORDER BY position;
