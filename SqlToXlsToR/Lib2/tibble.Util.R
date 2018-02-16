# import
library(tibble);
###
### functions
###
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
#' Title  FrequencyTableToTibble
#'
#' @param aTable 
#' @param aTitle 
#'
#' @return tibble
#' @export TBD
#'
#' @examples TBD
FrequencyTableToTibble <- function(aTable = NULL, aTitle = NULL) {
  aDataFrame <- NULL
  
  if (!is.null(aTable) & is.table(aTable)) {
    aDataFrame <- tibble::as_data_frame(aTable);
  }
  if (!is.null(aTitle)) {
    names(aDataFrame)[1] <- paste0(aTitle, " List");
    names(aDataFrame)[2] <- paste0(aTitle, " Count");
  } else {
    colnames(aDataFrame) <- paste0(colnames(aDataFrame), " List");
  }
  print(aDataFrame);
  
  return(aDataFrame)
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
  indexList <- which(colnames(aDataFrame) %in% columnList);
  
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
#' Title  ObjectListGroupFunctionsDataFrame
#'
#' @param objectDataFrame
#' @param functionFilter
#'
#' @return data.frame
#' @export TBD
#'
#' @examples TBD
ObjectListGroupFunctionsDataFrame <- function(objectDataFrame, functionFilter="Function"){
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
#' Title  TrimXmlXlsToTibble
#'
#' @param aTibble 
#'
#' @return data.frame
#' @export TBD
#'
#' @examples TBD
TrimXmlXlsToTibble <- function(aTibble = NULL) {
  nbLines <- nrow(aTibble);
  aDataFr <- data.frame(NULL);
  count <- 0;
  
  for (aLine in seq(nbLines))
  {
    if (IsConvertibleToDate(aTibble[[aLine,]])) {
    } else {
      count <- count + 1;
      aString <- as.character(aTibble[[aLine,]]);
      print(aString);
      aDataFr <- rbind(aDataFr, aString);
    }
  }
  colnames(aDataFr) <- c("SqlTrace");
  aDataFr <- data.frame(lapply(aDataFr, as.character), stringsAsFactors = FALSE);
  print(count);
  
  return(tibble::as_data_frame(aDataFr));
}
