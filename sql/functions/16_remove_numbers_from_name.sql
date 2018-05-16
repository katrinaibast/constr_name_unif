CREATE OR REPLACE FUNCTION remove_numbers_from_name(name TEXT)
  RETURNS VARCHAR AS $$
BEGIN
  RETURN (SELECT REPLACE
  (REPLACE
   (REPLACE
    (REPLACE
     (REPLACE
      (REPLACE
       (REPLACE
        (REPLACE
         (REPLACE
          (REPLACE(name, '0', ''),
           '1', ''),
          '2', ''),
         '3', ''),
        '4', ''),
       '5', ''),
      '6', ''),
     '7', ''),
    '8', ''),
   '9', ''));
END;
$$ LANGUAGE plpgsql;
