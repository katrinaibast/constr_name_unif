CREATE OR REPLACE FUNCTION get_new_name(type                      TEXT,
                                        pattern_name              TEXT,
                                        old_name                  TEXT,
                                        schema_n                  TEXT,
                                        table_n                   TEXT,
                                        column_names              TEXT,
                                        foreign_table_n           TEXT DEFAULT NULL,
                                        is_table_name_abbreviated BOOLEAN DEFAULT FALSE)
  RETURNS TEXT AS $$
DECLARE
  pattern                         PATTERN;
  abbreviation                    TEXT;
  result                          TEXT;
  name_length                     INTEGER;
  columns                         VARCHAR [];
  col                             VARCHAR;
  max_constraint_length           INTEGER := 63;
  constraint_name_count_in_schema INTEGER;
  constraint_name_count_in_table  INTEGER;
  truncate_by                     INTEGER;
BEGIN
  SELECT *
  INTO pattern
  FROM get_pattern(pattern_name);

  IF pattern IS NULL
  THEN
    RAISE EXCEPTION 'There is no such pattern!';
  END IF;

  abbreviation := get_constraint_abbreviation(type, pattern.has_short_abbreviation);

  FOREACH col IN ARRAY REGEXP_SPLIT_TO_ARRAY(column_names, ',')
  LOOP
    columns := ARRAY_APPEND(columns, col);
  END LOOP;

  result := table_n;

  IF type = 'FOREIGN KEY'
  THEN
    IF LENGTH(foreign_table_n) > 0
    THEN
      result := result || pattern.delimiter || foreign_table_n;
    END IF;
  END IF;

  IF type != 'PRIMARY KEY'
  THEN
    FOREACH col IN ARRAY columns
    LOOP
      IF LENGTH(col) > 0
      THEN
        result := result || pattern.delimiter || col;
      END IF;
    END LOOP;
  END IF;

  IF pattern.has_suffix = TRUE
  THEN
    result := result || pattern.delimiter || abbreviation;
  ELSE
    result := abbreviation || pattern.delimiter || result;
  END IF;

  name_length := get_name_length(result);

  IF name_length > max_constraint_length
  THEN
    IF is_table_name_abbreviated = FALSE
    THEN
      result := get_new_name(type, pattern_name, old_name, schema_n, abbreviate_table_name(table_n, schema_n),
                             column_names, foreign_table_n, TRUE);
    ELSE
      IF type = 'FOREIGN KEY'
      THEN
        truncate_by := CEIL((name_length - max_constraint_length) :: DECIMAL / 2);
        result := get_new_name(type, pattern_name, old_name, schema_n, table_n,
                               truncate_names(columns, truncate_by),
                               truncate_name(foreign_table_n, truncate_by),
                               TRUE);
      ELSE
        result := get_new_name(type, pattern_name, old_name, schema_n, table_n,
                               truncate_names(columns, name_length - max_constraint_length),
                               foreign_table_n,
                               TRUE);
      END IF;
    END IF;
  END IF;

  constraint_name_count_in_schema := get_constraint_name_count(result, schema_n);
  constraint_name_count_in_table := get_constraint_name_count(result, schema_n, table_n);

  IF type = 'PRIMARY KEY' AND constraint_name_count_in_schema != 0 AND result != old_name
  THEN
    result := rename_constraint_with_same_name(result, pattern.delimiter || abbreviation, pattern.has_suffix,
                                               constraint_name_count_in_schema + 1);
  ELSIF constraint_name_count_in_table != 0 AND result != old_name
    THEN
      result := rename_constraint_with_same_name(result, pattern.delimiter || abbreviation, pattern.has_suffix,
                                                 constraint_name_count_in_table + 1);
  END IF;
  RETURN result;
END;
$$ LANGUAGE plpgsql;
