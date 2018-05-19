Abstract
========
Creating a PostgreSQL Extension for Uniforming the Names of Base Table Constraints
========
The main aim of this work is to create a PostgreSQL extension for uniforming the names of base table constraints. First, there will be a research, based on the PostgreSQL databases of three open source systems (FusionForge (version 6.1beta1) [1], LedgerSMB (version 1.5.20) [2] and OTRS (version 6.0.6) [3]), to find out what kind of naming conventions are used for naming different database objects and what problems are appearing with it.     

Good intention-revealing names and following certain naming conventions are part of the clean code [4]. But also naming things is one of the hardest things in Computer Science [5]. Bad naming habits make administrating and further development of any system, including databases, significantly more difficult and it also makes the code harder to read and understand. Specifically, bad naming of database constraints makes the administration of the database schema more complex and also makes it tricky to understand error messages. 

From the analysis, it turned out that not one database that was observed had complete consistency in naming constraints. There were many different patterns by which the constraints were named. That kind of inconsistency makes database administration many times more difficult. Therefore, an extension for uniforming constraints would certainly be very useful tool for any database developer.

The thesis is in Estonian and contains 67 pages of text, 6 chapters, 29 figures, 8 tables. 


Referecnes
----------
[1]	FusionForge [WWW] https://fusionforge.org/ (18.04.2018)  
[2]	LedgerSMB [WWW] https://ledgersmb.org/ (18.04.2018)  
[3]	OTRS [WWW] https://otrs.com/ (18.04.2018)   
[4]	Martin, R.C. Clean Code. A Handbook of Agile Software Craftsmanship. Pearson Education, 2009   
[5]	Fowler, M. TwoHardThings, 2009 [WWW] https://martinfowler.com/bliki/TwoHardThings.html (19.04.2018)

