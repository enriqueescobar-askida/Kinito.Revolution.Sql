### import
library(xlsx);
require(tibble);
###
### functions
###
#' Title  XlsToDataFrameSingleRow
#'
#' @param xlsFile 
#'
#' @return tibble
#' @export TBD
#'
#' @examples TBD
XlsToDataFrameSingleRow <- function(xlsFile = ""){
  aDF <- NULL;
  
  if (!is.null(xlsFile)) {
    aDF <- xlsx::read.xlsx2(xlsFile,
                            sheetIndex = 1,
                            as.data.frame = TRUE,
                            header = TRUE);
    aDF <- head(aDF, 1);
    aDF <- tibble::as_data_frame(aDF);
  }
  
  return(aDF);
}
#' Title  XlsToDataFrame
#'
#' @param xlsFile 
#'
#' @return tibble
#' @export TBD
#'
#' @examples TBD
XlsToDataFrame <- function(xlsFile = ""){
  aDF <- NULL;
  
  if (!is.null(xlsFile)) {
    aDF <- xlsx::read.xlsx2(xlsFile,
                            sheetIndex = 1,
                            as.data.frame = TRUE,
                            header = TRUE);
    aDF <- tibble::as_data_frame(aDF);
  }
  
  return(aDF);
}
#' Title  TraceXmlXlsToTibble
#'
#' @param filePath 
#'
#' @return tibble
#' @export TBD
#'
#' @examples TBD
TraceXmlXlsToTibble <- function(filePath = "") {
  
  if (is.null(filePath)) {
    
    return(NULL);
  } else {
    if (is.list(filePath)) {
      filePath <- unlist(filePath);
    }
    xlsFile <- xlsx::read.xlsx2(filePath,
                                sheetIndex = 1,
                                as.data.frame = TRUE,
                                header = FALSE);
    
    return(tibble::as_data_frame(xlsFile[-2]));
  }
}
#' Title  ScreenXmlXlsFiles
#'
#' @param fileList 
#'
#' @return tibble
#' @export TBD
#'
#' @examples TBD
ScreenXmlXlsFiles <- function(fileList = list()){
  
  if (is.null(fileList)) {
    
    return(NULL);
  } else {
    singleDataFrame <- NULL;
    
    if (length(fileList) < 2) {
      oneFile <- unlist(fileList[[1]]);
      singleDataFrame <- TraceXmlXlsToTibble(oneFile);
    } else {
      
      for (singleFile in fileList) {
        print(unlist(singleFile));
        aDf <- TraceXmlXlsToTibble(singleFile);
        singleDataFrame <- rbind(singleDataFrame, aDf);
      }
    }
    singleDataFrame <- data.frame(lapply(singleDataFrame, as.character), stringsAsFactors = FALSE);
    colnames(singleDataFrame) <- c("SqlTrace");
    
    return(tibble::as_data_frame(singleDataFrame));
  }
}

