INSERT OR REPLACE INTO audio_tracks (id, sample_rate, format) VALUES ('spectrogramming', 8000, 'u8') RETURNING id;

WITH RECURSIVE
  audio AS
    (SELECT *, 160 AS gain FROM audio_tracks WHERE id = 'spectrogramming'),
  note_positions(position) AS
    (SELECT 0 UNION ALL
      SELECT position + 1 FROM note_positions, audio
        WHERE position < 100000),
  samples(value, position) AS
    (SELECT
      (100.0*SIN(position * 2.0 / sample_rate) + 1.0) / 2.0 * gain
      , position
    FROM note_positions, audio)
INSERT INTO audio_track_samples (audio_track_id, value, position) SELECT 'spectrogramming', value, position FROM samples ORDER BY position;
