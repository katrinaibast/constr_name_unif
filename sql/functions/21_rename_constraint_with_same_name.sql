CREATE OR REPLACE FUNCTION rename_constraint_with_same_name(constraint_n TEXT,
                                                            suffix       TEXT,
                                                            has_suffix   BOOLEAN,
                                                            number       INT)
  RETURNS VARCHAR AS $$
DECLARE
  result VARCHAR;
BEGIN
  result := constraint_n;
  IF has_suffix = TRUE
  THEN
    result := REPLACE(result, suffix, (number || suffix));
  ELSE
    result := result || number;
  END IF;
  RETURN result;
END;
$$ LANGUAGE plpgsql;
