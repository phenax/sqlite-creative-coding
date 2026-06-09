PRAGMA foreign_keys = ON;
PRAGMA temp_store = MEMORY;

CREATE TABLE images (
  id TEXT PRIMARY KEY,
  width INTEGER NOT NULL,
  height INTEGER NOT NULL,
  video_id TEXT,
  frame INTEGER DEFAULT 0,
  FOREIGN KEY(video_id) REFERENCES videos(id) ON DELETE CASCADE
);

CREATE TABLE videos (
  id TEXT PRIMARY KEY,
  width INTEGER NOT NULL,
  height INTEGER NOT NULL,
  fps INTEGER NOT NULL
);

CREATE TABLE pixels (
  id INTEGER PRIMARY KEY,
  image_id TEXT NOT NULL,
  x INTEGER NOT NULL,
  y INTEGER NOT NULL,
  r INTEGER NOT NULL CHECK(r >= 0 AND r <= 255),
  g INTEGER NOT NULL CHECK(g >= 0 AND g <= 255),
  b INTEGER NOT NULL CHECK(b >= 0 AND b <= 255),
  FOREIGN KEY(image_id) REFERENCES images(id) ON DELETE CASCADE,
  UNIQUE(image_id, x, y)
);

CREATE TABLE audio_tracks (
  id TEXT PRIMARY KEY,
  sample_rate INTEGER NOT NULL,
  format TEXT NOT NULL
);
CREATE TABLE audio_track_samples (
  value INTEGER NOT NULL,
  position INTEGER NOT NULL,
  audio_track_id TEXT,
  FOREIGN KEY(audio_track_id) REFERENCES audio_tracks(id) ON DELETE CASCADE
);

CREATE TRIGGER delete_pixels_when_image_reinserted_because_i_said_so_and_to_make_rerunning_easier
BEFORE INSERT ON images
BEGIN
  DELETE FROM pixels WHERE image_id = NEW.id;
END;

CREATE TRIGGER delete_frames_when_video_reinserted_because_i_said_so_and_to_make_rerunning_easier
BEFORE INSERT ON videos
BEGIN
  DELETE FROM images WHERE video_id = NEW.id;
END;

CREATE TRIGGER delete_samples_when_track_reinserted_because_i_said_so_and_to_make_rerunning_easier
BEFORE INSERT ON audio_tracks
BEGIN
  DELETE FROM audio_track_samples WHERE audio_track_id = NEW.id;
END;

