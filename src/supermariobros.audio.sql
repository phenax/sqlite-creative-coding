INSERT OR REPLACE INTO audio_tracks (id, sample_rate, format) VALUES ('supermariobros', 8000, 'u8') RETURNING id;

WITH RECURSIVE
  audio AS
    (SELECT *, 250 AS n, 160 AS gain FROM audio_tracks WHERE id = 'supermariobros'),
  notes AS (SELECT
    440.0000 AS A4,
    493.8833 AS B4,
    466.1638 AS Bflat4,
    391.9954 AS G4,
    261.6256 AS C4,
    329.6276 AS E4,
    523.2511 AS C5,
    783.9909 AS G5,
    659.2250 AS E5),
  melody(m_id, mduration, mnote) AS
    (SELECT ROW_NUMBER() OVER () as m_id, * FROM (VALUES
      (5,  (SELECT E5 FROM notes))    , (1,  0),
      (5,  (SELECT E5 FROM notes))    , (6,  0),
      (5,  (SELECT E5 FROM notes))    , (6,  0),
      (5,  (SELECT C5 FROM notes))    , (1,  0),
      (5,  (SELECT E5 FROM notes))    , (6,  0),
      (5,  (SELECT G5 FROM notes))    , (17, 0),
      (5,  (SELECT G4 FROM notes))    , (17, 0),
      (5,  (SELECT C5 FROM notes))    , (12, 0),
      (5,  (SELECT G4 FROM notes))    , (10, 0),
      (5,  (SELECT E4 FROM notes))    , (8,  0),
      (5,  (SELECT A4 FROM notes))    , (6,  0),
      (5,  (SELECT B4 FROM notes))    , (5,  0),
      (5,  (SELECT Bflat4 FROM notes)), (1,  0),
      (5,  (SELECT A4 FROM notes))    , (12,  0),
      -- (5,  (SELECT G4 FROM notes))    , (1,  0),
      (1,  0))),
  melody_with_offsets(mstart, mend, mnote) AS
    (SELECT
      SUM(mduration) OVER (ORDER BY m_id ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS mstart,
      SUM(mduration) OVER (ORDER BY m_id) AS mend,
      mnote
    FROM melody),
  tone(position) AS (SELECT 0 UNION ALL SELECT position + 1 FROM tone, audio WHERE position < (SELECT SUM(mduration) FROM melody) * n),
  _samples(value, position) AS
    (SELECT
      IFNULL(
  			(SELECT mnote * position FROM melody_with_offsets
          WHERE position BETWEEN IFNULL(mstart, 0) * n AND mend * n
          LIMIT 1),
      0) AS value,
      position
    FROM tone, notes, audio),
  samples(value, position) AS
    (SELECT MOD(FLOOR(value * 2.0 / sample_rate), 2) * gain, position
      FROM _samples, audio)
INSERT INTO audio_track_samples (audio_track_id, value, position) SELECT 'supermariobros', value, position FROM samples ORDER BY position;
