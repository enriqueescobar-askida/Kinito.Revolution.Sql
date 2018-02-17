options(scipen = 100);
#options(digits = 3);
#' Title  ColumnDataFrameToFrequencyTable
#'
#' @param aDataFrame 
#' @param columnName 
#'
#' @return table
#' @export TBD
#'
#' @examples TBD
ColumnDataFrameToFrequencyTable <- function(aDataFrame = NULL, columnName = NULL) {
  tableFrequency <- NULL;
  
  if (!is.null(aDataFrame) & !is.null(columnName)) {
    tableFrequency <- table(aDataFrame[columnName]);
  }
  
  return(tableFrequency);
}
#' Title  IsConvertibleToDate
#'
#' @param anObject 
#'
#' @return logical
#' @export TBD
#'
#' @examples TBD
IsConvertibleToDate <- function(anObject = "") {
  if (is.null(anObject) || is.na(anObject) || is.nan(anObject)) {
  
      return(FALSE);
  } else {
    d <- try( as.Date( as.POSIXct(anObject), #as.character(anObject)
                       format = "%d-%m-%Y %H:%M:%S" ) );
    
    if ( class(d) == "try-error" || is.na(d) ) {
      
      return(FALSE);
    } else {
      
      return(TRUE);
    }
  }
}
#' Title  IsEvenInteger
#'
#' @param aInt 
#'
#' @return logical
#' @export TBD
#'
#' @examples TBD
IsEvenInteger <- function(aInt = 0) {
  boo <- FALSE;
  
  if (is.integer(aInt)) {
    boo <- (aInt %% 2) == 0;
  } else {
    boo <- FALSE;
  }
  
  return(boo);
}
#' Title  XlsFileToPng
#'
#' @param xlsFilePath 
#' @param dbName 
#' @param chartName 
#'
#' @return character
#' @export TBD
#'
#' @examples TBD
XlsFileToPng <- function(xlsFilePath = "", dbName = "", chartName = ""){
  # extension time
  # timeNow <- format(Sys.time(), "-%Y-%m-%d_%Hh%M");
  # timeExt <- paste0(timeNow, chartName, ".png");
  timeExt <- paste0(chartName, ".png");
  # png
  filePath <- gsub(".xls", timeExt, xlsFilePath);
  #filePath <- gsub("SQL/", paste0("../../ODBC/", dbName, "-", Sys.getenv("ASKIDA_ENV"), "-"), filePath);
  
  return(filePath);
}
#' Title  TraceXmlXlsToCsv
#'
#' @param aTibble 
#' @param filePath 
#'
#' @return logical
#' @export TBD
#'
#' @examples TBD
TraceXmlXlsToCsv <- function(aTibble = data.frame(NULL), filePath = ""){
  
  if (is.null(aTibble)) {
    
    return(FALSE);
  } else {
    aTibble <- aTibble[!grepl("^2016", aTibble$SqlTrace), ];
    aTibble <- aTibble[!grepl("-- network protocol", aTibble$SqlTrace), ];
    aTibble <- aTibble[!grepl("SET TRANSACTION ISOLATION LEVEL READ", aTibble$SqlTrace), ];
    aTibble <- aTibble[!grepl("SET NOCOUNT ON", aTibble$SqlTrace), ];
    aTibble <- aTibble[!grepl("exec sp_cursorfetch ", aTibble$SqlTrace), ];
    aTibble <- aTibble[!grepl("exec sp_cursorclose ", aTibble$SqlTrace), ];
    aTibble <- aTibble[!grepl("exec sp_reset_connection", aTibble$SqlTrace), ];
    aTibble <- aTibble[!grepl("exec sp_cursoroption ", aTibble$SqlTrace), ];
    aTibble <- aTibble[!grepl("exec sp_cursor ", aTibble$SqlTrace), ];
    aTibble <- aTibble[!grepl("set implicit_transactions on", aTibble$SqlTrace), ];
    aTibble <- aTibble[!grepl("set implicit_transactions off", aTibble$SqlTrace), ];
    write.csv(aTibble, file = "filePath");
    
    return(TRUE);
  }
}
#
library(data.table);
# import tibble
myLibrary <- "Lib/tibble.Util.R";
write(paste0(c("Load Util........\t", myLibrary), sep = "", collapse = ""), stdout());
source(myLibrary);
### ggplot2
myLibrary <- "Lib/ggplot2.Util.R";
write(paste0(c("Load Util........\t", myLibrary), sep = "", collapse = ""), stdout());
source(myLibrary);
### import wordcloud
myLibrary <- "Lib/wordcloud.Util.R";
write(paste0(c("Load Util........\t", myLibrary), sep = "", collapse = ""), stdout());
source(myLibrary);
### import xlsx
myLibrary <- "Lib/xlsx.Util.R";
write(paste0(c("Load Util........\t", myLibrary), sep = "", collapse = ""), stdout());
source(myLibrary);
### rm
rm(myLibrary);
