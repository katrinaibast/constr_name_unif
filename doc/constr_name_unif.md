constr_name_unif
=========

      
VIEWING CONSTRAINTS
------   

*get_all_constraints() RETURNS SETOF constraint_type*  
     See all renamable constraints defined in your database in all non-system schemas.

*get_all_constraints_in_schema(schema_name TEXT) RETURNS SETOF constraint_type*  
    See all renamable constraints defined in your database in specific schema.
  
*get_all_constraints(type TEXT) RETURNS SETOF constraint_type*  
    See all renamable constraints of the specific type defined in your database in all non-system schemas.  
    Accepable inputs: 'PRIMARY KEY', 'FOREIGN KEY', 'CHECK', 'UNIQUE', 'EXCLUDE'.  
    
*get_all_constraints_in_schema(schema_name TEXT, type TEXT) RETURNS SETOF constraint_type*  
    See all renamable constraints of the specific type defined in your database in specific schema.  
    Accepable inputs for type: 'PRIMARY KEY', 'FOREIGN KEY', 'CHECK', 'UNIQUE', 'EXCLUDE'.    
  
PATTERNS FOR RENAMING
-------

*add_pattern(pattern_name TEXT, delimiter  TEXT(1), has_suffix BOOLEAN, has_short_abbreviation BOOLEAN)
   RETURNS VOID*  
    Create new pattern for generating new names. Parameter definitions:  
      * pattern_name TEXT - the name of the new pattern.  
      * delimiter  TEXT(1) - the delimiter for separating the components in words.  
      * has_suffix BOOLEAN - `TRUE`: the constraint type abbreviation will be added to the end of the name, `FALSE`: the constraint type abbreviation will be added to the beginning of the name.        
      * has_short_abbreviation BOOLEAN - `TRUE`: the constraint type abbreviation will be in style `pk, fk, ck`, `FALSE`: the constraint type abbreviation will be be in style `pkey, fkey, check`

*get_all_patterns() RETURNS SETOF PATTERN*  
    See all saved patterns. After installation there will be already two patterns saved:  
      * `('postgresql_default', '_', TRUE, FALSE)`   
      * `('snake_case_with_short_prefix', '_', FALSE, TRUE)`
      
*delete_pattern(name TEXT) RETURNS VOID*     
    Delete a pattern saved earlier by the name.
    
 
RENAMING CONSTRAINTS
------   
*rename_all_constraints(pattern_name TEXT) RETURNS VOID*  
     Rename all the constraints defined in your database in all non-system schemas.

*rename_all_constraints_in_schema(pattern_name TEXT, schema_name TEXT) RETURNS VOID*  
    Rename all the constraints defined in your database in specific schema.
  
*rename_all_constraints(pattern_name TEXT, type TEXT) RETURNS VOID*  
    Rename all the constraints of the specific type defined in your database in all non-system schemas.  
    Accepable inputs: 'PRIMARY KEY', 'FOREIGN KEY', 'CHECK', 'UNIQUE', 'EXCLUDE'.  
    
*rename_all_constraints_in_schema(pattern_name TEXT, schema_name TEXT, type TEXT) RETURNS VOID*  
    Rename all the constraints of the specific type defined in your database in specific schema.  
    Accepable inputs for type: 'PRIMARY KEY', 'FOREIGN KEY', 'CHECK', 'UNIQUE', 'EXCLUDE'.    
 
  