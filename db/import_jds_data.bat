@echo OFF
REM "%PROGRAMFILES%\MySQL\MySQL Server 5.5\bin\mysql.exe" -u root -proot -D jds < jds_schema.sql >> import_jds_data.log
echo Creating the database schema
"%PROGRAMFILES%\MySQL\MySQL Server 5.5\bin\mysql.exe" -u root -proot -D jds < jds_schema_data.sql > import_jds_data.log 2>&1
echo Done
echo Look for any errors in import_jds_data.log.
pause