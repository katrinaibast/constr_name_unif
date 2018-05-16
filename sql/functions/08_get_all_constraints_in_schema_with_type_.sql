CREATE OR REPLACE FUNCTION get_all_constraints_in_schema(schema_n TEXT, type TEXT)
  RETURNS SETOF CONSTRAINT_TYPE AS $$
SELECT *
FROM get_all_constraints_in_schema(schema_n)
WHERE constraint_type = UPPER(type);
$$ LANGUAGE SQL;
