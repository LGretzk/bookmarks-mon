CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60));

INSERT INTO bookmarks
VALUES ('1', 'http://www.makersacademy.com/'),
  ('2', 'http://www.askjeeves.com/'),
  ('3', 'http://www.twitter.com/'),
  ('4', 'http://www.google.com/');


-- SELECT * FROM bookmarks;

-- DELETE FROM bookmarks
-- WHERE id='2';

-- UPDATE bookmarks
-- SET url='http://www.destroyallsoftware.com' 
-- WHERE id='3';