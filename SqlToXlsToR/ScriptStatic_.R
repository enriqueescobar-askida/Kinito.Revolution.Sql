# namespace
aNamespace <- "SqlServerWithODBC";
# drive
aDrive <- NULL;
if (Sys.getenv("DataDrive") != "") {
  aDrive <- Sys.getenv("DataDrive");
} else {
  aDrive <- Sys.getenv("SystemDrive");
}
# path
aPath <- NULL;
if (Sys.getenv("ASKIDA") != "") {
  aPath <- paste0(c(aDrive, Sys.getenv("ASKIDA")), sep = "/", collapse = "");
}else{
  aPath <- aDrive;
}
aPath <- paste0(c(aPath, "R", aNamespace), sep = "/", collapse = "");
setwd(aPath);
getwd();
# base lib
gDriveUtil <- paste0(c("Lib/", "SqlServerWithODBC", ".Util.R"), sep = "", collapse = "");
write(paste0(c("Load Util........\t", gDriveUtil), sep = "", collapse = ""), stdout());
source(gDriveUtil);
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
dbPass <- GetDBPassword("ASKIDA_ENV");
# DB list
dbList <- c("mmq", "Claims_MMQ");
dbList <- sort(dbList);
# RODBC Open SimmqDB
library(RODBC);
simmqODBC <- odbcConnect("SimmqDB", uid = dbUser, pwd = dbPass);
# Server info
serverInstance <- SqlCountResultToString(simmqODBC, "Select @@SERVERNAME     AS SQLServerInstance;");
serverVersion <- SqlCountResultToString(simmqODBC, "Select @@VERSION        AS SQLServerVersion;");
serverService <- SqlCountResultToString(simmqODBC, "Select @@ServiceName    AS ServiceInstance;");
# Server Running
sqlFile <- "SQL/DB-ServerRunning_list.sql";
DataFrameToCsv(SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile)),
               SqlFileToCsv(sqlFile, serverInstance));
# Server Linked
sqlFile <- "SQL/DB-ServerLinked_list.sql";
DataFrameToCsv(SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile)),
               SqlFileToCsv(sqlFile, serverInstance));
# Server DB spec
sqlFile <- "SQL/DB-ServerDBSpec_list.sql";
DataFrameToCsv(SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile)),
               SqlFileToCsv(sqlFile, serverInstance));
# Server DB Backup
sqlFile <- "SQL/DB-ServerDBBackup_list.sql";
DataFrameToCsv(SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile)),
               SqlFileToCsv(sqlFile, serverInstance));
## Server DB Usage
# Server DB usage list
sqlFile <- "SQL/DB-Usage_list.sql";
sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
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
###
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  write(sqlInstance, stdout());
  sqlQuery(simmqODBC, sqlInstance);
  ## DB All parameter
  # DB All parameter list
  sqlFile <- "SQL/DB-ParametersInFuncsAndProcs.sql";
  allParametersDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(allParametersDataFrame,
                 SqlFileToCsv(sqlFile, dbInstance));
  ## DB Object
  # DB object list
  sqlFile <- "SQL/DB-Object_list.sql";
  ObjectListDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(ObjectListDataFrame,
                 SqlFileToCsv(sqlFile, dbInstance));
  # DB object list group fonctions
  ObjectSumDataFrame <- ObjectListGroupFunctionsDataFrame(ObjectListDataFrame, "Function");
  # DB object list Barplot
  objectSumBarplot <- DBObjectDataFrameToBarplot(ObjectSumDataFrame);
  GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Sum_Barplot"), objectSumBarplot);
  # DB object list Piechart
  objectSumPiechart <- GenericPiechartFromTwoColumnDataFrame(ObjectSumDataFrame, mainTitle = "Object Summary");
  GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Sum_Piechart"), objectSumPiechart);
  #
  grid.arrange(objectSumBarplot, objectSumPiechart, nrow = 1, ncol = 2);
  # DB object list all fonctions
  objectAllDataFrame <- SummarizeAllDBFunctionDataFrame(ObjectListDataFrame, "Function");
  objectAllBarplot <- DBFunctionDataFrameToBarplot(objectAllDataFrame);
  GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-All_Barplot"), objectAllBarplot);
  objectAllPiechart <- DBFunctionDataFrameToPiechart(objectAllDataFrame);
  GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-All_Piechart"), objectAllPiechart);
  # DB object list all plot
  grid.arrange(objectAllBarplot, objectAllPiechart, nrow = 1, ncol = 2);
  #
  rm(xlsFile); rm(ObjectListDataFrame);
  rm(ObjectSumDataFrame); rm(objectSumBarplot); rm(objectSumPiechart);
  rm(objectAllDataFrame); rm(objectAllBarplot); rm(objectAllPiechart);
  ## DB StoredProc
  # DB StoreProc count
  sqlFile <- "SQL/DB-Procedure_count.sql";
  countStoreProc <- SqlCountResultToInteger(simmqODBC, GetSqlFromFile(sqlFile));
  # DB StoreProc list
  sqlFile <- "SQL/DB-Procedure_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  # DB StoreProc param list
  sqlFile <- "SQL/DB-Procedure_listParams.sql";
  storedProcParamDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  storedProcParamDataFrame;
  DataFrameToCsv(storedProcParamDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  storedProcParamDataFrameSlim <- DataFrameFromColumns(storedProcParamDataFrame,
                                                        "ProcedureName",
                                                        "ProcedureType",
                                                        "ProcedureDesc");
  # DB StoreProc repeat count
  storedProcParamDataFrameFat <- aggregate(list(NbParameters = rep(1, nrow(storedProcParamDataFrameSlim))),
                                            storedProcParamDataFrameSlim,
                                            length);
  storedProcParamDataFrameFat <- tibble::as_data_frame(storedProcParamDataFrameFat);
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
  storeProcParamsDF;
  # DB StoreProc barplot
  OutputType <- "StoredProc";
  # DB StoreProc param list export
  DataFrameToCsv(storeProcParamsDF,
                 SqlFileToCsv(sqlFile, dbInstance, "-Procs_Specs"));
  # DB StoreProc barplot
  storeProcParamsBarplot <- StoredProcWithoutWithTotalDFToBarplot(storeProcParamsDF, OutputType);
  storeProcParamsBarplot;
  GgplotToPng(SqlFileToPng(sqlFile, dbInstance, "-Procs_Barplot"), storeProcParamsBarplot);
  # DB StoreProc piechart
  storeProcParamsPiechart <- StoredProcWithoutWithTotalDFToPiechart(storeProcParamsDF, OutputType);
  storeProcParamsPiechart;
  # DB StoreProc boxplot
  storeProcParamsBoxplot <- DBStoreProcDataFrameToBoxplot(storedProcParamDataFrameFat);
  GgplotToPng(SqlFileToPng(sqlFile, dbInstance, "-Procs_Boxplot"), storeProcParamsBoxplot);
  # DB StoreProc density plot
  storeProcParamsDensityplot <- DBStoreProcDataFrameToDensityplot(storedProcParamDataFrameFat);
  GgplotToPng(SqlFileToPng(sqlFile, dbInstance, "-Procs_Densityplot"), storeProcParamsDensityplot);
  #
  grid.arrange(storeProcParamsBoxplot, storeProcParamsDensityplot, nrow = 1, ncol = 2);
  ## DB Table Count
  # DB Table Count DROP
  sqlQuery(simmqODBC, "IF OBJECT_ID(N'#counts', N'U') IS NOT NULL DROP TABLE #counts;")
  # DB TABLE Count CREATE
  sqlQuery(simmqODBC, "CREATE TABLE #counts (TableName VARCHAR(255), TableRows INT);");
  # DB Table Count EXEC
  sqlQuery(simmqODBC, "EXEC sp_MSForEachTable @command1='INSERT #counts (TableName, TableRows) SELECT ''?'', COUNT(*) FROM ?';");
  # DB Table Count CSV
  sqlFile <- "SQL/DB-RowCount_list.sql";
  tableRowCountDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(tableRowCountDataFrame,
                 SqlFileToCsv(sqlFile, dbInstance));
  # DB Table Count repeats
  tableRowCountDataFrame <- aggregate(list(RowRepeats = rep(1, nrow(tableRowCountDataFrame[-1]))),
                                   tableRowCountDataFrame[-1],
                                   length);
  tableRowCountDataFrame <- tibble::as_data_frame(tableRowCountDataFrame);
  tableRowCountDataFrame;
  # DB Table Count half > mean repeats
  aMean <- mean(tableRowCountDataFrame$RowRepeats);
  tableRowCountDataFrame <- subset(tableRowCountDataFrame, RowRepeats > aMean);
  tableRowCountBarplot <- DBRowCountFrameToBarplot(tableRowCountDataFrame);
  GgplotToPng(SqlFileToPng(sqlFile, dbInstance, "_Barplot"), tableRowCountBarplot);
  # DB Table Count DROP
  sqlQuery(simmqODBC, "DROP TABLE #counts;");
  ## DB Table Analysis
  # DB Table Analysis count
  sqlFile <- "SQL/DB-Table_count.sql";
  countTable <- SqlCountResultToInteger(simmqODBC, GetSqlFromFile(sqlFile));
  print(paste0("Table Analysis count: ", countTable));
  # DB Table Analysis list
  sqlFile <- "SQL/DB-Table_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  print(paste0("Table Analysis list: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame, 0));
  # DB Table Analysis Independent
  sqlFile <- "SQL/DB-TableIndependent_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  print(paste0("Table Independent list: ", nrow(sqlDataFrame)));
  # DB Table Analysis Trunk
  sqlFile <- "SQL/DB-TableTrunk_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  print(paste0("Table Trunk list: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame, 0));
  # DB Table Analysis Branch
  sqlFile <- "SQL/DB-TableBranch_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  print(paste0("Table Branch list: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame, 0));
  # DB Table Analysis Leaf
  sqlFile <- "SQL/DB-TableLeaf_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  print(paste0("Table Leaf list: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame, 0));
  # DB Table Analysis Parent
  sqlFile <- "SQL/DB-TableParent_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  print(paste0("Table Parent list: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame, 0));
  # DB Table Analysis Child
  sqlFile <- "SQL/DB-TableChild_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  print(paste0("Table Child list: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame, 0));
  # DB Table Analysis SelfRef
  sqlFile <- "SQL/DB-TableSelfRef_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  print(paste0("Table SelfRef list: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame, 0));
  # DB Table Analysis keys list
  sqlFile <- "SQL/DB-Table_listKeys.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  print(paste0("Table Key list: ", nrow(sqlDataFrame)));
  print(head(sqlDataFrame, 0));
  ## View Analysis
  # View Analysis count
  sqlFile <- "SQL/DB-View_count.sql";
  countView <- SqlCountResultToInteger(simmqODBC, GetSqlFromFile(sqlFile));
  # View Analysis list
  sqlFile <- "SQL/DB-View_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  ## Function Analysis
  # Function Analysis count
  sqlFile <- "SQL/DB-Function_count.sql";
  countFunc <- SqlCountResultToInteger(simmqODBC, GetSqlFromFile(sqlFile));
  # Function Analysis list
  sqlFile <- "SQL/DB-Function_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  # Function Analysis param list
  sqlFile <- "SQL/DB-Function_listParams.sql";
  functionParamsDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(functionParamsDataFrame,
                 SqlFileToCsv(sqlFile, dbInstance));
  fnParamsDataFrameSlim <- DataFrameFromColumns(functionParamsDataFrame,
                                                "FunctionName",
                                                "FunctionType",
                                                "FunctionDesc");
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
  DataFrameToCsv(fnParamsDF,
                 SqlFileToCsv(sqlFile, dbInstance, "-Funcs_Specs"));
  # Function Analysis barplot
  fnParamsBarplot <- FunctionWithoutWithTotalDFToBarplot(fnParamsDF, OutputType);
  fnParamsBarplot;
  GgplotToPng(SqlFileToPng(sqlFile, dbInstance, "-Funcs_Barplot"), fnParamsBarplot);
  # Function Analysis boxplot
  fnParamsBoxplot <- DBFunctionDataFrameToBoxplot(fnParamsDataFrameFat);
  GgplotToPng(SqlFileToPng(sqlFile, dbInstance, "-Funcs_Boxplot"), fnParamsBoxplot);
  # Function Analysis density plot
  fnParamsDensityplot <- DBFunctionDataFrameToDensityplot(fnParamsDataFrameFat);
  GgplotToPng(SqlFileToPng(sqlFile, dbInstance, "-Funcs_Densityplot"), fnParamsDensityplot);
  #
  grid.arrange(fnParamsBoxplot, fnParamsDensityplot, nrow = 1, ncol = 2);
  ## PKey Analysis
  # PKey Analysis count
  sqlFile <- "SQL/DB-PKeys_count.sql";
  countPKeys <- SqlCountResultToInteger(simmqODBC, GetSqlFromFile(sqlFile));
  # PKey Analysis list
  sqlFile <- "SQL/DB-PKeys_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  ## FKey Analysis
  # FKey Analysis count
  sqlFile <- "SQL/DB-FKeys_count.sql";
  countFKeys <- SqlCountResultToInteger(simmqODBC, GetSqlFromFile(sqlFile));
  # FKey Analysis list
  sqlFile <- "SQL/DB-FKeys_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  ## Index Analysis
  # Index Analysis count
  sqlFile <- "SQL/DB-Index_count.sql";
  countIndex <- SqlCountResultToInteger(simmqODBC, GetSqlFromFile(sqlFile));
  # Index Analysis list
  sqlFile <- "SQL/DB-Index_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  # Index Analysis type list
  sqlFile <- "SQL/DB-Index_listTypes.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  ## Constraint Analysis
  # Constraint Analysis List
  sqlFile <- "SQL/DB-Constraint_list.sql";
  sqlDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  DataFrameToCsv(sqlDataFrame, SqlFileToCsv(sqlFile, dbInstance));
  sqlDataFrame <- ConstraintToTableNameFrequency(sqlDataFrame);
  constraintBarplot <- TwoColumnDataFrameToBarlot(sqlDataFrame);
  GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Barplot"), constraintBarplot);
  # rm()
  rm(sqlFile); rm(sqlDataFrame); rm(constraintBarplot);
}
# RODBC close SimmqDB
odbcClose(simmqODBC);
