"%PROGRAMFILES%\MySQL\MySQL Server 5.5\bin\mysql.exe" -u root -proot < truncate_transaction_data.sql
"C:\Program Files\MySQL\MySQL Server 5.5\bin\mysqldump.exe" --tables --triggers --routines -u root -proot jds > %~dp0\jds_schema_data.sql
"C:\Program Files\MySQL\MySQL Server 5.5\bin\mysqldump.exe" --no-data --tables -u root -proot jds > jds_schema.sql