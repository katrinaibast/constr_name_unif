CREATE OR REPLACE FUNCTION get_all_constraints()
  RETURNS SETOF CONSTRAINT_TYPE AS $$
SELECT DISTINCT
  tc.constraint_name,
  tc.constraint_type,
  tc.table_name,
  tc.constraint_schema,
  (SELECT STRING_AGG(column_name, ',') column_name
   FROM (SELECT
           constraint_name,
           table_name,
           constraint_schema,
           column_name
         FROM information_schema.key_column_usage kcu) as columns
   WHERE columns.constraint_schema = tc.constraint_schema
         AND columns.constraint_name = tc.constraint_name
         AND columns.table_name = tc.table_name) AS related_columns,
  ccu.table_name                                 AS references_table

FROM information_schema.table_constraints tc

  LEFT JOIN information_schema.referential_constraints rc
    ON tc.constraint_catalog = rc.constraint_catalog
       AND tc.constraint_schema = rc.constraint_schema
       AND tc.constraint_name = rc.constraint_name

  LEFT JOIN information_schema.constraint_column_usage ccu
    ON rc.unique_constraint_catalog = ccu.constraint_catalog
       AND rc.unique_constraint_schema = ccu.constraint_schema
       AND rc.unique_constraint_name = ccu.constraint_name

WHERE tc.constraint_name NOT LIKE '%_not_null'
      AND constraint_type != 'CHECK'
      AND tc.constraint_schema NOT IN (SELECT schema_name
                                       FROM information_schema.schemata
                                       WHERE schema_name <> 'public' AND
                                             schema_owner = 'postgres' AND schema_name IS NOT NULL)
UNION SELECT *
      FROM (WITH exclude AS (SELECT
                               o.conname,
                               (SELECT nspname
                                FROM pg_namespace
                                WHERE oid = m.relnamespace) AS constraint_schema,
                               m.relname                    AS table_name,
                               m.oid                        AS constraint_table_oid,
                               UNNEST(o.conkey)             AS constraint_col
                             FROM pg_constraint o INNER JOIN pg_class c ON c.oid = o.conrelid
                               INNER JOIN pg_class m ON m.oid = o.conrelid
                             WHERE o.contype = 'x' AND o.conrelid IN (SELECT oid
                                                                      FROM pg_class c
                                                                      WHERE c.relkind = 'r') AND coninhcount = 0),
          exclude_grouped AS (
            SELECT
              exclude.conname,
              exclude.constraint_schema,
              exclude.table_name,
              STRING_AGG(a_target.attname, ','
              ORDER BY a_target.attnum) AS constraint_column
            FROM exclude
              INNER JOIN pg_attribute a_target
                ON exclude.constraint_col = a_target.attnum AND exclude.constraint_table_oid = a_target.attrelid AND
                   a_target.attisdropped = FALSE
            GROUP BY exclude.conname, exclude.constraint_schema, exclude.table_name)
      SELECT
        CAST((conname) AS TEXT) AS constraint_name,
        'EXCLUDE'               AS constraint_type,
        CAST(table_name AS TEXT),
        CAST(constraint_schema AS TEXT),
        constraint_column       AS related_columns,
        NULL                    AS references_table
      FROM exclude_grouped
      WHERE constraint_schema NOT IN (SELECT schema_name
                                      FROM information_schema.schemata
                                      WHERE schema_name <> 'public' AND
                                            schema_owner = 'postgres' AND schema_name IS NOT NULL)) AS excludes
UNION SELECT *
      FROM (WITH check_c AS (SELECT
                               o.conname,
                               (SELECT nspname
                                FROM pg_namespace
                                WHERE oid = m.relnamespace) AS constraint_schema,
                               m.relname                    AS table_name,
                               m.oid                        AS constraint_table_oid,
                               unnest(o.conkey)             AS constraint_col
                             FROM pg_constraint o INNER JOIN pg_class c ON c.oid = o.conrelid
                               INNER JOIN pg_class m ON m.oid = o.conrelid
                             WHERE o.contype = 'c' AND o.conrelid IN (SELECT oid
                                                                      FROM pg_class c
                                                                      WHERE c.relkind = 'r') AND coninhcount = 0),
          check_c_grouped AS (
            SELECT
              check_c.conname,
              check_c.constraint_schema,
              check_c.table_name,
              string_agg(a_target.attname, ','
              ORDER BY a_target.attnum) AS constraint_column
            FROM check_c
              INNER JOIN pg_attribute a_target
                ON check_c.constraint_col = a_target.attnum AND check_c.constraint_table_oid = a_target.attrelid
                   AND a_target.attisdropped = FALSE
            GROUP BY check_c.conname, check_c.constraint_schema, check_c.table_name)
      SELECT
        CAST((conname) AS TEXT) AS constraint_name,
        'CHECK'                 AS constraint_type,
        CAST(table_name AS TEXT),
        CAST(constraint_schema AS TEXT),
        constraint_column       AS RELATED_columns,
        NULL                    AS references_table
      FROM check_c_grouped
      WHERE constraint_schema NOT IN (SELECT schema_name
                                      FROM information_schema.schemata
                                      WHERE schema_name <> 'public' AND
                                            schema_owner = 'postgres' AND schema_name IS NOT NULL)) AS checks

ORDER BY constraint_type, constraint_name;
$$ LANGUAGE SQL;
