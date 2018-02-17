
library(tm);
library(wordcloud);

#' Title
#'
#' @param dataFrameSortDesc
#' @param pngFilePath
#' @export TBD
#'
#' @examples TBD
WordcloudToPng <- function(dataFrameSortDesc = NULL, pngFilePath = ""){

  if (is.null(dataFrameSortDesc)) {

    return(FALSE);
  } else {
    # graph
    png(filename = pngFilePath, width = 800, height = 800);
    wordcloud(words = dataFrameSortDesc$word,
              freq = dataFrameSortDesc$freq,
              min.freq = 1,
              max.words = 200,
              random.order = FALSE,
              rot.per = 0.35,
              colors = brewer.pal(8, "Dark2"));
    dev.off();

    return(TRUE);
  }
}

#' Title  WorcloudToBarplot
#'
#' @param aSortedDataFrame
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
WorcloudToBarplot <- function(aSortedDataFrame = NULL){

  if (is.null(aSortedDataFrame)) {

    return(NULL);
  } else {

    if (nrow(aSortedDataFrame) > 40) {
      aDataFrame <- head(aSortedDataFrame, 40);
    }
    aDataFrame <- aSortedDataFrame;
    aBarplot <- barplot(aDataFrame$freq,
                        las = 2,
                        names.arg = aDataFrame$word,
                        col = "lightblue",
                        main = "Most frequent words",
                        ylab = "Word frequencies");

    return(aBarplot);
  }
}
#
#
#
