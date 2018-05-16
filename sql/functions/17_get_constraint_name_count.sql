CREATE OR REPLACE FUNCTION get_constraint_name_count(constraint_n TEXT, schema_n TEXT)
  RETURNS INT AS $$
BEGIN
  RETURN (SELECT COUNT(*) :: INT
          FROM get_all_constraints()
          WHERE remove_numbers_from_name(CONSTRAINT_NAME) = remove_numbers_from_name(constraint_n)
                AND constraint_schema = schema_n);
END;
$$ LANGUAGE plpgsql;
