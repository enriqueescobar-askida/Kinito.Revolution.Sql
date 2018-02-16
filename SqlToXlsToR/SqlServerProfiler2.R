source("Lib/SqlServerProfiler.Util.R");
# fileList0 <- list("Data/00 Scripts start.new.xls");
# fileList1 <- list("Data/01 Agent Niveau 1 - Evelyne made mistake and logged out.new.xls");
# fileList2 <- list("Data/02 Agent N1 Complete Agent Web Services engage.new.xls");
# fileList3 <- list("Data/03 Agent N1 complete.new.1of5.xls",
#                   "Data/03 Agent N1 complete.new.2of5.xls",
#                   "Data/03 Agent N1 complete.new.3of5.xls",
#                   "Data/03 Agent N1 complete.new.4of5.xls",
#                   "Data/03 Agent N1 complete.new.5of5.xls");
# fileList4 <- list("Data/04 Agent N2 complete.new.1of3.xls",
#                   "Data/04 Agent N2 complete.new.2of3.xls",
#                   "Data/04 Agent N2 complete.new.3of3.xls");
# fileList5 <- list("Data/05 Sup SAC.new.xls");
# #
# xlsxTibble0 <- ScreenXmlXlsFiles(fileList0);
# TraceXmlXlsToCsv(xlsxTibble0, filePath = "Data/00 Scripts start.new.csv");
# rm(xlsxTibble0);
# xlsxTibble1 <- ScreenXmlXlsFiles(fileList1);
# TraceXmlXlsToCsv(xlsxTibble1, filePath = "Data/01 Agent Niveau 1 - Evelyne made mistake and logged out.new.csv");
# rm(xlsxTibble1);
# xlsxTibble2 <- ScreenXmlXlsFiles(fileList2);
# TraceXmlXlsToCsv(xlsxTibble2, filePath = "Data/02 Agent N1 Complete Agent Web Services engage.new.csv");
# rm(xlsxTibble2);
# xlsxTibble3 <- ScreenXmlXlsFiles(fileList3);
# TraceXmlXlsToCsv(xlsxTibble3, filePath = "Data/03 Agent N1 complete.new.csv");
# rm(xlsxTibble3);
# xlsxTibble4 <- ScreenXmlXlsFiles(fileList4);
# TraceXmlXlsToCsv(xlsxTibble4, filePath = "Data/04 Agent N2 complete.new.csv");
# rm(xlsxTibble4);
# xlsxTibble5 <- ScreenXmlXlsFiles(fileList5);
# TraceXmlXlsToCsv(xlsxTibble5, filePath = "Data/05 Sup SAC.new.csv");
# rm(xlsxTibble5);
#
txtFiles <- list("Data/00 Scripts start.new.txt",
                 "Data/01 Agent Niveau 1 - Evelyne made mistake and logged out.new.txt",
                 "Data/02 Agent N1 Complete Agent Web Services engage.new.txt",
                 "Data/03 Agent N1 complete.new.txt",
                 "Data/04 Agent N2 complete.new.txt",
                 "Data/05 Sup SAC.new.txt");
ScreenTxtFiles(fileList = txtFiles);
# Server info
serverInstance <- XlsToDataFrameSingleRow(xlsFile = "Data/HYSEC-SQLServerInstance.xls")$SQLServerInstance;
serverInstance <- as.character(serverInstance);
serverInstance;
serverVersion <- XlsToDataFrameSingleRow(xlsFile = "Data/HYSEC-SQLServerVersion.xls")$SQLServerVersion;
serverVersion <- as.character(serverVersion);
serverVersion;
serverService <- XlsToDataFrameSingleRow(xlsFile = "Data/HYSEC-ServiceInstance.xls")$ServiceInstance;
serverService <- as.character(serverService);
serverService;
# rm
rm(serverVersion); rm(serverService);
# Server Running
serverRunning <- XlsToDataFrame("Data/HYSEC-ServerRunning_list.xls");
serverRunning$ServerName <- as.character(serverRunning$ServerName);
serverRunning$ServiceName <- as.character(serverRunning$ServiceName);
serverRunning$ServerStarted <- as.numeric(as.character(serverRunning$ServerStarted));
serverRunning$DaysRunning <- as.numeric(as.character(serverRunning$DaysRunning));
serverRunning;
# rm
rm(serverRunning);
# Server Linked
serverLinked <- XlsToDataFrame("Data/HYSEC-ServerLinked_list.xls");
serverLinked$ServerName <- as.character(serverLinked$ServerName);
serverLinked$LinkedServerID <- as.integer(as.character(serverLinked$LinkedServerID));
serverLinked$LinkedServer <- as.character(serverLinked$LinkedServer);
serverLinked$Product <- as.character(serverLinked$Product);
serverLinked$Provider <- as.character(serverLinked$Provider);
serverLinked$DataSource <- as.character(serverLinked$DataSource);
serverLinked$ModificationDate <- as.numeric(as.character(serverLinked$ModificationDate));
serverLinked$IsLinked <- as.logical(as.character(serverLinked$IsLinked));
serverLinked;
# rm
rm(serverLinked);
# Server DB spec
serverDbSpec <- XlsToDataFrame("Data/HYSEC-ServerDBSpec_list.xls");
serverDbSpec$ServerName <- as.character(serverDbSpec$ServerName);
serverDbSpec$ServiceName <- as.character(serverDbSpec$ServiceName);
serverDbSpec$DBIdentifier <- as.integer(as.character(serverDbSpec$DBIdentifier))
serverDbSpec$DBName <- as.character(serverDbSpec$DBName);
serverDbSpec$OriginalDBName <- as.character(serverDbSpec$OriginalDBName);
#
serverDbSpec$CompatiblityLevel <- as.integer(as.character(serverDbSpec$CompatiblityLevel));
serverDbSpec$DBSize <- as.numeric(as.character(serverDbSpec$DBSize));
serverDbSpec$DBGrowth <- as.numeric(as.character(serverDbSpec$DBGrowth));
serverDbSpec$IsPercentGrowth <- as.logical(as.character(serverDbSpec$IsPercentGrowth));
serverDbSpec$CreatedDate <- as.numeric(as.character(serverDbSpec$CreatedDate));
#
serverDbSpec$AutoShrink <- as.logical(as.character(serverDbSpec$AutoShrink));
#
serverDbSpec$IsAutoUpdate <- as.logical(as.character(serverDbSpec$IsAutoUpdate));
serverDbSpec$IsArithAbort <- as.logical(as.character(serverDbSpec$IsArithAbort));
serverDbSpec$PageVerifyOption <- as.character(serverDbSpec$PageVerifyOption);
serverDbSpec$Collation <- as.character(serverDbSpec$Collation);
serverDbSpec$FilePath <- as.character(serverDbSpec$FilePath);
serverDbSpec$IdSourceDB <- as.integer(as.character(serverDbSpec$IdSourceDB));
serverDbSpec;
rm(serverDbSpec);
# Server DB Backup
serverDbBackup <- XlsToDataFrame("Data/HYSEC-ServerDBBackup_list.xls");
serverDbBackup$ServerName <- as.character.Date(serverDbBackup$ServerName);
serverDbBackup$ServiceName <- as.character(serverDbBackup$ServiceName);
serverDbBackup$DBName <- as.character(serverDbBackup$DBName);
serverDbBackup$Backup_finish_date <- as.numeric(as.character(serverDbBackup$Backup_finish_date));
serverDbBackup$Physical_Device_name <- as.character(serverDbBackup$Physical_Device_name);
serverDbBackup;
rm(serverDbBackup);
## Server DB Usage
# Server DB usage list
xlsFile <- "Data/HYSEC-Usage_list.xls";
serverDbUsageList <- XlsToDataFrame(xlsFile);
serverDbUsageList$DBIdentifier <- as.numeric(as.character(serverDbUsageList$DBIdentifier));
serverDbUsageList$DBName <- as.character(serverDbUsageList$DBName);
serverDbUsageList$DBBufferPages <- as.numeric(as.character(serverDbUsageList$DBBufferPages));
serverDbUsageList$DBBufferMB <- as.numeric(as.character(serverDbUsageList$DBBufferMB));
serverDbUsageList;
# Server DB usage plots
usagePlot <- DBUsageDataFrameToBarplot(serverDbUsageList);
GgplotToPng(XlsFileToPng(xlsFile, serverInstance, "-Barplot"), usagePlot);
usagePieChart <- DBUsageDataFrameToPiechart(serverDbUsageList);
GgplotToPng(XlsFileToPng(xlsFile, serverInstance, "-Piechart"), usagePieChart);
# Server DB usage plots all
grid.arrange(usagePlot, usagePieChart, nrow = 1, ncol = 2);
rm(serverDbUsageList); rm(usagePlot); rm(usagePieChart);
## DB All parameter
# DB All parameter list
xlsFile <- "Data/HYSEC-ParametersInFuncsAndProcs.xls";
allParametersDataFrame <- XlsToDataFrame(xlsFile);
allParametersDataFrame$ObjectName <- as.character(allParametersDataFrame$ObjectName);
allParametersDataFrame$SchemaName <- as.character(allParametersDataFrame$SchemaName);
allParametersDataFrame$ObjectTypeDesc <- as.character(allParametersDataFrame$ObjectTypeDesc);
allParametersDataFrame$ParameterID <- as.integer(as.character(allParametersDataFrame$ParameterID));
allParametersDataFrame$ParameterName <- as.character(allParametersDataFrame$ParameterName);
allParametersDataFrame$ParameterType <- as.character(allParametersDataFrame$ParameterType);
allParametersDataFrame$ParameterMaxLength <- as.integer(as.character(allParametersDataFrame$ParameterMaxLength));
allParametersDataFrame$ParameterPrecision <- as.integer(as.character(allParametersDataFrame$ParameterPrecision));
allParametersDataFrame$ParamMaxBytes <- as.integer(as.character(allParametersDataFrame$ParamMaxBytes));
allParametersDataFrame$ParameterScale <- as.integer(as.character(allParametersDataFrame$ParameterScale));
allParametersDataFrame$IsParameterOutput <- as.logical(as.character(allParametersDataFrame$IsParameterOutput));
allParametersDataFrame;
rm(allParametersDataFrame);
## DB Object
# DB object list
xlsFile <- "Data/HYSEC-Object_list.xls";
ObjectListDataFrame <- XlsToDataFrame(xlsFile);
ObjectListDataFrame$ObjectName <- as.character(ObjectListDataFrame$ObjectName);
ObjectListDataFrame$ObjectCount <- as.integer(as.character(ObjectListDataFrame$ObjectCount));
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
xlsFile <- "Data/HYSEC-Procedure_count.xls";
countStoreProc <- XlsToDataFrameSingleRow(xlsFile)$Count;
countStoreProc <- as.integer(as.character(countStoreProc));
# DB StoreProc list
xlsFile <- "Data/HYSEC-Procedure_list.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$ProcedureName <- as.character(sqlDataFrame$ProcedureName);
sqlDataFrame$ProcedureID <- as.integer(as.character(sqlDataFrame$ProcedureID));
sqlDataFrame$ProcedureType <- as.character(sqlDataFrame$ProcedureType);
sqlDataFrame$ProcedureDesc <- as.character(sqlDataFrame$ProcedureDesc);
sqlDataFrame$ProcedureCreated <- as.character(sqlDataFrame$ProcedureCreated);
sqlDataFrame$ProcedureModified <- as.character(sqlDataFrame$ProcedureModified);
sqlDataFrame$IsProcedureMSShipped <- as.logical(as.character(sqlDataFrame$IsProcedureMSShipped));
sqlDataFrame;
rm(sqlDataFrame);
# DB StoreProc param list
xlsFile <- "Data/HYSEC-Procedure_listParams.xls";
storedProcParamDataFrame <- XlsToDataFrame(xlsFile);
storedProcParamDataFrame$ProcedureName <- as.character(storedProcParamDataFrame$ProcedureName);
storedProcParamDataFrame$SchemaName <- as.character(storedProcParamDataFrame$SchemaName);
storedProcParamDataFrame$ParameterType <- as.character(storedProcParamDataFrame$ProcedureType);
storedProcParamDataFrame$ProcedureDesc <- as.character(storedProcParamDataFrame$ProcedureDesc);
storedProcParamDataFrame$ParameterID <- as.integer(as.character(storedProcParamDataFrame$ParameterID));
storedProcParamDataFrame$ParameterName <- as.character(storedProcParamDataFrame$ParameterName);
storedProcParamDataFrame$ParameterType <- as.character(storedProcParamDataFrame$ParameterType);
storedProcParamDataFrame$ParamMaxLength <- as.integer(as.character(storedProcParamDataFrame$ParamMaxLength));
storedProcParamDataFrame$ParameterPrecision <- as.integer(as.character(storedProcParamDataFrame$ParameterPrecision));
storedProcParamDataFrame$ParameterScale <- as.integer(as.character(storedProcParamDataFrame$ParameterScale));
storedProcParamDataFrame$IsParamOutput <- as.logical(as.character(storedProcParamDataFrame$IsParamOutput));
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
# DB StoreProc barplot
storeProcParamsBarplot <- StoredProcWithoutWithTotalDFToBarplot(storeProcParamsDF, OutputType);
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Procs_Barplot"), storeProcParamsBarplot);
# DB StoreProc piechart
storeProcParamsPiechart <- StoredProcWithoutWithTotalDFToPiechart(storeProcParamsDF, OutputType);
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Procs_Piechart"), storeProcParamsPiechart);
#
grid.arrange(storeProcParamsBarplot, storeProcParamsPiechart, nrow = 1, ncol = 2);
# DB StoreProc boxplot
storeProcParamsBoxplot <- DBStoreProcDataFrameToBoxplot(storedProcParamDataFrameFat);
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Procs_Boxplot"), storeProcParamsBoxplot);
# DB StoreProc density plot
storeProcParamsDensityplot <- DBStoreProcDataFrameToDensityplot(storedProcParamDataFrameFat);
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Procs_Densityplot"), storeProcParamsDensityplot);
#
grid.arrange(storeProcParamsBoxplot, storeProcParamsDensityplot, nrow = 1, ncol = 2);
# rm
rm(storedProcParamDataFrame); rm(storedProcParamDataFrameFat); rm(countStoreProc); rm(countStoreProcWith);
rm(countStoreProcWithout); rm(storeProcParamsDF); rm(OutputType); rm(storeProcParamsBarplot);
rm(storeProcParamsPiechart); rm(storeProcParamsBoxplot); rm(storeProcParamsDensityplot);
# DB Table Count CSV
xlsFile <- "Data/HYSEC-RowCount_list.xls";
tableRowCountDataFrame <- XlsToDataFrame(xlsFile);
tableRowCountDataFrame$TableName <- as.character(tableRowCountDataFrame$TableName);
tableRowCountDataFrame$TableRows <- as.integer(as.character(tableRowCountDataFrame$TableRows));
print(tableRowCountDataFrame);
# DB Table Count repeats
tableRowCountDataFrame <- aggregate(list(RowRepeats = rep(1, nrow(tableRowCountDataFrame[-1]))),
                                    tableRowCountDataFrame[-1],
                                    length);
tableRowCountDataFrame <- tibble::as_data_frame(tableRowCountDataFrame);
print(tableRowCountDataFrame);
# DB Table Count half > mean repeats
aMean <- mean(tableRowCountDataFrame$RowRepeats);
tableRowCountDataFrame <- subset(tableRowCountDataFrame, RowRepeats > aMean);
print(tableRowCountDataFrame);
# DB Table Count barplot
tableRowCountBarplot <- DBRowCountFrameToBarplot(tableRowCountDataFrame);
tableRowCountBarplot;
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Histogram"), tableRowCountBarplot);
# rm()
rm(xlsFile); rm(tableRowCountDataFrame); rm(aMean); rm(tableRowCountBarplot);
## DB Table Analysis
# DB Table Analysis count
xlsFile <- "Data/HYSEC-Table_count.xls";
countTable <- XlsToDataFrame(xlsFile);
print(paste0("Table Analysis count: ", countTable$Count));
# rm()
rm(xlsFile); rm(countTable);
# DB Table Analysis list
xlsFile <- "Data/HYSEC-Table_list.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$TableName <- as.character(sqlDataFrame$TableName);
sqlDataFrame$TableID <- as.integer(as.character(sqlDataFrame$TableID));
sqlDataFrame$TableType <- as.character(sqlDataFrame$TableType);
sqlDataFrame$TableDesc <- as.character(sqlDataFrame$TableDesc);
sqlDataFrame$TableCreated <- as.numeric(as.character(sqlDataFrame$TableCreated)); #
sqlDataFrame$TableModified <- as.numeric(as.character(sqlDataFrame$TableModified)); #
sqlDataFrame$MaxColumnIDUsed <- as.integer(as.character(sqlDataFrame$MaxColumnIDUsed));
sqlDataFrame$IsUsingANSINulls <- as.logical(as.character(sqlDataFrame$IsUsingANSINulls));
sqlDataFrame$LOBDataSpaceID <- as.integer(as.character(sqlDataFrame$LOBDataSpaceID));
print(sqlDataFrame);
# rm()
rm(xlsFile); rm(sqlDataFrame);
# DB Table Analysis Independent
xlsFile <- "Data/HYSEC-TableIndependent_list.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$TableWoParentWoDependents <- as.character(sqlDataFrame$TableWoParentWoDependents);
sqlDataFrame$TableID <- as.integer(as.character(sqlDataFrame$TableID));
sqlDataFrame$TableType <- as.character(sqlDataFrame$TableType);
sqlDataFrame$TableDesc <- as.character(sqlDataFrame$TableDesc);
sqlDataFrame$TableCreated <- as.numeric(as.character(sqlDataFrame$TableCreated)); #
sqlDataFrame$TableModified <- as.numeric(as.character(sqlDataFrame$TableModified)); #
sqlDataFrame$MaxColumnIDUsed <- as.integer(as.character(sqlDataFrame$MaxColumnIDUsed));
sqlDataFrame$IsUsingANSINulls <- as.logical(as.character(sqlDataFrame$IsUsingANSINulls));
sqlDataFrame$LOBDataSpaceID <- as.integer(as.character(sqlDataFrame$LOBDataSpaceID));
print(paste0("Table Independent list count: ", nrow(sqlDataFrame)));
print(sqlDataFrame);
# rm()
rm(xlsFile); rm(sqlDataFrame);
# DB Table Analysis Trunk
xlsFile <- "Data/HYSEC-TableTrunk_list.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$TableLeafName <- as.character(sqlDataFrame$TableTrunkName);
print(paste0("Table Trunk list count: ", nrow(sqlDataFrame)));
print(sqlDataFrame);
# rm()
rm(xlsFile); rm(sqlDataFrame);
# DB Table Analysis Leaf
xlsFile <- "Data/HYSEC-TableLeaf_list.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$TableWoParentWoDependents <- as.character(sqlDataFrame$TableLeafName);
print(paste0("Table Leaf list count: ", nrow(sqlDataFrame)));
print(sqlDataFrame);
# rm()
rm(xlsFile); rm(sqlDataFrame);
# DB Table Analysis Parent
xlsFile <- "Data/HYSEC-TableParent_list.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$TableParent <- as.character(sqlDataFrame$TableParent);
sqlDataFrame$TableChild <- as.character(sqlDataFrame$TableChild);
sqlDataFrame$FKName <- as.character(sqlDataFrame$FKName);
print(paste0("Table Parent list count: ", nrow(sqlDataFrame)));
print(sqlDataFrame);
# rm()
rm(xlsFile); rm(sqlDataFrame);
# DB Table Analysis keys list
xlsFile <- "Data/HYSEC-Table_listKeys.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$TableName <- as.character(sqlDataFrame$TableName);
sqlDataFrame$PKName <- as.character(sqlDataFrame$PKName);
sqlDataFrame$FKName <- as.character(sqlDataFrame$FKName);
sqlDataFrame$ColumnName <- as.character(sqlDataFrame$ColumnName);
print(paste0("Table Key list count: ", nrow(sqlDataFrame)));
print(sqlDataFrame);
# rm()
rm(xlsFile); rm(sqlDataFrame);
## View Analysis
# View Analysis count
xlsFile <- "Data/HYSEC-View_count.xls";
countView <- XlsToDataFrame(xlsFile);
countView <- as.integer(as.character(countView$Count));
# View Analysis list
xlsFile <- "Data/HYSEC-View_list.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$ViewName <- as.character(sqlDataFrame$ViewName);
sqlDataFrame$ViewID <- as.integer(as.character(sqlDataFrame$ViewID));
sqlDataFrame$ViewType <- as.character(sqlDataFrame$ViewType);
sqlDataFrame$ViewDesc <- as.character(sqlDataFrame$ViewDesc);
sqlDataFrame$ViewCreated <- as.numeric(as.character(sqlDataFrame$ViewCreated)); #
sqlDataFrame$ViewModified <- as.numeric(as.character(sqlDataFrame$ViewModified)); #
sqlDataFrame$IsIndexed <- as.integer(as.character(sqlDataFrame$IsIndexed));
sqlDataFrame$IsIndexable <- as.integer(as.character(sqlDataFrame$IsIndexable));
print(paste0("View list count: ", nrow(sqlDataFrame)));
print(sqlDataFrame);
# rm()
rm(countView); rm(xlsFile); rm(sqlDataFrame);
## Function Analysis
# Function Analysis count
xlsFile <- "Data/HYSEC-Function_count.xls";
countFunc <- XlsToDataFrame(xlsFile);
countFunc <- as.integer(as.character(countFunc$Count));
# Function Analysis list
xlsFile <- "Data/HYSEC-Function_list.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$FunctionName <- as.character(sqlDataFrame$FunctionName);
sqlDataFrame$FunctionID <- as.integer(as.character(sqlDataFrame$FunctionID));
sqlDataFrame$FunctionType <- as.character(sqlDataFrame$FunctionType);
sqlDataFrame$FunctionDesc <- as.character(sqlDataFrame$FunctionDesc);
sqlDataFrame$FunctionCreated <- as.numeric(as.character(sqlDataFrame$FunctionCreated)); #
sqlDataFrame$FunctionModified <- as.numeric(as.character(sqlDataFrame$FunctionModified)); #
print(paste0("Function list count: ", nrow(sqlDataFrame)));
print(sqlDataFrame);
# Function Analysis list barplot
fnTypeBarplot <- DataFrameColumnToBarplot(sqlDataFrame, columnName = "FunctionType");
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Barplot"), fnTypeBarplot);
# Function Analysis list piechart
fnTypePiechart <- DataFrameColumnToPiechart(sqlDataFrame, columnName = "FunctionType");
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Piechart"), fnTypePiechart);
# Function Analysis list grid
grid.arrange(fnTypeBarplot, fnTypePiechart, nrow = 1, ncol = 2);
# rm
rm(xlsFile); rm(sqlDataFrame); rm(fnTypeBarplot); rm(fnTypePiechart);
# Function Analysis param list
xlsFile <- "Data/HYSEC-Function_listParams.xls";
functionParamsDataFrame <- XlsToDataFrame(xlsFile);
functionParamsDataFrame$FunctionName <- as.character(functionParamsDataFrame$FunctionName);
functionParamsDataFrame$SchemaName <- as.character(functionParamsDataFrame$SchemaName);
functionParamsDataFrame$FunctionType <- as.character(functionParamsDataFrame$FunctionType);
functionParamsDataFrame$FunctionDesc <- as.character(functionParamsDataFrame$FunctionDesc);
functionParamsDataFrame$ParameterID <- as.integer(as.character(functionParamsDataFrame$ParameterID));
functionParamsDataFrame$ParameterName <- as.character(functionParamsDataFrame$ParameterName);
functionParamsDataFrame$ParameterType <- as.character(functionParamsDataFrame$ParameterType);
functionParamsDataFrame$ParamMaxLength <- as.integer(as.character(functionParamsDataFrame$ParamMaxLength));
functionParamsDataFrame$ParameterPrecision <- as.integer(as.character(functionParamsDataFrame$ParameterPrecision));
functionParamsDataFrame$ParameterScale <- as.integer(as.character(functionParamsDataFrame$ParameterScale));
functionParamsDataFrame$IsParamOutput <- as.logical(as.character(functionParamsDataFrame$IsParamOutput));
print(functionParamsDataFrame);
fnParamsDataFrameSlim <- DataFrameFromColumns(functionParamsDataFrame,
                                              "FunctionName",
                                              "FunctionType",
                                              "FunctionDesc");
print(fnParamsDataFrameSlim);
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
print(fnParamsDF);
# Function Analysis barplot
fnParamsBarplot <- FunctionWithoutWithTotalDFToBarplot(fnParamsDF, OutputType);
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Barplot"), fnParamsBarplot);
# Function Analysis piechart
fnParamsPiechart <- FunctionWithoutWithTotalDFToPiechart(fnParamsDF, OutputType = "Function");
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Piechart"), fnParamsPiechart);
#
grid.arrange(fnParamsBarplot, fnParamsPiechart, nrow = 1, ncol = 2);
# Function Analysis boxplot
fnParamsBoxplot <- DBFunctionDataFrameToBoxplot(fnParamsDataFrameFat);
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Boxplot"), fnParamsBoxplot);
# Function Analysis density plot
fnParamsDensityplot <- DBFunctionDataFrameToDensityplot(fnParamsDataFrameFat);
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Densityplot"), fnParamsDensityplot);
#
grid.arrange(fnParamsBoxplot, fnParamsDensityplot, nrow = 1, ncol = 2);
# rm()
rm(xlsFile); rm(countFunc);
rm(functionParamsDataFrame); rm(fnParamsDataFrameSlim); rm(fnParamsDataFrameFat);
rm(countFuncWith); rm(countFuncWithout); rm(OutputType);
rm(fnParamsDF); rm(fnParamsBarplot); rm(fnParamsPiechart);
rm(fnParamsBoxplot); rm(fnParamsDensityplot);
## PKey Analysis
# PKey Analysis count
xlsFile <- "Data/HYSEC-PKeys_count.xls";
countPKeys <- XlsToDataFrame(xlsFile);
countPKeys <- as.character(countPKeys$Count);
# PKey Analysis list
xlsFile <- "Data/HYSEC-PKeys_list.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$TableName <- as.character(sqlDataFrame$TableName);
sqlDataFrame$ColumnName <- as.character(sqlDataFrame$ColumnName);
sqlDataFrame$PrincipalKey <- as.character(sqlDataFrame$PrincipalKey);
sqlDataFrame$PrincipalKeyID <- as.integer(as.character(sqlDataFrame$PrincipalKeyID));
sqlDataFrame$PKCreated <- as.numeric(as.character(sqlDataFrame$PKCreated));
sqlDataFrame$PKModified <- as.numeric(as.character(sqlDataFrame$PKModified));
sqlDataFrame$PKOrdinal <- as.integer(as.character(sqlDataFrame$PKOrdinal));
print(paste0("PKey list count: ", nrow(sqlDataFrame)));
print(sqlDataFrame);
# PKey Analysis list histogram
aTable <- ColumnDataFrameToFrequencyTable(sqlDataFrame, columnName = "TableName");
aTibble <- FrequencyTableToTibble(aTable, aTitle = "PrincipalKeyTable");
principalKeyHistogram <- TwoColumnDataFrameToHistogram(aTibble, mainTitle = "PrincipalKey per Table");
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Histogram"), principalKeyHistogram);
# rm
rm(countPKeys); rm(xlsFile); rm(sqlDataFrame);
rm(aTable); rm(aTibble); rm(principalKeyHistogram);
## FKey Analysis
# FKey Analysis count
xlsFile <- "Data/HYSEC-FKeys_count.xls";
countFKeys <- XlsToDataFrame(xlsFile);
countFKeys <- as.integer(as.character(countFKeys$Count));
# FKey Analysis list
xlsFile <- "Data/HYSEC-FKeys_list.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$TableName <- as.character(sqlDataFrame$TableName);
sqlDataFrame$ColumnName <- as.character(sqlDataFrame$ColumnName);
sqlDataFrame$ForeignKey <- as.character(sqlDataFrame$ForeignKey);
sqlDataFrame$ForeignKeyID <- as.character(sqlDataFrame$ForeignKey);
sqlDataFrame$ReferenceTableName <- as.character(sqlDataFrame$ReferenceTableName);
sqlDataFrame$ReferenceColumnName <- as.character(sqlDataFrame$ReferenceColumnName);
sqlDataFrame$FKCreated <- as.numeric(as.character(sqlDataFrame$FKCreated));
sqlDataFrame$FKModified <- as.numeric(as.character(sqlDataFrame$FKModified));
sqlDataFrame$FKnotTrusted <- as.logical(as.character(sqlDataFrame$FKnotTrusted));
sqlDataFrame$OnDelete <- as.character(sqlDataFrame$OnDelete);
sqlDataFrame$OnUpdate <- as.character(sqlDataFrame$OnUpdate);
print(paste0("FKeys list count: ", nrow(sqlDataFrame)));
print(sqlDataFrame);
# FKey Analysis list histogram
aTable <- ColumnDataFrameToFrequencyTable(sqlDataFrame, columnName = "TableName");
aTibble <- FrequencyTableToTibble(aTable, aTitle = "PrincipalKeyTable");
fKeyHistogram <- TwoColumnDataFrameToHistogram(aTibble, mainTitle = "ForeignKey per Table");
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Histogram"), fKeyHistogram);
# rm
rm(countFKeys); rm(xlsFile); rm(sqlDataFrame);
rm(aTable); rm(aTibble); rm(fKeyHistogram);
## Index Analysis
# Index Analysis count
xlsFile <- "Data/HYSEC-Index_count.xls";
countIndex <- XlsToDataFrame(xlsFile);
countIndex <- as.integer(as.character(countIndex$Count));
# Index Analysis list
xlsFile <- "Data/HYSEC-Index_list.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$DBName <- as.character(sqlDataFrame$DBName);
sqlDataFrame$TableName <- as.character(sqlDataFrame$TableName);
sqlDataFrame$ColumnNumber <- as.integer(as.character(sqlDataFrame$ColumnNumber));
sqlDataFrame$ColumnName <- as.character(sqlDataFrame$ColumnName);
sqlDataFrame$ConstraintName <- as.character(sqlDataFrame$ConstraintName);
sqlDataFrame$ConstraintType <- as.character(sqlDataFrame$ConstraintType);
sqlDataFrame$ConstraintDescription <- as.character(sqlDataFrame$ConstraintDescription);
sqlDataFrame$CreatedDate <- as.numeric(as.character(sqlDataFrame$CreatedDate));#
sqlDataFrame$ConstraintDefinition <- as.character(sqlDataFrame$ConstraintDefinition);
sqlDataFrame$UsesDBCollation <- as.logical(as.character(sqlDataFrame$UsesDBCollation));
sqlDataFrame$IsSystemNamed <- as.logical(as.character(sqlDataFrame$IsSystemNamed));
print(sqlDataFrame);
# Index Analysis list histogram
aTable <- ColumnDataFrameToFrequencyTable(sqlDataFrame, columnName = "TableName");
aTibble <- FrequencyTableToTibble(aTable, aTitle = "IndexPerTable");
indexesHistogram <- TwoColumnDataFrameToHistogram(aTibble, mainTitle = "Index per Table");
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Histogram"), indexesHistogram);
# rm
rm(countIndex); rm(xlsFile); rm(sqlDataFrame);
rm(aTable); rm(aTibble); rm(indexesHistogram);
# Index Analysis type list
xlsFile <- "Data/HYSEC-Index_listTypes.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$TableName <- as.character(sqlDataFrame$TableName);
sqlDataFrame$TableType <- as.character(sqlDataFrame$TableType);
sqlDataFrame$TableDesc <- as.character(sqlDataFrame$TableDesc);
sqlDataFrame$TableIndexID <- as.integer(as.character(sqlDataFrame$TableIndexID));
sqlDataFrame$IndexName <- as.character(sqlDataFrame$IndexName);
sqlDataFrame$IndexID <- as.integer(as.character(sqlDataFrame$IndexID)) ;
sqlDataFrame$IndexType <- as.character(sqlDataFrame$IndexType);
sqlDataFrame$ConstraintType <- as.character(sqlDataFrame$ConstraintType);
sqlDataFrame$AllocUnitID <- as.numeric(as.character(sqlDataFrame$AllocUnitID));
print(paste0("Index Type list count: ", nrow(sqlDataFrame)));
print(sqlDataFrame);
# rm
rm(xlsFile); rm(sqlDataFrame);
## Constraint Analysis
# Constraint Analysis List
xlsFile <- "Data/HYSEC-Constraint_list.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$DBName <- as.character(sqlDataFrame$DBName);
sqlDataFrame$TableName <- as.character(sqlDataFrame$TableName);
sqlDataFrame$ColumnNumber <- as.integer(as.character(sqlDataFrame$ColumnNumber));
sqlDataFrame$ColumnName <- as.character(sqlDataFrame$ColumnName);
sqlDataFrame$ConstraintName <- as.character(sqlDataFrame$ConstraintName);
sqlDataFrame$ConstraintType <- as.character(sqlDataFrame$ConstraintType);
sqlDataFrame$ConstraintDescription <- as.character(sqlDataFrame$ConstraintDescription);
#
sqlDataFrame$ConstraintDefinition <- as.character(sqlDataFrame$ConstraintDefinition);
print(paste0("Constraint list count: ", nrow(sqlDataFrame)));
print(sqlDataFrame);
sqlDataFrame <- ConstraintToTableNameFrequency(sqlDataFrame);
constraintBarplot <- TwoColumnDataFrameToBarlot(sqlDataFrame);
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Barplot"), constraintBarplot);
# rm()
rm(xlsFile); rm(sqlDataFrame); rm(constraintBarplot);
# Trigger Analysis
## Trigger Analysis List
xlsFile <- "Data/HYSEC-Trigger_list.xls";
sqlDataFrame <- XlsToDataFrame(xlsFile);
sqlDataFrame$TableName <- as.character(sqlDataFrame$TableName);
sqlDataFrame$TriggerObjectId <- as.integer(as.character(sqlDataFrame$TriggerObjectId));
sqlDataFrame$TriggerName <- as.character(sqlDataFrame$TriggerName);
sqlDataFrame$TriggerText <- as.character(sqlDataFrame$TriggerText);
sqlDataFrame$TriggerCreation <- as.numeric(as.character(sqlDataFrame$TriggerCreation));
sqlDataFrame$TriggerRefDate <- as.numeric(as.character(sqlDataFrame$TriggerRefDate));
sqlDataFrame$TriggerVersion <- as.integer(as.character(sqlDataFrame$TriggerVersion));
sqlDataFrame$TriggerType <- as.character(sqlDataFrame$TriggerType);
sqlDataFrame$ObjectType <- as.character(sqlDataFrame$ObjectType);
sqlDataFrame$TriggerDesc <- as.character(sqlDataFrame$TriggerDesc);
sqlDataFrame$IsInsteadOfTrigger <- as.logical(as.character(sqlDataFrame$IsInsteadOfTrigger));
sqlDataFrame$IsUpdate <- as.logical(as.integer(as.character(sqlDataFrame$IsUpdate)));
sqlDataFrame$IsDelete <- as.logical(as.integer(as.character(sqlDataFrame$IsDelete)));
sqlDataFrame$IsInsert <- as.logical(as.integer(as.character(sqlDataFrame$IsInsert)));
sqlDataFrame$IsAfterTrigger <- as.logical(as.integer(as.character(sqlDataFrame$IsAfterTrigger)));
### trigger group
sqlDataFrame$TriggerGroup <- "";
for(i in 1:length(sqlDataFrame$IsAfterTrigger)){
  itIs <- as.logical(sqlDataFrame$IsAfterTrigger[i]);

  if(itIs == TRUE){
    sqlDataFrame$TriggerGroup[i] <- "AfterTrigger";
  } else {
    sqlDataFrame$TriggerGroup[i] <- "InsteadOfTrigger";
  }
}
rm(i); rm(itIs) ;
### trigger subgroup
sqlDataFrame$TriggerSubgroup <- "";
for(i in 1:length(sqlDataFrame$IsAfterTrigger)){
  itIs <- as.logical(sqlDataFrame$IsAfterTrigger[i]);

  if(itIs == TRUE){
    sqlDataFrame$TriggerSubgroup[i] <- "After";
  } else {
    sqlDataFrame$TriggerSubgroup[i] <- "InsteadOf";
  }

  isUpdate <- as.logical(sqlDataFrame$IsUpdate[i]);

  if(isUpdate == TRUE){
    sqlDataFrame$TriggerSubgroup[i] <- paste0(sqlDataFrame$TriggerSubgroup[i], "Update");
  }

  isDelete <- as.logical(sqlDataFrame$IsDelete[i]);

  if(isDelete == TRUE){
    sqlDataFrame$TriggerSubgroup[i] <- paste0(sqlDataFrame$TriggerSubgroup[i], "Delete");
  }

  isInsert <- as.logical(sqlDataFrame$IsInsert[i]);

  if(isInsert == TRUE){
    sqlDataFrame$TriggerSubgroup[i] <- paste0(sqlDataFrame$TriggerSubgroup[i], "Insert");
  }
}
rm(i); rm(itIs) ;
rm(isDelete); rm(isInsert); rm(isUpdate);
###
sqlDataFrame[,10:17];
## Trigger Analysis List histogram
aTable <- ColumnDataFrameToFrequencyTable(sqlDataFrame, columnName = "TableName");
aTibble <- FrequencyTableToTibble(aTable, aTitle = "TriggerPerTable");
triggersHistogram <- TwoColumnDataFrameToHistogram(aTibble, mainTitle = "Trigger per Table");
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Histogram"), triggersHistogram);
## Trigger Group Analysis List barplot
triggerGroupBarplot <- DataFrameColumnToBarplot(sqlDataFrame, columnName = "TriggerGroup");
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Barplot"), triggerGroupBarplot);
## Trigger Group Analysis List piechart
triggerGroupPiechart <- DataFrameColumnToPiechart(sqlDataFrame, columnName = "TriggerGroup");
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Piechart"), triggerGroupPiechart);
## Trigger Group Analysis List grid
grid.arrange(triggerGroupBarplot, triggerGroupPiechart, nrow = 1, ncol = 2);
# Trigger Subgroup After
## Trigger Sub Group After Analysis List barplot
triggerSubgroupBarplot <- DataFrameColumnToBarplot(sqlDataFrame[grepl("^After", sqlDataFrame$TriggerSubgroup), ],
                                                   columnName = "TriggerSubgroup");
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Barplot-SubgroupAfter"), triggerSubgroupBarplot);
## Trigger Sub Group After Analysis List piechart
triggerSubgroupPiechart <- DataFrameColumnToPiechart(sqlDataFrame[grepl("^After", sqlDataFrame$TriggerSubgroup), ],
                                                     columnName = "TriggerSubgroup");
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Piechart-SubgroupAfter"), triggerSubgroupPiechart);
## Trigger Sub Group After Analysis List grid
grid.arrange(triggerSubgroupBarplot, triggerSubgroupPiechart, nrow = 1, ncol = 2);
# Trigger Subgroup InsteadOf
## Trigger Sub Group InsteadOf Analysis List barplot
triggerSubgroupBarplot <- DataFrameColumnToBarplot(sqlDataFrame[!grepl("^After", sqlDataFrame$TriggerSubgroup), ],
                                                   columnName = "TriggerSubgroup");
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Barplot-SubgroupInsteadOf"), triggerSubgroupBarplot);
## Trigger Sub Group InsteadOf Analysis List piechart
triggerSubgroupPiechart <- DataFrameColumnToPiechart(sqlDataFrame[!grepl("^After", sqlDataFrame$TriggerSubgroup), ],
                                                     columnName = "TriggerSubgroup");
GgplotToPng(XlsFileToPng(xlsFile, "HYSEC", "-Piechart-SubgroupInsteadOf"), triggerSubgroupPiechart);
## Trigger Sub Group InsteadOf Analysis List grid
grid.arrange(triggerSubgroupBarplot, triggerSubgroupPiechart, nrow = 1, ncol = 2);
# rm()
rm(xlsFile); rm(sqlDataFrame);
rm(aTable); rm(aTibble); rm(triggersHistogram);
rm(triggerGroupBarplot); rm(triggerGroupPiechart);
rm(triggerSubgroupBarplot); rm(triggerSubgroupPiechart);
