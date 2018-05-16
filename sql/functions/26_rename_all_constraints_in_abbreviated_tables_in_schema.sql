CREATE OR REPLACE FUNCTION rename_all_constraints_in_abbreviated_tables_in_schema(pattern_name TEXT, schema_n TEXT)
  RETURNS VOID AS $$
DECLARE
  table_row      ABBREVIATED_TABLE;
  constraint_row CONSTRAINT_TYPE;
BEGIN
  FOR table_row IN (SELECT *
                    FROM get_abbreviated_tables()) LOOP
    FOR constraint_row IN (SELECT *
                           FROM get_all_constraints_in_schema(schema_n)
                           WHERE table_name = table_row.table_name) LOOP

      PERFORM generate_new_name_and_rename_constraint(constraint_row, pattern_name, TRUE);
    END LOOP;
  END LOOP;
  PERFORM empty_abbreviated_tables();
END;
$$ LANGUAGE plpgsql;
