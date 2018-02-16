#' Title  GetDBPassword
#'
#' @param environmentVariable
#'
#' @return string
#' @export TBD
#'
#' @examples TBD
GetDBPassword <- function(environmentVariable = "ASKIDA_ENV") {
  dbPass <- "";
  if (Sys.getenv(environmentVariable) == "") {
    dbPass <- "";
  } else {
    if (Sys.getenv(environmentVariable) == "PROD") {
      dbPass <- "!_simmmq01_!";
    } else {
      dbPass <- "!_simmq01_!";
    }
  }
  return(dbPass);
}
#' Title  SetAskidaPath
#'
#' @param aNamespace
#'
#' @return void
#' @export TBD
#'
#' @examples TBD
SetAskidaPath <- function(aNamespace="") {
  # namespace
  if (aNamespace == "") {
    aNamespace <- "SqlServerWithODBC";
  }
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
}
#' Title  GetSqlFromFile
#'
#' @param aSqlFilePath
#'
#' @return string
#' @export TBD
#'
#' @examples TBD
GetSqlFromFile <- function(aSqlFilePath = "") {
  sqlCommand <- "";
  sqlCommand <- readLines(aSqlFilePath);
  sqlCommand <- paste(sqlCommand, collapse = " ");
  #write(sqlCommand, stdout());

  return(sqlCommand);
}
#
#
#
DataFrameToCsv <- function(dataFrame = NULL, csvFile = ""){
  write.csv(dataFrame, csvFile, row.names = FALSE);
}
#
#
#
SqlFileToCsv <- function(sqlFilePath="", dbName="", chartName=""){
  # extension time
  timeNow <- format(Sys.time(), "-%Y-%m-%d_%Hh%M");
  timeExt <- paste0(timeNow, chartName, ".csv");
  # csv
  csvFilePath <- gsub(".sql", timeExt, sqlFilePath);
  csvFilePath <- gsub("SQL/", paste0("./ODBC/", dbName, "-", Sys.getenv("ASKIDA_ENV"), "-"), csvFilePath);

  return(csvFilePath);
}
#
#
#
SqlFileToPng <- function(sqlFilePath="", dbName="", chartName=""){
  # extension time
  timeNow <- format(Sys.time(), "-%Y-%m-%d_%Hh%M");
  timeExt <- paste0(timeNow, chartName, ".png");
  # png
  filePath <- gsub(".sql", timeExt, sqlFilePath);
  filePath <- gsub("SQL/", paste0("./ODBC/", dbName, "-", Sys.getenv("ASKIDA_ENV"), "-"), filePath);

  return(filePath);
}
#' Title  SummarizeDBFunctionDataFrame
#'
#' @param objectDataFrame
#' @param functionFilter
#'
#' @return data.frame
#' @export TBD
#'
#' @examples TBD
SummarizeDBFunctionDataFrame <- function(objectDataFrame, functionFilter="Function"){
  colnames <- colnames(objectDataFrame);
  # separate functions
  functionsDataFrame <- subset(objectDataFrame, grepl(paste0("^", functionFilter), objectDataFrame[[1]]), drop = TRUE);
  # sum functions
  functionsDataFrame <- data.frame(functionFilter, sum(functionsDataFrame[[2]]));
  colnames(functionsDataFrame) <- colnames;
  # remove functions
  objectDataFrame <- subset(objectDataFrame, !grepl(paste0("^", functionFilter), objectDataFrame[[1]]), drop = TRUE);
  # add sum functions
  objectDataFrame <- rbind(objectDataFrame, functionsDataFrame);

  return(tibble::as_data_frame(objectDataFrame));
}
#' Title  SummarizeAllDBFunctionDataFrame
#'
#' @param objectDataFrame
#' @param functionFilter
#'
#' @return data.frame
#' @export TBD
#'
#' @examples TBD
SummarizeAllDBFunctionDataFrame <- function(objectDataFrame, functionFilter="Function"){
  colnames <- colnames(objectDataFrame);
  # separate functions
  functionsDataFrame <- subset(objectDataFrame, grepl(paste0("^", functionFilter), objectDataFrame[[1]]), drop = TRUE);
  colnames <- c("FunctionTypes", "FunctionCount");
  colnames(functionsDataFrame) <- colnames;

  return(tibble::as_data_frame(functionsDataFrame));
}
#' Title  DataFrameFromColumns
#'
#' @param aDataFrame
#' @param colName1
#' @param colName2
#' @param colName3
#'
#' @return data.frame
#' @export TBD
#'
#' @examples TBD
DataFrameFromColumns <- function(aDataFrame = NULL,
                                 colName1 = "",
                                 colName2 = "",
                                 colName3 = ""){
  columnList <- c(colName1, colName2, colName3);
  write(columnList, stdout());
  indexList <- which(colnames(aDataFrame) %in% columnList);
  write(indexList, stdout());

  return(tibble::as_data_frame(aDataFrame[indexList]));
}
#' Title  DataFrameWithoutWithTotal
#'
#' @param intWithout
#' @param intWith
#' @param intTotal
#' @param OutputType
#'
#' @return data.frame
#' @export TBD
#'
#' @examples TBD
DataFrameWithoutWithTotal <- function(intWithout = 1,
                                      intWith = 1,
                                      intTotal = 2,
                                      OutputType = ""){
  aDataFrame <- data.frame(NULL);
  aDataFrame[1, 1] <- intWithout;
  aDataFrame[1, 2] <- intWith;
  aDataFrame[1, 3] <- intTotal;
  colnames(aDataFrame) <- c(paste0(OutputType,"WithoutParameters"),
                            paste0(OutputType,"WithParameters"),
                            paste0(OutputType,"Total"));

  return(tibble::as_data_frame(aDataFrame));
}
#' Title  MinimizeStoredProcIO
#'
#' @param data.frame
#'
#' @return data.frame
#' @export TBD
#'
#' @examples TBD
MinimizeStoredProcIO <- function(aDataFrame = NULL){

  if (is.null(aDataFrame)) {

    return(NULL);
  } else {
    aDataFrame$CachedTime <- NULL;
    aDataFrame$TotalElapsedTime <- NULL;
    aDataFrame$ExecutionCount <- NULL;
    aDataFrame$TotalPhysicalReads <- NULL;
    aDataFrame$LogicalWritesRatio <- aDataFrame$TotalLogicalWrites/(aDataFrame$TotalLogicalReads + aDataFrame$TotalLogicalWrites);
    aDataFrame$LogicalReadsRatio <- aDataFrame$TotalLogicalReads/(aDataFrame$TotalLogicalReads + aDataFrame$TotalLogicalWrites);
    aDataFrame$TotalLogicalWrites <- NULL;
    aDataFrame$TotalLogicalReads <- NULL;
    aDataFrame <- melt(aDataFrame, if.var = StoreProcName);

    return(tibble::as_data_frame(aDataFrame));
  }
}
#' Title  MinimizeTableIO
#'
#' @param data.frame
#'
#' @return data.frame
#' @export TBD
#'
#' @examples TBD
MinimizeTableIO <- function(aDataFrame = NULL){

  if (is.null(aDataFrame)) {

    return(NULL);
  } else {
    ioRatioTableDF <- aDataFrame;
    ioRatioTableDF$ObjectSchema <- NULL;
    ioRatioTableDF$TotalReads <- NULL;
    ioRatioTableDF$TotalWrites <- NULL;
    ioRatioTableDF <- melt(ioRatioTableDF, if.var = ObjectName);

    return(tibble::as_data_frame(ioRatioTableDF));
  }
}
#' Title  TableFootprintAboveMeans
#'
#' @param tableFootprintDataFrame
#'
#' @return data.frame
#' @export TBD
#'
#' @examples TBD
TableFootprintAboveMeans <- function(tableFootprintDataFrame = NULL){

  if (is.null(tableFootprintDataFrame)) {

    return(NULL);
  } else {
    tableWords <- NULL;
    columnNames <- colnames(tableFootprintDataFrame)[-1];
    meanRecordCount <- mean(tableFootprintDataFrame$RecordCount);
    tableWords <- c(tableWords,
                    as.vector(tableFootprintDataFrame[which(tableFootprintDataFrame$RecordCount >= meanRecordCount),1]));
    meanTotalPages <- mean(tableFootprintDataFrame$TotalPages);
    tableWords <- c(tableWords,
                    as.vector(tableFootprintDataFrame[which(tableFootprintDataFrame$TotalPages >= meanTotalPages),1]));
    meanUsedPages <- mean(tableFootprintDataFrame$UsedPages);
    tableWords <- c(tableWords,
                    as.vector(tableFootprintDataFrame[which(tableFootprintDataFrame$UsedPages >= meanUsedPages),1]));
    meanDataPages <- mean(tableFootprintDataFrame$DataPages);
    tableWords <- c(tableWords,
                    as.vector(tableFootprintDataFrame[which(tableFootprintDataFrame$DataPages >= meanDataPages),1]));
    meanTotalSpaceMB <- mean(tableFootprintDataFrame$TotalSpaceMB);
    tableWords <- c(tableWords,
                    as.vector(tableFootprintDataFrame[which(tableFootprintDataFrame$TotalSpaceMB >= meanTotalSpaceMB),1]));
    meanUsedSpaceMB <- mean(tableFootprintDataFrame$UsedSpaceMB);
    tableWords <- c(tableWords,
                    as.vector(tableFootprintDataFrame[which(tableFootprintDataFrame$UsedSpaceMB >= meanUsedSpaceMB),1]));
    meanDataSpaceMB <- mean(tableFootprintDataFrame$DataSpaceMB);
    tableWords <- c(tableWords,
                    as.vector(tableFootprintDataFrame[which(tableFootprintDataFrame$DataSpaceMB >= meanDataSpaceMB),1]));
    names(tableWords) <- colnames(tableFootprintDataFrame)[-1];
    #tableWords <- as.data.frame(tableWords);
    return(tableWords);
    #return(tibble::as_data_frame(tableWords));
  }
}
#' Title  ConstraintToTableNameFrequency
#'
#' @param aDataFrame
#'
#' @return tibble
#' @export TBD
#'
#' @examples TBD
ConstraintToTableNameFrequency <- function(aDataFrame = NULL) {
  aDF <- data.frame(NULL);

  if (!is.null(aDataFrame)) {
    aDF <- tibble::as_data_frame(sort(table(aDataFrame$TableName), decreasing = TRUE));
    colnames(aDF) <- c("TableName", "ConstraintCount");
  }

  return(aDF);
}
#
#
#

