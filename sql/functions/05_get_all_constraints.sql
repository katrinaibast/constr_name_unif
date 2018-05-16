CREATE OR REPLACE FUNCTION get_all_constraints()
  RETURNS SETOF CONSTRAINT_TYPE AS $$
SELECT DISTINCT
  tc.constraint_name,
  tc.constraint_type,
  tc.table_name,
  tc.constraint_schema,
  (SELECT STRING_AGG(column_name, ',') column_name
   FROM information_schema.key_column_usage kcu
   WHERE kcu.constraint_catalog = tc.constraint_catalog
         AND kcu.constraint_schema = tc.constraint_schema
         AND kcu.constraint_name = tc.constraint_name
         AND kcu.table_name = tc.table_name) AS related_columns,
  ccu.table_name                             AS references_table

FROM information_schema.table_constraints tc

  LEFT JOIN information_schema.referential_constraints rc
    ON tc.constraint_catalog = rc.constraint_catalog
       AND tc.constraint_schema = rc.constraint_schema
       AND tc.constraint_name = rc.constraint_name

  LEFT JOIN information_schema.constraint_column_usage ccu
    ON rc.unique_constraint_catalog = ccu.constraint_catalog
       AND rc.unique_constraint_schema = ccu.constraint_schema
       AND rc.unique_constraint_name = ccu.constraint_name
       AND tc.table_name = ccu.table_name

WHERE tc.constraint_name NOT LIKE '%_not_null'
      AND tc.constraint_schema NOT IN ('information_schema', 'pg_catalog', 'pg_temp_1', 'pg_toast', 'pg_toast_temp_1')
ORDER BY tc.constraint_type, tc.constraint_name;
$$ LANGUAGE SQL;
