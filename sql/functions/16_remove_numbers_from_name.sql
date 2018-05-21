CREATE OR REPLACE FUNCTION remove_numbers_from_name(name TEXT)
  RETURNS VARCHAR AS $$
SELECT translate(name, '0123456789', '');
$$ LANGUAGE SQL;
