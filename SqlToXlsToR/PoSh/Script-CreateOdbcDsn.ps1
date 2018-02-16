Add-OdbcDsn -Name "Odbc64" -DriverName "SQL Server" -DsnType "System" -Platform "64-bit" -SetPropertyValue @("StatsLog_On=Yes"
, "Description=ODBC x64"
, "Server=$env:COMPUTERNAME"
, "StatsLogFile=C:\ODBC\64\STATS.LOG"
, "QueryLog_On=Yes"
, "Language=us_english"
, "QueryLogFile=C:\ODBC\64\QUERY.LOG")
;

Add-OdbcDsn -Name "Odbc32" -DriverName "SQL Server" -DsnType "System" -Platform "32-bit" -SetPropertyValue @("StatsLog_On=Yes"
, "Description=ODBC x32"
, "Server=$env:COMPUTERNAME"
, "StatsLogFile=C:\ODBC\32\STATS.LOG"
, "QueryLog_On=Yes"
, "Language=us_english"
, "QueryLogFile=C:\ODBC\32\QUERY.LOG")
;
