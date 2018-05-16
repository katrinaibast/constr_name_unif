CREATE OR REPLACE FUNCTION get_all_constraints(type TEXT)
  RETURNS SETOF CONSTRAINT_TYPE AS $$
SELECT *
FROM get_all_constraints()
WHERE constraint_type = UPPER(type);
$$ LANGUAGE SQL;
