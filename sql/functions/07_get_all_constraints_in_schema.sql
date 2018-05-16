CREATE OR REPLACE FUNCTION get_all_constraints_in_schema(schema_n TEXT)
  RETURNS SETOF CONSTRAINT_TYPE AS $$
SELECT *
FROM get_all_constraints()
WHERE constraint_schema = LOWER(schema_n);
$$ LANGUAGE SQL;
