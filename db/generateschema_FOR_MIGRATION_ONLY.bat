REM "%PROGRAMFILES%\MySQL\MySQL Server 5.6\bin\mysql.exe" -u root -proot < truncate_transaction_data.sql
"C:\Program Files\MySQL\MySQL Server 5.6\bin\mysqldump.exe" --tables --triggers --routines -u root -proot evitaran > %~dp0\jds_migration_data_DO_NOT_CHECK_IN.sql
REM "C:\Program Files\MySQL\MySQL Server 5.6\bin\mysqldump.exe" --tables --triggers --routines -u root -proot jds > %~dp0\jds_migration_data_DO_NOT_CHECK_IN_staging.sql
