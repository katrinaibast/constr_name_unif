CREATE OR REPLACE FUNCTION get_constraint_abbreviation(type TEXT, is_short BOOLEAN)
  RETURNS TEXT AS $$
BEGIN
  IF type = 'PRIMARY KEY'
  THEN
    IF is_short = TRUE
    THEN
      RETURN 'pk';
    ELSE
      RETURN 'pkey';
    END IF;

  ELSIF type = 'FOREIGN KEY'
    THEN
      IF is_short = TRUE
      THEN
        RETURN 'fk';
      ELSE
        RETURN 'fkey';
      END IF;

  ELSIF type = 'UNIQUE'
    THEN
      IF is_short = TRUE
      THEN
        RETURN 'uq';
      ELSE
        RETURN 'key';
      END IF;

  ELSIF type = 'CHECK'
    THEN
      IF is_short = TRUE
      THEN
        RETURN 'ck';
      ELSE
        RETURN 'check';
      END IF;

  ELSIF type = 'EXCLUDE'
    THEN
      IF is_short = TRUE
      THEN
        RETURN 'ex';
      ELSE
        RETURN 'exclude';
      END IF;
  END IF;
  RETURN '';
END;
$$ LANGUAGE plpgsql;
