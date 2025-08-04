
CREATE TABLE molecula (
  `id` INTEGER PRIMARY KEY,
  `uid` TEXT NOT NULL,
  `name` TEXT NOT NULL,
  `z1` TEXT DEFAULT NULL,
  `term` TEXT NOT NULL,
  `another_names` TEXT DEFAULT '[]'
);
