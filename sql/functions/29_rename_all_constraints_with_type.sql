CREATE OR REPLACE FUNCTION rename_all_constraints(pattern_name TEXT, type TEXT)
  RETURNS VOID AS $$
DECLARE
  constraint_row CONSTRAINT_TYPE;
BEGIN
  FOR constraint_row IN (SELECT *
                         FROM get_all_constraints(type)) LOOP
    PERFORM generate_new_name_and_rename_constraint(constraint_row, pattern_name, FALSE);
  END LOOP;
  PERFORM rename_all_constraints_in_abbreviated_tables(pattern_name, type);
END;
$$ LANGUAGE plpgsql;
