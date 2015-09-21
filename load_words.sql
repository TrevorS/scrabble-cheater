BEGIN;

CREATE TEMPORARY TABLE temp_words (name text);

COPY
  temp_words (name)
FROM
  '/usr/share/dict/words';

DELETE FROM words;

INSERT INTO
  words (name, sorted_name, inserted_at, updated_at)
SELECT
  name,
  (SELECT
    ARRAY_TO_STRING(
      ARRAY(
        SELECT
          REGEXP_SPLIT_TO_TABLE(name, '') AS letters
        ORDER BY
          letters ASC
      ),
      ''
    )),
  current_timestamp,
  current_timestamp
FROM
  temp_words
WHERE
  char_length(name) > 1
AND
  lower(name) = name;

DROP TABLE temp_words;

COMMIT;
