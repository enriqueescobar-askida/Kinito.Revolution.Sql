# import
library(tm);
library(wordcloud);
require(tibble);
###
### functions
###
#' Title
#'
#' @param dataFrameSortDesc
#' @param pngFilePath
#' @return logical
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
# import
require(ggplot2);
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
    aDataFrame <- data.frame(NULL);
    
    if (nrow(aSortedDataFrame) > 40) {
      aDataFrame <- head(aSortedDataFrame, 40);
    } else {
      aDataFrame <- aSortedDataFrame;
    }
    
    aBarplot <- barplot(aDataFrame$freq,
                        las = 2,
                        names.arg = aDataFrame$word,
                        col = "lightblue",
                        main = "Most frequent words",
                        ylab = "Word frequencies");
    
    return(aBarplot);
  }
}
#' Title  ScreenTxtFiles
#'
#' @param fileList
#' @export TBD
#'
#' @examples TBD
ScreenTxtFiles <- function(fileList = list()) {
  
  for (singleFile in fileList) {
    print(singleFile);
    singleText <- readLines(singleFile);
    corpusWords <- Corpus(VectorSource(singleText));
    # inspect(corpusWords);
    termDocMatrixSortDesc <- sort(rowSums(as.matrix(TermDocumentMatrix(corpusWords))),
                                  decreasing  = TRUE);
    termDocDataFrameSortDesc <- data.frame(word = names(termDocMatrixSortDesc),
                                           freq = termDocMatrixSortDesc);
    termDocDataFrameSortDesc <- tibble::as_data_frame(termDocDataFrameSortDesc);
    print(head(termDocDataFrameSortDesc));
    singleWordcloudPng <- gsub(".txt", ".wordcloud.png", singleFile);
    WordcloudToPng(termDocDataFrameSortDesc, singleWordcloudPng);
    # WorcloudToBarplot(termDocDataFrameSortDesc);
    singleWordcloudFreq <- gsub(".txt", ".freq.csv", singleFile);
    print(singleWordcloudFreq);
    write.csv2(termDocDataFrameSortDesc, file = singleWordcloudFreq, row.names = FALSE);
  }
}

