CREATE OR REPLACE FUNCTION rename_all_constraints_in_schema(pattern_name TEXT, schema_n TEXT, type TEXT)
  RETURNS VOID AS $$
DECLARE
  constraint_row CONSTRAINT_TYPE;
BEGIN
  FOR constraint_row IN (SELECT *
                         FROM get_all_constraints_in_schema(schema_n, type)) LOOP
    PERFORM generate_new_name_and_rename_constraint(constraint_row, pattern_name, FALSE);
  END LOOP;
  PERFORM rename_all_constraints_in_abbreviated_tables_in_schema(pattern_name, schema_n, type);
END;
$$ LANGUAGE plpgsql;
