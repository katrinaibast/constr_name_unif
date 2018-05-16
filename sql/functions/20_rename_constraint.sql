CREATE OR REPLACE FUNCTION rename_constraint(_table_n REGCLASS, old_name TEXT, new_name TEXT)
  RETURNS VOID AS $$
BEGIN
  EXECUTE 'ALTER TABLE ' || _table_n || ' RENAME CONSTRAINT ' || QUOTE_IDENT(old_name) || ' TO ' || QUOTE_IDENT(new_name);
END;
$$ LANGUAGE plpgsql;
