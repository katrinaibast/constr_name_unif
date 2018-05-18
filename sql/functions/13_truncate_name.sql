CREATE OR REPLACE FUNCTION truncate_name(name TEXT, character_count INT)
  RETURNS TEXT AS $$
DECLARE
  result VARCHAR := '';
BEGIN
  IF (LENGTH(name) > character_count AND (LENGTH(name) - character_count >= 3))
  THEN
    result := SUBSTRING(name FROM 1 FOR (LENGTH(name) - character_count));
  ELSE
    result := name;
  END IF;

  RETURN TRIM(trailing '_' from result);
END;
$$ LANGUAGE plpgsql;
