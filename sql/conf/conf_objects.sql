CREATE TABLE pattern (
  pattern_id             SERIAL PRIMARY KEY,
  pattern_name           VARCHAR UNIQUE NOT NULL,
  delimiter              VARCHAR(1),
  has_suffix             BOOLEAN        NOT NULL,
  has_short_abbreviation BOOLEAN        NOT NULL
);


INSERT INTO pattern
(pattern_name, delimiter, has_suffix, has_short_abbreviation)
VALUES
  ('postgresql_default', '_', TRUE, FALSE);


INSERT INTO pattern
(pattern_name, delimiter, has_suffix, has_short_abbreviation)
VALUES
  ('snake_case_with_short_prefix', '_', FALSE, TRUE);


CREATE TYPE CONSTRAINT_TYPE AS (constraint_name VARCHAR, constraint_type VARCHAR, table_name VARCHAR, constraint_schema VARCHAR, column_name VARCHAR, references_table VARCHAR);


CREATE TABLE abbreviated_table (
  abbreviated_table_name_id SERIAL PRIMARY KEY,
  table_name                VARCHAR NOT NULL UNIQUE,
  abbreviated_name          VARCHAR NOT NULL,
  schema_name               VARCHAR NOT NULL
);
