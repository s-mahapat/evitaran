@echo OFF
echo Creating the database schema
"%PROGRAMFILES%\MySQL\MySQL Server 5.6\bin\mysql.exe" -u root -proot --comments < jds_schema_data.sql > import_jds_data.log 2>&1
echo Creating the database procedures
"%PROGRAMFILES%\MySQL\MySQL Server 5.6\bin\mysql.exe" -u root -proot --comments < jds_schema_procedures.sql >> import_jds_data.log 2>&1
echo Creating the database triggers
"%PROGRAMFILES%\MySQL\MySQL Server 5.6\bin\mysql.exe" -u root -proot --comments < jds_schema_triggers.sql >> import_jds_data.log 2>&1
IF %ERRORLEVEL% EQU 0 (
    echo Import completed successfully 
) ELSE (
    echo Import Failed
    echo Look for any errors in import_jds_data.log.    
)
pause