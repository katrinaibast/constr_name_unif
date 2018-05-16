CREATE OR REPLACE FUNCTION add_pattern(pattern_name           TEXT,
                                       delimiter              TEXT,
                                       has_suffix             BOOLEAN,
                                       has_short_abbreviation BOOLEAN)
  RETURNS VOID AS $$
BEGIN
  INSERT INTO pattern
  (pattern_name, delimiter, has_suffix, has_short_abbreviation)
  VALUES
    (QUOTE_IDENT(pattern_name), delimiter, has_suffix, has_short_abbreviation);
END;
$$ LANGUAGE plpgsql;
