PRAGMA foreign_keys = ON;

DROP TABLE question_follows;
DROP TABLE question_likes;
DROP TABLE replies;
DROP TABLE questions;
DROP TABLE users;

CREATE TABLE users(
  id INTEGER PRIMARY KEY,
  fname VARCHAR NOT NULL,
  lname VARCHAR NOT NULL);

CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  title VARCHAR,
  body VARCHAR,
  author_id INTEGER,

  FOREIGN KEY (author_id) REFERENCES users(id)
);


CREATE TABLE question_follows(
  id INTEGER PRIMARY KEY,
  follower_id INTEGER,
  question_id INTEGER,

  FOREIGN KEY (follower_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies(
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  parent_reply_id INTEGER,
  body VARCHAR NOT NULL,
  user_id INT NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes(
id INTEGER PRIMARY KEY,
author_id INTEGER,
question_id INTEGER,

FOREIGN KEY (author_id) REFERENCES users(id),
FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO users(fname, lname)
VALUES ('Ryan', 'Guthrie'),
        ('Theo', 'Brown');

INSERT INTO questions(title, body, author_id)
VALUES ('rail?', 'how does rails work?', 2),
        ('pizza', 'what kind of pizza will I eat today', 1);

INSERT INTO question_follows(follower_id, question_id)
VALUES (2,2),
        (1,1);

INSERT INTO replies(question_id, parent_reply_id, body, user_id)
  VALUES(1, NULL, 'still havent figured it out', 2),
        (1, 1, 'its just ruby magic', 1);

INSERT INTO question_likes(author_id, question_id)
  VALUES(1, 1),
        (2, 1);

