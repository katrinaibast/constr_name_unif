CREATE OR REPLACE FUNCTION abbreviate_table_name(table_n TEXT, schema_n TEXT)
  RETURNS TEXT AS $$
DECLARE
  table_name_components VARCHAR [];
  component             VARCHAR;
  result                VARCHAR := '';
BEGIN
  table_name_components := REGEXP_SPLIT_TO_ARRAY(table_n, '_');
  FOREACH component IN ARRAY table_name_components
  LOOP
    result := result || SUBSTRING(component FROM 1 FOR 1);
  END LOOP;
  PERFORM add_to_abbreviated_tables(table_n, result, schema_n);
  RETURN result;
END;
$$ LANGUAGE plpgsql;
