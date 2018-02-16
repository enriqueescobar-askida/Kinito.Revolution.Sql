# sql lib
sqlUtil <- paste0(c("Lib/", "SqlServerWithODBC", ".Util.R"), sep = "", collapse = "");
write(paste0(c("Load Util........\t", sqlUtil), sep = "", collapse = ""), stdout());
source(sqlUtil);
# RODBC lib
rodbcUtil <- paste0(c("Lib/", "RODBC", ".Util.R"), sep = "", collapse = "");
write(paste0(c("Load Util........\t", rodbcUtil), sep = "", collapse = ""), stdout());
source(rodbcUtil);
# ggplot2 lib
ggplot2Util <- paste0(c("Lib/", "ggplot2", ".Util.R"), sep = "", collapse = "");
write(paste0(c("Load Util........\t", ggplot2Util), sep = "", collapse = ""), stdout());
source(ggplot2Util);
# plotrix lib
# plotrixUtil <- paste0(c("Lib/", "plotrix", ".Util.R"), sep = "", collapse = "");
# write(paste0(c("Load Util........\t", plotrixUtil), sep = "", collapse = ""), stdout());
# source(plotrixUtil);
# password
dbUser <- "sa";
dbPass <- "12345678";
# DB list
dbList <- c("TileboardDemo", "TileboardLocator", "WxTileBoardTools");
# RODBC Open SimmqDB
library(RODBC);
anODBC <- odbcConnect("Odbc64", uid = dbUser, pwd = dbPass);
# Server info
serverInstance <- SqlCountResultToString(anODBC, "Select @@SERVERNAME     AS SQLServerInstance;");
serverVersion <- SqlCountResultToString(anODBC, "Select @@VERSION        AS SQLServerVersion;");
serverService <- SqlCountResultToString(anODBC, "Select @@ServiceName    AS ServiceInstance;");
# Server Running
sqlFile <- "SQL/DB-ServerRunning_list.sql";
DataFrameToCsv(SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile)),
               SqlFileToCsv(sqlFile, serverInstance));
# Server Linked
sqlFile <- "SQL/DB-ServerLinked_list.sql";
DataFrameToCsv(SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile)),
               SqlFileToCsv(sqlFile, serverInstance));
# Server DB spec
sqlFile <- "SQL/DB-ServerDBSpec_list.sql";
DataFrameToCsv(SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile)),
               SqlFileToCsv(sqlFile, serverInstance));
# Server DB Backup
sqlFile <- "SQL/DB-ServerDBBackup_list.sql";
DataFrameToCsv(SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile)),
               SqlFileToCsv(sqlFile, serverInstance));
## Server DB Usage
# Server DB usage list
sqlFile <- "SQL/DB-Usage_list.sql";
sqlDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
# db list sqlDataFrame$DBName
DataFrameToCsv(sqlDataFrame,
               SqlFileToCsv(sqlFile, serverInstance));
# Server DB usage plots
usagePlot <- DBUsageDataFrameToBarplot(sqlDataFrame);
GgplotToPng(SqlFileToPng(sqlFile, serverInstance, "-Barplot"), usagePlot);
usagePieChart <- DBUsageDataFrameToPiechart(sqlDataFrame);
GgplotToPng(SqlFileToPng(sqlFile, serverInstance, "-Piechart"), usagePieChart);
# Server DB usage plots all
grid.arrange(usagePlot, usagePieChart, nrow = 1, ncol = 2);
### Screening Model
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  print(sqlInstance);
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## DB Object
  # DB object list
  sqlFile <- "SQL/DB-Object_list.sql";
  ObjectListDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  head(ObjectListDataFrame);
  # DB object list sum fonctions
  ObjectSumDataFrame <- SummarizeDBFunctionDataFrame(ObjectListDataFrame, "Function");
  head(ObjectSumDataFrame);
  objectSumBarplot <- DBObjectDataFrameToBarplot(ObjectSumDataFrame);
  objectSumBarplot;
  # rm()
  rm(ObjectListDataFrame);
  rm(objectSumBarplot);
}
### Function Analysis
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## DB Object
  # DB object list
  sqlFile <- "SQL/DB-Object_list.sql";
  ObjectListDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  head(ObjectListDataFrame);
  DataFrameToCsv(ObjectListDataFrame,
                 SqlFileToCsv(sqlFile, dbInstance));
  # DB object list Barplot
  ObjectSumDataFrame <- SummarizeDBFunctionDataFrame(ObjectListDataFrame, "Function");
  objectSumBarplot <- DBObjectDataFrameToBarplot(ObjectSumDataFrame);
  # DB object list Piechart
  objectSumPiechart <- GenericPiechartFromTwoColumnDataFrame(ObjectSumDataFrame, mainTitle = "Object Summary");
  #
  grid.arrange(objectSumBarplot, objectSumPiechart, nrow = 1, ncol = 2);
  # DB object list all fonctions
  objectAllDataFrame <- SummarizeAllDBFunctionDataFrame(ObjectListDataFrame, "Function");
  objectAllBarplot <- DBFunctionDataFrameToBarplot(objectAllDataFrame);
  objectAllPiechart <- DBFunctionDataFrameToPiechart(objectAllDataFrame);
  # DB object list all plot
  grid.arrange(objectAllBarplot, objectAllPiechart, nrow = 1, ncol = 2);
  #
  rm(xlsFile); rm(ObjectListDataFrame);
  rm(ObjectSumDataFrame); rm(objectSumBarplot); rm(objectSumPiechart);
  rm(objectAllDataFrame); rm(objectAllBarplot); rm(objectAllPiechart);
}
### Procedure Analysis
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## DB StoredProc
  # DB StoreProc count
  sqlFile <- "SQL/DB-Procedure_count.sql";
  countStoreProc <- SqlCountResultToInteger(anODBC, GetSqlFromFile(sqlFile));
  # DB StoreProc list
  sqlFile <- "SQL/DB-Procedure_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  print(sqlDataFrame);
  # DB StoreProc param list
  sqlFile <- "SQL/DB-Procedure_listParams.sql";
  storedProcParamDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  # print(head(storedProcParamDataFrame));
  storedProcParamDataFrameSlim <- DataFrameFromColumns(storedProcParamDataFrame,
                                                       "ProcedureName",
                                                       "ProcedureType",
                                                       "ProcedureDesc");
  # DB StoreProc repeat count
  storedProcParamDataFrameFat <- aggregate(list(NbParameters = rep(1, nrow(storedProcParamDataFrameSlim))),
                                           storedProcParamDataFrameSlim,
                                           length);
  storedProcParamDataFrameFat <- tibble::as_data_frame(storedProcParamDataFrameFat);
  print(head(storedProcParamDataFrameFat));
  write(summary(rev(storedProcParamDataFrameFat)[1]), stdout());
  # DB StoreProc with params
  countStoreProcWith <- nrow(storedProcParamDataFrameFat);
  # DB StoreProc without params
  countStoreProcWithout <- countStoreProc - countStoreProcWith;
  # DB StoreProc data frame params
  storeProcParamsDF <- DataFrameWithoutWithTotal(countStoreProcWithout,
                                                 countStoreProcWith,
                                                 countStoreProc,
                                                 "StoreProc");
  # DB StoreProc param list export
  print(head(storeProcParamsDF));
  # DB StoreProc barplot
  OutputType <- "StoredProc";
  # DB StoreProc barplot
  storeProcParamsBarplot <- StoredProcWithoutWithTotalDFToBarplot(storeProcParamsDF, OutputType);
  # DB StoreProc piechart
  storeProcParamsPiechart <- StoredProcWithoutWithTotalDFToPiechart(storeProcParamsDF, OutputType);
  #
  grid.arrange(storeProcParamsBarplot, storeProcParamsPiechart, nrow = 1, ncol = 2);
  # DB StoreProc boxplot
  storeProcParamsBoxplot <- DBStoreProcDataFrameToBoxplot(storedProcParamDataFrameFat);
  # DB StoreProc density plot
  storeProcParamsDensityplot <- DBStoreProcDataFrameToDensityplot(storedProcParamDataFrameFat);
  #
  grid.arrange(storeProcParamsBoxplot, storeProcParamsDensityplot, nrow = 1, ncol = 2);
  # rm()
  rm(sqlFile); rm(countStoreProc); rm(sqlDataFrame); rm(storedProcParamDataFrame);
  rm(storedProcParamDataFrameSlim); rm(storedProcParamDataFrameFat);
  rm(countStoreProcWith); rm(countStoreProcWithout); rm(storeProcParamsDF);
  rm(OutputType); rm(storeProcParamsBarplot); rm(storeProcParamsPiechart);
  rm(storeProcParamsBoxplot); rm(storeProcParamsDensityplot);
}
### DB Analysis
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## DB Table Count
  # DB Table Count DROP
  sqlQuery(anODBC, "IF OBJECT_ID(N'#counts', N'U') IS NOT NULL DROP TABLE #counts;")
  # DB TABLE Count CREATE
  sqlQuery(anODBC, "CREATE TABLE #counts (TableName VARCHAR(255), TableRows INT);");
  # DB Table Count EXEC
  sqlQuery(anODBC, "EXEC sp_MSForEachTable @command1='INSERT #counts (TableName, TableRows) SELECT ''?'', COUNT(*) FROM ?';");
  # DB Table Count CSV
  sqlFile <- "SQL/DB-RowCount_list.sql";
  tableRowCountDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  print(head(tableRowCountDataFrame));
  # DB Table Count repeats
  tableRowCountDataFrame <- aggregate(list(RowRepeats = rep(1, nrow(tableRowCountDataFrame[-1]))),
                                      tableRowCountDataFrame[-1],
                                      length);
  tableRowCountDataFrame <- tibble::as_data_frame(tableRowCountDataFrame);
  print(head(tableRowCountDataFrame));
  # DB Table Count half > mean repeats
  aMean <- mean(tableRowCountDataFrame$RowRepeats);
  tableRowCountDataFrame <- subset(tableRowCountDataFrame, RowRepeats > aMean);
  print(head(tableRowCountDataFrame));
  tableRowCountBarplot <- DBRowCountFrameToBarplot(tableRowCountDataFrame);
  tableRowCountBarplot;
  # DB Table Count DROP
  sqlQuery(anODBC, "DROP TABLE #counts;");
  # rm()
  rm(sqlFile); rm(aMean); rm(tableRowCountDataFrame); rm(tableRowCountBarplot);
}
### Table Analysis
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## DB Table Analysis
  # DB Table Analysis count
  sqlFile <- "SQL/DB-Table_count.sql";
  countTable <- SqlCountResultToInteger(anODBC, GetSqlFromFile(sqlFile));
  print(paste0("Table Analysis count: ", countTable));
  # rm()
  rm(sqlFile); rm(countTable);
}
### Table List
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## DB Table Analysis
  # DB Table Analysis list
  sqlFile <- "SQL/DB-Table_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  print(paste0("Table List count: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame));
  # rm()
  rm(sqlFile); rm(sqlDataFrame);
}
### Table Key List
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## DB Table Analysis
  # DB Table Analysis keys list
  sqlFile <- "SQL/DB-Table_listKeys.sql";
  sqlDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  print(paste0("Table Key list count: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame));
  # rm()
  rm(sqlFile); rm(sqlDataFrame);
}
### View Analysis
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## View Analysis
  # View Analysis count
  sqlFile <- "SQL/DB-View_count.sql";
  countView <- SqlCountResultToInteger(anODBC, GetSqlFromFile(sqlFile));
  # View Analysis list
  sqlFile <- "SQL/DB-View_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  print(paste0("View list count: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame));
  # rm()
  rm(sqlFile); rm(sqlDataFrame);
}
### Function Type List
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## Function Analysis
  # Function Analysis count
  sqlFile <- "SQL/DB-Function_count.sql";
  countFunc <- SqlCountResultToInteger(anODBC, GetSqlFromFile(sqlFile));
  # Function Analysis list
  sqlFile <- "SQL/DB-Function_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  print(paste0("Function list count: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame));
  # rm()
  rm(sqlFile); rm(sqlDataFrame);
}
### Function Parameter List
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## Function Analysis
  # Function Analysis param list
  sqlFile <- "SQL/DB-Function_listParams.sql";
  functionParamsDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  print(head(functionParamsDataFrame));
  fnParamsDataFrameSlim <- DataFrameFromColumns(functionParamsDataFrame,
                                                "FunctionName",
                                                "FunctionType",
                                                "FunctionDesc");
  print(head(fnParamsDataFrameSlim));
  # Function Analysis repeat count
  fnParamsDataFrameFat <- aggregate(list(NbParameters = rep(1, nrow(fnParamsDataFrameSlim))),
                                    fnParamsDataFrameSlim,
                                    length);
  fnParamsDataFrameFat <- tibble::as_data_frame(fnParamsDataFrameFat);
  write(summary(rev(fnParamsDataFrameFat)[1]), stdout());
  # Function Analysis without params
  countFuncWith <- nrow(fnParamsDataFrameFat);
  # Function Analysis without params
  countFuncWithout <- countFunc - countFuncWith;
  # Function Analysis barplot
  OutputType <- "Fn";
  # Function Analysis data frame params
  fnParamsDF <- DataFrameWithoutWithTotal(countFuncWithout,
                                          countFuncWith,
                                          countFunc,
                                          OutputType);
  # Function Analysis param list export
  print(head(fnParamsDF));
  # Function Analysis barplot
  fnParamsBarplot <- FunctionWithoutWithTotalDFToBarplot(fnParamsDF, OutputType);
  fnParamsBarplot;
  # Function Analysis boxplot
  fnParamsBoxplot <- DBFunctionDataFrameToBoxplot(fnParamsDataFrameFat);
  # Function Analysis density plot
  fnParamsDensityplot <- DBFunctionDataFrameToDensityplot(fnParamsDataFrameFat);
  #
  grid.arrange(fnParamsBoxplot, fnParamsDensityplot, nrow = 1, ncol = 2);
  # rm()
  rm(sqlFile); rm(sqlFile);
  rm(functionParamsDataFrame); rm(fnParamsDataFrameSlim); rm(fnParamsDataFrameFat);
  rm(countFuncWith); rm(countFuncWithout); rm(OutputType); rm(fnParamsDF);
  rm(fnParamsBarplot); rm(fnParamsBoxplot); rm(fnParamsDensityplot);
}
### Principal Key Analysis
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## PKey Analysis
  # PKey Analysis count
  sqlFile <- "SQL/DB-PKeys_count.sql";
  countPKeys <- SqlCountResultToInteger(anODBC, GetSqlFromFile(sqlFile));
  # PKey Analysis list
  sqlFile <- "SQL/DB-PKeys_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  print(paste0("PKey list count: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame));
  # rm()
  rm(sqlFile); rm(countPKeys); rm(sqlDataFrame);
}
### Foreign Key Analysis
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## FKey Analysis
  # FKey Analysis count
  sqlFile <- "SQL/DB-FKeys_count.sql";
  countFKeys <- SqlCountResultToInteger(anODBC, GetSqlFromFile(sqlFile));
  # FKey Analysis list
  sqlFile <- "SQL/DB-FKeys_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  print(paste0("FKeys list count: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame));
  # rm()
  rm(sqlFile); rm(sqlDataFrame);
}
### Index List
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## Index Analysis
  # Index Analysis count
  sqlFile <- "SQL/DB-Index_count.sql";
  countIndex <- SqlCountResultToInteger(anODBC, GetSqlFromFile(sqlFile));
  # Index Analysis list
  sqlFile <- "SQL/DB-Index_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  print(head(sqlDataFrame));
  # Index Analysis type list
  sqlFile <- "SQL/DB-Index_listTypes.sql";
  sqlDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  print(paste0("Index list count: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame));
  # rm()
  rm(sqlFile); rm(sqlDataFrame);
}
### Index Type List
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## Index Analysis
  # Index Analysis type list
  sqlFile <- "SQL/DB-Index_listTypes.sql";
  sqlDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  print(paste0("Index Type list count: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame));
  # rm()
  rm(sqlFile); rm(sqlDataFrame);
}
### Constraint Analysis
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  # write(sqlInstance, stdout());
  sqlQuery(anODBC, sqlInstance);
  ## Constraint Analysis
  # Constraint Analysis List
  sqlFile <- "SQL/DB-Constraint_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(anODBC, GetSqlFromFile(sqlFile));
  print(paste0("Constraint list count: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame));
  #sqlDataFrame <- ConstraintToTableNameFrequency(sqlDataFrame);
  #constraintBarplot <- TwoColumnDataFrameToBarlot(sqlDataFrame);
  #GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Barplot"), constraintBarplot);
  # rm()
  rm(sqlFile); rm(sqlDataFrame); rm(constraintBarplot);
}
# RODBC close SimmqDB
odbcClose(anODBC);
