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
# wordcloud lib
wordcloudUtil <- paste0(c("Lib/", "wordcloud", ".Util.R"), sep = "", collapse = "");
write(paste0(c("Load Util........\t", wordcloudUtil), sep = "", collapse = ""), stdout());
source(wordcloudUtil);
# password
dbUser <- "sa";
dbPass <- GetDBPassword("ASKIDA_ENV");
# RODBC SimmqDB
library(RODBC);
simmqODBC <- odbcConnect("SimmqDB", uid = dbUser, pwd = dbPass);
# Server info
serverInstance <- SqlCountResultToString(simmqODBC, "Select @@SERVERNAME     AS SQLServerInstance;");
serverVersion <- SqlCountResultToString(simmqODBC, "Select @@VERSION        AS SQLServerVersion;");
serverService <- SqlCountResultToString(simmqODBC, "Select @@ServiceName    AS ServiceInstance;");
# DB list
dbList <- c("mmq", "Claims_MMQ");
dbList <- sort(dbList);
#
for (dbInstance in dbList) {
  write(dbInstance, stdout());
  # select DB
  sqlInstance <- paste0(c("USE ", dbInstance, ";"), sep = "", collapse = "");
  write(sqlInstance, stdout());
  sqlQuery(simmqODBC, sqlInstance);
  # DB table footprint
  sqlFile <- "SQL/DB-Table_listFootprint.sql";
  tableFootprintDataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  print(head(tableFootprintDataFrame));
  DataFrameToCsv(tableFootprintDataFrame,
                 SqlFileToCsv(sqlFile, dbInstance, "-TableFootprint"));
  # DB table footprint rm IndexName
  tableFootprintDataFrame$IndexName <- NULL;
  print(colnames(tableFootprintDataFrame));
  # DB table footprint total
  countTables <- nrow(tableFootprintDataFrame);
  print(paste0("DB table footprint total: ", countTables));
  # DB table footprint means
  tableWords <- TableFootprintAboveMeans(tableFootprintDataFrame);
  print("DB table footprint means: ");
  print(names(tableWords));
  # DB table footprint wordcloud
  corpusWords <- Corpus(VectorSource(tableWords))
  print("DB table footprint wordcloud: ");
  inspect(corpusWords);
  termDocMatrixSortDesc <- sort(rowSums(as.matrix(TermDocumentMatrix(corpusWords))),
                                decreasing  = TRUE);
  termDocDataFrameSortDesc <- data.frame(word = names(termDocMatrixSortDesc),
                                         freq = termDocMatrixSortDesc);
  termDocDataFrameSortDesc <- tibble::as_data_frame(termDocDataFrameSortDesc);
  print(head(termDocDataFrameSortDesc));
  DataFrameToCsv(termDocDataFrameSortDesc,
                 SqlFileToCsv(sqlFile, dbInstance, "-TableFootprintWordcloud"));
  WordcloudToPng(termDocDataFrameSortDesc,
                SqlFileToPng(sqlFile, dbInstance, "-TableFootprintWordCloud"));
#   # WorcloudToBarplot
#   termDocDataFrameSortDescBarplot <- WorcloudToBarplot(termDocDataFrameSortDesc);
#   termDocDataFrameSortDescBarplot;
#   print(class(termDocDataFrameSortDescBarplot));
#   print(typeof(termDocDataFrameSortDescBarplot));
#   print(length(termDocDataFrameSortDescBarplot));
#   GgplotToPng(SqlFileToPng(sqlFile, dbInstance, "-TableFootprintBarplot"),
#               termDocDataFrameSortDescBarplot);
  ## DB table IO
  sqlFile <- "SQL/DB-Table_listIO.sql";
  tableIODataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  print("DB table IO: ");
  DataFrameToCsv(tableIODataFrame,
                 SqlFileToCsv(sqlFile, dbInstance, "-TableIO"));
  # DB table IO Q plot
  ioRatioTableQplot <- DBTableRatioToQplot(tableIODataFrame);
  ioRatioTableQplot;
  print("DB table IO Q Plot: ");
  GgplotToPng(SqlFileToPng(sqlFile, dbInstance, "-TableIORatiosQplot"), ioRatioTableQplot);
  # DB table IO ratio stacked histogram
  ioRatioTableDF <- MinimizeTableIO(tableIODataFrame);
  print(head(ioRatioTableDF));
  print("DB table IO Ratios: ");
  DataFrameToCsv(ioRatioTableDF,
                 SqlFileToCsv(sqlFile, dbInstance, "-TableIORatios"));
  # DB table IO stacked plot
  ioRatioTableStackeplot <- DBTableRatioToStackeplot(ioRatioTableDF);
  ioRatioTableStackeplot;
  print("DB table IO Stacked Plot: ");
  GgplotToPng(SqlFileToPng(sqlFile, dbInstance, "-TableIORatiosStackedplot"), ioRatioTableStackeplot);
  ## DB StoredProc IO
  sqlFile <- "SQL/DB-Procedure_listIO.sql";
  storedProcIODataFrame <- SqlResultToDataFrame(simmqODBC, GetSqlFromFile(sqlFile));
  print("DB StoredProc IO: ");
  print(head(storedProcIODataFrame));
  DataFrameToCsv(storedProcIODataFrame,
                 SqlFileToCsv(sqlFile, dbInstance, "-StoredProcIO"));

 if (nrow(storedProcIODataFrame) > 1) {
    # DB StoredProc IO ratio stacked histogram
    storedProcIORatioDF <- MinimizeStoredProcIO(storedProcIODataFrame);
    print("DB StoredProc IO Ratios: ");
    print(head(storedProcIORatioDF));
    DataFrameToCsv(storedProcIORatioDF,
                   SqlFileToCsv(sqlFile, dbInstance, "-StoredProcIORatios"));
    # DB StoredProc IO stacked plot
    StoredProcIORatiosStackedplot <- DBStoredProcRatioToStackeplot(storedProcIORatioDF);
    StoredProcIORatiosStackedplot;
    print("DB StoredProc IO Ratios Stacked Plot: ");
    GgplotToPng(SqlFileToPng(sqlFile, dbInstance, "-StoredProcIORatiosStackedplot"), StoredProcIORatiosStackedplot);
    # DB StoredProc IO Q plot
    StoredProcIORatiosQplot <- DBStoredProcRatioToQplot(storedProcIODataFrame);
    StoredProcIORatiosQplot;
    print("DB StoredProc IO Ratios Q Plot: ");
    GgplotToPng(SqlFileToPng(sqlFile, dbInstance, "-StoredProcIORatiosQplot"), StoredProcIORatiosQplot);
  }
}
# RODBC close
odbcClose(simmqODBC);
