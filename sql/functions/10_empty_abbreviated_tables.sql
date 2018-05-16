CREATE OR REPLACE FUNCTION empty_abbreviated_tables()
  RETURNS VOID AS $$
BEGIN
  DELETE FROM abbreviated_table;
END;
$$ LANGUAGE plpgsql;