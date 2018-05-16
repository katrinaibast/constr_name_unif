CREATE OR REPLACE FUNCTION delete_pattern(name TEXT)
  RETURNS VOID AS $$
BEGIN
  DELETE FROM pattern
  WHERE pattern_name = name;
END;
$$ LANGUAGE plpgsql;
