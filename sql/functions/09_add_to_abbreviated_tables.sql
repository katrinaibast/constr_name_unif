CREATE OR REPLACE FUNCTION add_to_abbreviated_tables(table_n          TEXT,
                                                     abbreviated_name TEXT,
                                                     schema_n         TEXT)
  RETURNS VOID AS $$
BEGIN
  IF
  (SELECT count(*)
   FROM abbreviated_table
   WHERE table_name = table_n AND schema_name = schema_n) = 0
  THEN
    INSERT INTO abbreviated_table (table_name, abbreviated_name, schema_name)
    VALUES
      (QUOTE_IDENT(table_n), QUOTE_IDENT(abbreviated_name), QUOTE_IDENT(schema_n));
  END IF;

END;
$$ LANGUAGE plpgsql;
