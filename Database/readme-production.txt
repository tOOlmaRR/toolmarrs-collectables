To create a production deploy script:
1) remove the CREATE DATABASE query
2) remove several ALTER DATABASE queries:
	i) SET TRUSTWORTHY OFF 
	ii) SET HONOR_BROKER_PRIORITY OFF
	iii) SET DB_CHAINING OFF
3) remove the User Creation queries
4) update the database name to a new one (tsc2020-YYMMDD for example)
5) import data from the current production database into the new copy
6) rename the existing and new (hot swap) and test out website

