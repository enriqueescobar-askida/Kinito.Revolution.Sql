
library(RODBC);

#' Title  SqlResultToDataFrame
#'
#' @param odbcConnector
#' @param sqlSelectCount
#'
#' @return data.frame
#' @export TBD
#'
#' @examples TBD
SqlResultToDataFrame <- function(odbcConnector = NULL, sqlSelectCount = "") {
  dataFrame <- sqlQuery(odbcConnector, sqlSelectCount);
  nbRows <- nrow(dataFrame);
  write(nbRows, stdout());
  #if(nbRows < 1){
  #  return(NULL);
  #}else{
  return(tibble::as_data_frame(dataFrame));
  #}
}

#' Title SqlCountResultToInteger
#'
#' @param odbcConnector
#' @param sqlSelectCount
#'
#' @return integer
#' @export TBD
#'
#' @examples TBD
SqlCountResultToInteger <- function(odbcConnector = NULL, sqlSelectCount = "") {
  dataFrame <- sqlQuery(odbcConnector, sqlSelectCount);
  anInteger <- dataFrame[[1]];
  write(anInteger, stdout());
  if(is.integer(anInteger)){
    return(anInteger);
  }else{
    return(-1);
  }
}

#' Title  SqlCountResultToString
#'
#' @param odbcConnector
#' @param sqlSelectString
#'
#' @return string
#' @export TBD
#'
#' @examples TBD
SqlCountResultToString <- function(odbcConnector = NULL, sqlSelectString = "") {
  dataFrame <- sqlQuery(odbcConnector, sqlSelectString);
  aString <- as.character(dataFrame[[1]]);
  write(aString, stdout());
  if(is.character(aString)){
    return(aString);
  }else{
    return("");
  }
}
