CREATE OR REPLACE FUNCTION truncate_names(names TEXT [], character_count INT)
  RETURNS TEXT AS $$
DECLARE
  name_count       INTEGER;
  truncate_each_by INTEGER;
  min_name_length  INTEGER := 9999;
  name             VARCHAR;
  result           VARCHAR := '';
BEGIN
  FOREACH name IN ARRAY names
  LOOP
    IF LENGTH(name) < min_name_length
    THEN
      min_name_length = LENGTH(name);
    END IF;
  END LOOP;

  name_count := ARRAY_LENGTH(names, 1);
  truncate_each_by := CEIL(character_count :: DECIMAL / name_count);

  IF min_name_length < truncate_each_by
  THEN
    truncate_each_by := CEIL(truncate_each_by :: DECIMAL + truncate_each_by / 2);
  END IF;

  FOREACH name IN ARRAY names
  LOOP
    IF (LENGTH(name) > truncate_each_by AND (LENGTH(name) - truncate_each_by >= 3))
    THEN
      result := result || ',' || SUBSTRING(name FROM 1 FOR (LENGTH(name) - truncate_each_by));
    ELSE
      result := result || ',' || name;
    END IF;
  END LOOP;
  RETURN result;
END;
$$ LANGUAGE plpgsql;
