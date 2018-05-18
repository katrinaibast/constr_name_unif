PostgreSQL Constraint Name Uniforming Extension
=========
Bachelor's Thesis
---------

This is a PostgreSQL extension to uniform the names of different base table constraints. 


INSTALLATION
------------
Requirements: PostgreSQL 9.2+  

In directory where you downloaded the extension run  
   
  `make`  
  `make install`  
  
Log into your PostgreSQL database and run   
  
  `CREATE EXTENSION constr_name_unif; `
  
Further usage is defined in [docs.](/doc/constr_name_unif.md)  
    
AUTHOR
------

Katrin Aibast  
katrin.aibast@gmail.com  


LICENSE AND COPYRIGHT
---------------------

Copyright 2018 Katrin Aibast

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
