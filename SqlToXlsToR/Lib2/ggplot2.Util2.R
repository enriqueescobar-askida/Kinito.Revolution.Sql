# import
library(ggplot2);
library(gridExtra);
###
### functions
###
#' Title  GgplotToPng
#'
#' @param pngFilePath
#'
#' @export TBD
#'
#' @examples TBD
GgplotToPng <- function(pngFilePath = "", barplot = NULL) {
  
  if (is.na(barplot)) {
    
    return(FALSE);
  } else {
    write(paste0("Saving to path : ", pngFilePath), stdout());
    ggsave(filename = pngFilePath, plot = barplot, dpi = 100);
    
    return(TRUE);
  }
}
#' Title  TwoColumnDataFrameToHistogram
#'
#' @param aDataFrame 
#' @param mainTitle 
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
TwoColumnDataFrameToHistogram <- function(aDataFrame = NULL, mainTitle = "") {
  aHist <- NULL;
  
  if (is.null(aDataFrame)) {
    
    return(aHist);
  } else {
    # titles
    xTitle <- names(aDataFrame)[1];
    yTitle <- names(aDataFrame)[2];
    colnames(aDataFrame) <- NULL;
    names(aDataFrame)[1] <- "X";
    names(aDataFrame)[2] <- "Y";
    # graph
    aHist <- ggplot(aDataFrame, aes(Y)) +
      geom_histogram(colour = "grey60", fill = "lightblue", binwidth = 1, alpha = 0.5, position = "identity") +
      xlab(xTitle) +
      ylab(yTitle) +
      ggtitle(mainTitle) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5));
    
    return(aHist);
  }
}
#' Title  TwoColumnDataFrameToBarlot
#'
#' @param aDataFrame 
#' @param mainTitle 
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
TwoColumnDataFrameToBarlot <- function(aDataFrame = NULL, mainTitle = "") {
  
  if (is.null(aDataFrame)) {
    
    return(NULL);
  } else {
    aDataFrame <- head(aDataFrame, 50);
    # titles
    xTitle <- colnames(aDataFrame)[1];
    yTitle <- colnames(aDataFrame)[2];
    colnames(aDataFrame) <- NULL;
    names(aDataFrame)[1] <- "X";
    names(aDataFrame)[2] <- "Y";
    # graph
    barplot <- ggplot(aDataFrame,
                      aes(x = factor(X), y = Y)) +
      geom_bar(stat = "identity", width = 0.8, position = "dodge", fill = "lightblue") +
      xlab(xTitle) +
      ylab(yTitle) +
      ggtitle(mainTitle) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5));
    
    return(barplot);
  }
}
#' Title  GenericPiechartFromTwoColumnDataFrame
#'
#' @param aDataFrame 
#' @param mainTitle 
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
GenericPiechartFromTwoColumnDataFrame <- function(aDataFrame = NULL, mainTitle = NULL) {
  aPierchart <- NULL;
  
  if (!is.null(aDataFrame) & (ncol(aDataFrame) == 2)) {
    # titles
    xTitle <- colnames(aDataFrame)[1];
    names(aDataFrame)[1] <- "X";
    yTitle <- colnames(aDataFrame)[2];
    names(aDataFrame)[2] <- "Y";
    mainTitle <- paste0(mainTitle, " PieChart");
    # lists
    PercentList <- round(aDataFrame$Y / sum(aDataFrame$Y) * 100, digits = 1);
    labelList <- paste0(aDataFrame$X, " ", PercentList, "%");
    ColorList <- heat.colors(length(PercentList));
    # graph
    aPierchart <- ggplot(aDataFrame,
                         aes(x = factor(1), y = PercentList, fill = labelList)) +
      # make stacked bar chart with black border
      geom_bar(stat = "identity", color = "grey80", width = 1) +
      #geom_text(aes(x = 1.5, y = PercentList, label = labelList), size = 4) +
      ggtitle(mainTitle) +
      xlab(xTitle) +
      ylab(yTitle) +
      coord_polar(theta = "y");
  }
  
  return(aPierchart);
}
#' Title  DataFrameColumnToBarplot
#'
#' @param aDataFrame 
#' @param columnName 
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
DataFrameColumnToBarplot <- function(aDataFrame = NULL, columnName = NULL) {
  aBarplot <- NULL;
  
  if (!is.null(aDataFrame) & !is.null(columnName)) {
    aTable <- ColumnDataFrameToFrequencyTable(aDataFrame, columnName);
    aTibble <- FrequencyTableToTibble(aTable, aTitle = columnName);
    # titles
    xTitle <- colnames(aTibble)[1];
    yTitle <- colnames(aTibble)[2];
    mainTitle <- paste0(columnName, " Barplot");
    colnames(aTibble) <- NULL;
    names(aTibble)[1] <- "X";
    names(aTibble)[2] <- "Y";
    # calculations
    PercentList <- round(aTibble$Y / sum(aTibble$Y) * 100);
    TypeList <- paste0(aTibble$X," ",PercentList, "%");
    ColorList <- heat.colors(length(TypeList));
    # graph
    aBarplot <- ggplot(aTibble,
                       aes(x = "", y = Y, fill = TypeList)) +
      labs(fill = xTitle) +
      geom_bar(width = 1, stat = "identity") +
      ggtitle(mainTitle) +
      xlab(xTitle) +
      ylab(yTitle);
  }
  
  return(aBarplot);
}
#' Title  DataFrameColumnToPiechart
#'
#' @param aDataFrame 
#' @param columnName 
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
DataFrameColumnToPiechart <- function(aDataFrame = NULL, columnName = NULL) {
  aPiechart <- NULL;
  
  if (!is.null(aDataFrame) & !is.null(columnName)) {
    aTable <- ColumnDataFrameToFrequencyTable(aDataFrame, columnName);
    aTibble <- FrequencyTableToTibble(aTable, aTitle = columnName);
    # titles
    xTitle <- colnames(aTibble)[1];
    yTitle <- colnames(aTibble)[2];
    mainTitle <- paste0(columnName, " Piechart");
    colnames(aTibble) <- NULL;
    names(aTibble)[1] <- "X";
    names(aTibble)[2] <- "Y";
    # calculations
    PercentList <- round(aTibble$Y / sum(aTibble$Y) * 100);
    TypeList <- paste0(aTibble$X," ",PercentList, "%");
    ColorList <- heat.colors(length(TypeList));
    # graph
    aPiechart <- ggplot(aTibble,
                        aes(x = factor(1), y = PercentList, fill = TypeList)) +
      # make stacked bar chart with black border
      geom_bar(stat = "identity", color = "grey80", width = 1) +
      # add the percents to the interior of the chart
      #geom_text(aes(x = 1.5, y = PercentList, label = FunctionTypes), size = 4) +
      ggtitle(mainTitle) +
      xlab(xTitle) +
      ylab(yTitle) +
      coord_polar(theta = "y");
  }
  
  return(aPiechart);
}
#' Title  DBRowCountFrameToBarplot
#'
#' @param usageDataFrame 
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
DBRowCountFrameToBarplot <- function(usageDataFrame = NULL) {
  
  if (is.null(usageDataFrame)) {
    
    return(NULL);
  }else{
    # titles
    xTitle <- colnames(usageDataFrame)[1];
    yTitle <- colnames(rev(usageDataFrame)[1]);
    mainTitle <- "Row List count";
    # graph
    barplot <- ggplot(usageDataFrame, aes(x = factor(TableRows), y = RowRepeats)) +
      ##barplot <- ggplot(usageDataFrame, aes(x = factor(TableRows), y = sqrt(RowRepeats))) +
      geom_bar(stat = "identity", width = 0.8, position = "dodge", fill = "lightblue") +
      ##scale_y_sqrt(paste0("Square root of ", yTitle)) +
      ggtitle(mainTitle) +
      xlab(xTitle) +
      ylab(yTitle) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5));
    
    return(barplot);
  }
}
#' Title  DBUsageDataFrameToBarplot
#'
#' @param usageDataFrame
#' @param pngFilePath
#'
#' @return ggplot
#' @export TBD
#'
#' @examples TBD
DBUsageDataFrameToBarplot <- function(usageDataFrame = NULL) {
  
  if (is.null(usageDataFrame)) {
    
    return(NULL);
  } else {
    # titles
    xTitle <- colnames(usageDataFrame)[2];
    yTitle <- colnames(rev(usageDataFrame)[1]);
    mainTitle <- "Usage List count";
    # graph
    barplot <- ggplot(usageDataFrame,
                      aes(x = factor(DBName), y = DBBufferMB)) +
      geom_bar(stat = "identity", width = 0.8, position = "dodge", fill = "lightblue") +
      xlab(xTitle) +
      ylab(yTitle) +
      ggtitle(mainTitle) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5));
    
    return(barplot);
  }
}
#' Title  DBUsageDataFrameToPiechart
#'
#' @param usageDataFrame
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
DBUsageDataFrameToPiechart <- function(usageDataFrame = NULL) {
  
  if (is.null(usageDataFrame)) {
    
    return(NULL);
  }else{
    PercentList <- round(usageDataFrame$DBBufferMB / sum(usageDataFrame$DBBufferMB) * 100, digits = 1);
    labelList <- paste0(usageDataFrame$DBName," ",PercentList, "%");
    ColorList <- heat.colors(length(PercentList));
    # titles
    xTitle <- colnames(usageDataFrame)[2];
    yTitle <- colnames(rev(usageDataFrame)[1]);
    mainTitle <- "Usage List Piechart";
    # graph
    piePlot <- ggplot(usageDataFrame, aes(x = factor(1), y = PercentList, fill = labelList)) +
      # make stacked bar chart with black border
      geom_bar(stat = "identity", color = "grey80", width = 1) +
      # add the percents to the interior of the chart
      #geom_text(aes(x = 1.5, y = PercentList, label = labelList), size = 4) +
      ggtitle(mainTitle) +
      xlab(xTitle) +
      ylab(yTitle) +
      coord_polar(theta = "y");
    
    return(piePlot);
  }
}
#' Title  DBObjectDataFrameToBarplot
#'
#' @param objectDataFrame
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples  TBD
DBObjectDataFrameToBarplot <- function(objectDataFrame = NULL) {
  
  if (is.null(objectDataFrame)) {
    write("+ ERROR : Empty data.frame", stderr());
    
    return(NULL);
  }else{
    # titles
    xTitle <- colnames(objectDataFrame)[1];
    yTitle <- colnames(objectDataFrame)[-1];
    mainTitle <- "ObjectList count";
    # graph
    barplot <- ggplot(objectDataFrame,
                      aes(x = factor(ObjectName), y = ObjectCount)) +
      geom_bar(stat = "identity", width = 0.8, position = "dodge", fill = "lightblue") +
      ggtitle(mainTitle) +
      xlab(xTitle) +
      ylab(yTitle);
    
    return(barplot);
  }
}
#' Title  DBFunctionDataFrameToDensityplot
#'
#' @param functionDataFrame
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
DBFunctionDataFrameToDensityplot <- function(functionDataFrame = NULL) {
  
  if (is.null(functionDataFrame)) {
    
    return(NULL);
  }else{
    # titles
    xTitle <- "Number of parameters";
    mainTitle <- "Densityplot for parameter distribution";
    # graph
    aDensityplot <- ggplot(functionDataFrame,
                           aes(NbParameters, fill = FunctionType)) +
      geom_density(alpha = 0.6) +
      labs(title = mainTitle, x = xTitle);
    
    return(aDensityplot);
  }
}
#' Title  DBFunctionDataFrameToBoxplot
#'
#' @param functionDataFrame
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
DBFunctionDataFrameToBoxplot <- function(functionDataFrame = NULL) {
  
  if (is.null(functionDataFrame)) {
    
    return(NULL);
  }else{
    # titles
    xTitle <- "Function type";
    yTitle <- "Number of parameters";
    mainTitle <- "Boxplot for parameter distribution";
    # graph
    aBoxplot <- ggplot(functionDataFrame,
                       aes(x = FunctionType, y = NbParameters)) +
      geom_boxplot(aes(fill = FunctionType)) +
      geom_jitter() +
      # + geom_point(aes(colour = factor(type_desc)), size=4)
      scale_y_continuous(breaks = seq(0, 12, 1.0)) +
      labs(title = mainTitle, x = xTitle, y = yTitle);
    
    return(aBoxplot);
  }
}
#' Title DBFunctionDataFrameToBarplot
#'
#' @param functionDataFrame
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
DBFunctionDataFrameToBarplot <- function(functionDataFrame = NULL) {
  
  if (is.null(functionDataFrame)) {
    
    return(NULL);
  }else{
    PercentList <- round(functionDataFrame$FunctionCount / sum(functionDataFrame$FunctionCount) * 100);
    FunctionTypeList <- paste0(functionDataFrame$FunctionTypes," ",PercentList, "%");
    # titles
    xTitle <- colnames(functionDataFrame)[1];
    yTitle <- colnames(functionDataFrame)[-1];
    mainTitle <- "Function Type List Barplot";
    # graph
    aBarplot <- ggplot(functionDataFrame,
                       aes(x = "", y = FunctionCount, fill = FunctionTypeList)) +
      labs(fill = xTitle) +
      geom_bar(width = 1, stat = "identity") +
      ggtitle(mainTitle) +
      xlab(xTitle) +
      ylab(yTitle);
    
    return(aBarplot);
  }
}
#' Title  DBFunctionDataFrameToPiechart
#'
#' @param functionDataFrame
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
DBFunctionDataFrameToPiechart <- function(functionDataFrame = NULL) {
  
  if (is.null(functionDataFrame)) {
    
    return(NULL);
  }else{
    PercentList <- round(functionDataFrame$FunctionCount / sum(functionDataFrame$FunctionCount) * 100);
    FunctionTypeList <- paste0(functionDataFrame$FunctionTypes," ",PercentList, "%");
    ColorList <- heat.colors(length(PercentList));
    # titles
    xTitle <- colnames(functionDataFrame)[1];
    yTitle <- colnames(functionDataFrame)[-1];
    mainTitle <- "Function Type List Piechart";
    # graph
    piePlot <- ggplot(functionDataFrame,
                      aes(x = factor(1), y = PercentList, fill = FunctionTypeList)) +
      # make stacked bar chart with black border
      geom_bar(stat = "identity", color = "grey80", width = 1) +
      # add the percents to the interior of the chart
      #geom_text(aes(x = 1.5, y = PercentList, label = FunctionTypes), size = 4) +
      ggtitle(mainTitle) +
      xlab(xTitle) +
      ylab(yTitle) +
      coord_polar(theta = "y");
    
    return(piePlot);
  }
}
#' Title  FunctionWithoutWithTotalDFToPiechart
#'
#' @param woWithTotalDataFrame 
#' @param OutputType 
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
FunctionWithoutWithTotalDFToPiechart <- function(woWithTotalDataFrame = NULL,
                                                 OutputType = "") {
  
  if (is.null(woWithTotalDataFrame)) {
    
    return(NULL);
  } else {
    # rm totals/ last column & save colnames
    woWithTotalDataFrame <- rev(woWithTotalDataFrame)[-1];
    myColNames <- colnames(woWithTotalDataFrame);
    # rm colname and transpose and rm new colname
    colnames(woWithTotalDataFrame) <- NULL;
    woWithTotalDataFrame <- t(woWithTotalDataFrame);
    colnames(woWithTotalDataFrame) <- NULL;
    # add columns and replace colname
    woWithTotalDataFrame <- cbind(myColNames, woWithTotalDataFrame);
    colnames(woWithTotalDataFrame) <- NULL;
    colnames(woWithTotalDataFrame) <- c(paste0(OutputType, "Types"), paste0(OutputType, "Count"));
    # cast to data frame
    woWithTotalDataFrame <- tibble::as_data_frame(woWithTotalDataFrame);
    woWithTotalDataFrame[[2]] <- as.numeric(woWithTotalDataFrame[[2]]);
    # check colname
    #write(colnames(woWithTotalDataFrame), stdout());
    # titles
    xTitle <- colnames(woWithTotalDataFrame)[1];
    yTitle <- colnames(woWithTotalDataFrame)[2];
    mainTitle <- paste0(OutputType, " Type List Piechart");
    PercentList <- round(woWithTotalDataFrame[[2]] / sum(woWithTotalDataFrame[[2]]) * 100, digits = 1);
    labelList <- paste0(woWithTotalDataFrame[[1]], " ", PercentList, "%");
    ColorList <- heat.colors(length(PercentList));
    # graph
    piePlot <- ggplot(woWithTotalDataFrame,
                      aes(x = factor(1), y = PercentList, fill = labelList)) +
      # make stacked bar chart with black border
      geom_bar(stat = "identity", color = "grey80", width = 1) +
      # add the percents to the interior of the chart
      # geom_text(aes(x = 1.5, y = PercentList, label = labelList), size = 4) +
      ggtitle(mainTitle) +
      xlab(xTitle) +
      ylab(yTitle) +
      coord_polar(theta = "y");
    
    return(piePlot);
  }
}
#' Title  FunctionWithoutWithTotalDFToBarplot
#'
#' @param woWithTotalDataFrame
#' @param OutputType
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
FunctionWithoutWithTotalDFToBarplot <- function(woWithTotalDataFrame = NULL,
                                                OutputType = "") {
  
  if (is.null(woWithTotalDataFrame)) {
    
    return(NULL);
  }else{
    # rm totals/ last column & save colnames
    woWithTotalDataFrame <- rev(woWithTotalDataFrame)[-1];
    myColNames <- colnames(woWithTotalDataFrame);
    # rm colname and transpose and rm new colname
    colnames(woWithTotalDataFrame) <- NULL;
    woWithTotalDataFrame <- t(woWithTotalDataFrame);
    colnames(woWithTotalDataFrame) <- NULL;
    # add columns and replace colname
    woWithTotalDataFrame <- cbind(myColNames, woWithTotalDataFrame);
    colnames(woWithTotalDataFrame) <- NULL;
    colnames(woWithTotalDataFrame) <- c(paste0(OutputType, "Types"), paste0(OutputType, "Count"));
    # cast to data frame
    woWithTotalDataFrame <- as.data.frame(woWithTotalDataFrame);
    # check colname
    #write(colnames(woWithTotalDataFrame), stdout());
    # titles
    xTitle <- colnames(woWithTotalDataFrame)[1];
    yTitle <- colnames(woWithTotalDataFrame)[-1];
    mainTitle <- paste0(OutputType, " Type List Barplot");
    # graph
    aBarplot <- ggplot(woWithTotalDataFrame,
                       aes(x = "", y = FnCount, fill = FnTypes)) +
      labs(fill = xTitle) +
      geom_bar(width = 1, stat = "identity") +
      ggtitle(mainTitle) +
      xlab(xTitle) +
      ylab(yTitle);
    
    return(aBarplot);
  }
}
#' Title  DBStoreProcDataFrameToBoxplot
#'
#' @param storeProcDataFrame 
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
DBStoreProcDataFrameToBoxplot <- function(storeProcDataFrame = NULL) {
  if (is.null(storeProcDataFrame)) {
    
    return(NULL);
  }else{
    # titles
    xTitle <- "Procedure type";
    yTitle <- "Number of parameters";
    mainTitle <- "Boxplot for parameter distribution";
    # graph
    aBoxplot <- ggplot(storeProcDataFrame,
                       aes(x = ProcedureType, y = NbParameters)) +
      geom_boxplot(aes(fill = ProcedureType)) +
      geom_jitter() +
      # + geom_point(aes(colour = factor(type_desc)), size=4)
      scale_y_continuous(breaks = seq(0, 12, 1.0)) +
      labs(title = mainTitle, x = xTitle, y = yTitle);
    
    return(aBoxplot);
  }
}

#' Title  DBStoreProcDataFrameToDensityplot
#'
#' @param storeProcDataFrame
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
DBStoreProcDataFrameToDensityplot <- function(storeProcDataFrame = NULL) {
  
  if (is.null(storeProcDataFrame)) {
    
    return(NULL);
  }else{
    # titles
    xTitle <- "Number of parameters";
    mainTitle <- "Densityplot for parameter distribution";
    # graph
    aDensityplot <- ggplot(storeProcDataFrame,
                           aes(NbParameters, fill = ProcedureType)) +
      geom_density(alpha = 0.6) +
      labs(title = mainTitle, x = xTitle);
    
    return(aDensityplot);
  }
}
#' Title  StoredProcWithoutWithTotalDFToBarplot
#'
#' @param woWithTotalDataFrame
#' @param OutputType
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
StoredProcWithoutWithTotalDFToBarplot <- function(woWithTotalDataFrame = NULL,
                                                  OutputType = "") {
  if (is.null(woWithTotalDataFrame)) {
    
    return(NULL);
  }else{
    # rm totals/ last column & save colnames
    woWithTotalDataFrame <- rev(woWithTotalDataFrame)[-1];
    myColNames <- colnames(woWithTotalDataFrame);
    # rm colname and transpose and rm new colname
    colnames(woWithTotalDataFrame) <- NULL;
    woWithTotalDataFrame <- t(woWithTotalDataFrame);
    colnames(woWithTotalDataFrame) <- NULL;
    # add columns and replace colname
    woWithTotalDataFrame <- cbind(myColNames, woWithTotalDataFrame);
    colnames(woWithTotalDataFrame) <- NULL;
    colnames(woWithTotalDataFrame) <- c(paste0(OutputType, "Types"), paste0(OutputType, "Count"));
    # cast to data frame
    woWithTotalDataFrame <- tibble::as_data_frame(as.data.frame(woWithTotalDataFrame));
    woWithTotalDataFrame;
    # check colname
    #write(paste0("Column name: ", colnames(woWithTotalDataFrame)), stdout());
    # titles
    xTitle <- colnames(woWithTotalDataFrame)[1];
    yTitle <- colnames(woWithTotalDataFrame)[-1];
    mainTitle <- paste0(OutputType, " Type List Barplot");
    # graph
    aBarplot <- ggplot(woWithTotalDataFrame,
                       aes(x = "", y = StoredProcCount, fill = StoredProcTypes)) +
      labs(fill = xTitle) +
      geom_bar(width = 1, stat = "identity") +
      ggtitle(mainTitle) +
      xlab(xTitle) +
      ylab(yTitle);
    
    return(aBarplot);
  }
}
#' Title  StoredProcWithoutWithTotalDFToPiechart
#'
#' @param woWithTotalDataFrame
#' @param OutputType
#'
#' @return ggplot2
#' @export TBD
#'
#' @examples TBD
StoredProcWithoutWithTotalDFToPiechart <- function(woWithTotalDataFrame = NULL,
                                                   OutputType = "") {
  if (is.null(woWithTotalDataFrame)) {
    
    return(NULL);
  } else {
    # rm totals/ last column & save colnames
    woWithTotalDataFrame <- rev(woWithTotalDataFrame)[-1];
    myColNames <- colnames(woWithTotalDataFrame);
    # rm colname and transpose and rm new colname
    colnames(woWithTotalDataFrame) <- NULL;
    woWithTotalDataFrame <- t(woWithTotalDataFrame);
    colnames(woWithTotalDataFrame) <- NULL;
    # add columns and replace colname
    woWithTotalDataFrame <- cbind(myColNames, woWithTotalDataFrame);
    colnames(woWithTotalDataFrame) <- NULL;
    colnames(woWithTotalDataFrame) <- c(paste0(OutputType, "Types"), paste0(OutputType, "Count"));
    # cast to data frame
    woWithTotalDataFrame <- tibble::as_data_frame(as.data.frame(woWithTotalDataFrame));
    woWithTotalDataFrame[[2]] <- as.numeric(as.character(woWithTotalDataFrame[[2]]));
    #
    #write(paste0("Column name: ", colnames(woWithTotalDataFrame)), stdout());
    PercentList <- round(woWithTotalDataFrame[[2]] / sum(woWithTotalDataFrame[[2]]) * 100, digits = 1);
    labelList <- paste0(woWithTotalDataFrame[[1]], " ", PercentList, "%");
    ColorList <- heat.colors(length(PercentList));
    # titles
    xTitle <- colnames(woWithTotalDataFrame)[2];
    yTitle <- colnames(rev(woWithTotalDataFrame)[1]);
    mainTitle <- paste0(OutputType, " List Piechart");
    # graph
    piePlot <- ggplot(woWithTotalDataFrame, aes(x = factor(1), y = PercentList, fill = labelList)) +
      # make stacked bar chart with black border
      geom_bar(stat = "identity", color = "grey80", width = 1) +
      # add the percents to the interior of the chart
      # geom_text(aes(x = 1.5, y = PercentList, label = labelList), size = 4) +
      ggtitle(mainTitle) +
      xlab(xTitle) +
      ylab(yTitle) +
      coord_polar(theta = "y");
    
    return(piePlot);
  }
}

