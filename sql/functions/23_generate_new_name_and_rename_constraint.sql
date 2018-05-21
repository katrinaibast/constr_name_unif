CREATE OR REPLACE FUNCTION generate_new_name_and_rename_constraint(constraint_row CONSTRAINT_TYPE,
                                                                   pattern_name   TEXT, is_table_name_abbreviated  BOOLEAN)
  RETURNS VOID AS $$
DECLARE
  new_name TEXT;
BEGIN
  IF constraint_row.references_table IS NULL
  THEN
    IF constraint_row.column_name IS NULL
    THEN
      new_name :=  get_new_name(constraint_row.constraint_type,
                                pattern_name,
                                constraint_row.constraint_name,
                                constraint_row.constraint_schema,
                                constraint_row.table_name,
                                '',
                                '',
                                is_table_name_abbreviated );
    ELSE
      new_name :=  get_new_name(constraint_row.constraint_type,
                                pattern_name,
                                constraint_row.constraint_name,
                                constraint_row.constraint_schema,
                                constraint_row.table_name,
                                constraint_row.column_name,
                                '',
                                is_table_name_abbreviated );
    END IF;
  ELSE
    new_name :=  get_new_name(constraint_row.constraint_type,
                              pattern_name,
                              constraint_row.constraint_name,
                              constraint_row.constraint_schema,
                              constraint_row.table_name,
                              constraint_row.column_name,
                              constraint_row.references_table,
                              is_table_name_abbreviated );
  END IF;
  IF new_name != constraint_row.constraint_name
  THEN
    PERFORM rename_constraint(constraint_row.constraint_schema || '.' || constraint_row.table_name,
                              constraint_row.constraint_name, new_name);
  END IF;
END;
$$ LANGUAGE plpgsql;
