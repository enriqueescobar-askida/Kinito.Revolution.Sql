require("R6");
require("readr");
require("tibble");
require("stringr");
# class
SqlToCsvSqlServerInstanceDbTableList <- R6Class("SqlToCsvSqlServerInstanceDbTableList",
  inherit = SqlToCsvSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
    HasRowRepeats = FALSE,
    initialize = function(path, serviceInstance, instance, dbName, objectList) {
      instance <- paste0(instance, "_", dbName);
      private$objectTibble <- if(!is.null(objectList) && (length(objectList)!=0) && (ncol(objectList) > 0)) objectList else NULL;
      super$initialize(path, serviceInstance, instance);
    },
    fileToTibble = function() {
      super$fileToTibble();
      tibbleSize <- dim(private$Tibble)[1];
      isOk <- FALSE;
      
      for(num in private$objectTibble$ObjectCount) isOk <- isOk || (tibbleSize==num);
      
      if (!isOk) {
        private$Tibble <- NULL;
      } else {
        private$FileCount <- gsub("DbTableList.", "DbTableListCount.", private$File);
        private$FileKey <- gsub("DbTableList.", "DbTableKeyList.", private$File);
        private$FileFootprint <- gsub("DbTableList.", "DbTableFootprintList.", private$File);
      }
    },
    getBarplotGgplot2 = function(aTibble = NULL){
      barplot <- NULL;
      
      if (missing(aTibble)) aTibble <- private$TibbleCount;
      aTibble <- head(aTibble, 50);
      
      if (!is.null(aTibble) && (length(aTibble)!=0) && (ncol(aTibble) == 2)) {
        # titles
        xTitle <- colnames(aTibble)[1];
        yTitle <- colnames(aTibble)[-1];
        mainTitle <- paste0(private$Instance, " Table Count List Barplot");
        # graph
        barplot <- ggplot(aTibble,
                          aes(x = factor(TableName), y = TableCount)) +
          geom_bar(stat = "identity",
                   width = 0.8,
                   position = "dodge",
                   fill = "lightblue") +
          ggtitle(mainTitle) +
          xlab(xTitle) +
          ylab(yTitle) +
          theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5));
      }
      
      return(barplot);
    },
    getFileCount = function() private$FileCount,
    getTibbleCount = function() {
      isNull <- !file.exists(private$FileCount);
      isEmpty <- if(file.exists(private$FileCount)) (file.info(private$FileCount)$size == 0) else FALSE;
      isFileNullOrEmpty <- isNull || isEmpty;
      df <- NULL;
      
      if(!isFileNullOrEmpty){
        df <-
          read_csv(private$FileCount, col_names = c("TableName","TableCount"),
                   locale = locale(asciify = TRUE), na = c("NULL","NA","","NAN","NaN"));
        private$TibbleCount <- tibble::as_tibble(df);
        private$cleanTibbleCount();
      }
      rm(df);
      
      return(private$TibbleCount);
    },
    getTibbleRowRepeats = function(){
      df <- aggregate(
        list(RowRepeats = rep(1, nrow(private$TibbleCount[-1]))),
        private$TibbleCount[-1],
        length);
      aMean <- mean(df$RowRepeats);
      df <- subset(df, RowRepeats > aMean);
      colnames(df) <- c("TableRows","RowRepeats");
      self$HasRowRepeats <- dim(df)[1]!=0;
      
      if(self$HasRowRepeats){
        return(tibble::as_tibble(df));
      } else {
        return(NULL);
      }
      
    },
    getRowRepeatsHistogram = function(){
      t <- self$getTibbleRowRepeats();
      barplot <- NULL;
      
      if(!is.null(t)){
        # titles
        xTitle <- colnames(t)[1];
        yTitle <- colnames(rev(t)[1]);
        mainTitle <- paste0(private$Instance, " Table Row List count Histogram");
        # graph
        barplot <- ggplot(t, aes(x = factor(TableRows), y = RowRepeats)) +
          ##barplot <- ggplot(t, aes(x = factor(TableRows), y = sqrt(RowRepeats))) +
          geom_bar(stat = "identity", width = 0.8, position = "dodge", fill = "lightblue") +
          ##scale_y_sqrt(paste0("Square root of ", yTitle)) +
          ggtitle(mainTitle) +
          xlab(xTitle) +
          ylab(yTitle) +
          theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5));
      }
      
      return(barplot);
    },
    getFileKey = function() private$FileKey,
    getTibbleKey = function() {
      isNull <- !file.exists(private$FileKey);
      isEmpty <- if(file.exists(private$FileKey)) (file.info(private$FileKey)$size == 0) else FALSE;
      isFileNullOrEmpty <- isNull || isEmpty;
      df <- NULL;
      
      if(!isFileNullOrEmpty){
        df <-
          read_csv(private$FileKey, col_names = c("TableName","PKName","FKName","ColumnName"),
                   locale = locale(asciify = TRUE), na = c("NULL","NA","","NAN","NaN"));
        private$TibbleKey <- tibble::as_tibble(df);
      }
      rm(df);
      
      return(private$TibbleKey);
    },
    getFileFootprint = function() private$FileFootprint,
    getTibbleFootprint = function() {
      isNull <- !file.exists(private$FileFootprint);
      isEmpty <- if(file.exists(private$FileFootprint)) (file.info(private$FileFootprint)$size == 0) else FALSE;
      isFileNullOrEmpty <- isNull || isEmpty;
      df <- NULL;
      
      if(!isFileNullOrEmpty){
        df <-
          read_csv(private$FileFootprint, col_names = c("TableName","IndexName","RecordCount","TotalPages","UsedPages","DataPages","TotalSpaceMB","UsedSpaceMB","DataSpaceMB"),
                   locale = locale(asciify = TRUE), na = c("NULL","NA","","NAN","NaN"));
        private$TibbleFootprint <- tibble::as_tibble(df);
      }
      rm(df);
      
      return(private$TibbleFootprint);
    }
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_DbTableList");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c("TableName", "TableID", "TableType", "TableDesc", "TableCreated",
                                   "TableModified","MaxColumnIDUsed","IsUsingANSINulls","LOBDataSpaceID"));
    }
  ),
  private = list(
    objectTibble = NULL,
    FileCount = "",
    FileKey = "",
    FileFootprint = "",
    TibbleCount = NULL,
    TibbleKey = NULL,
    TibbleFootprint = NULL,
    cleanTibbleCount = function(){
      private$TibbleCount$TableName <- str_split_fixed(private$TibbleCount$TableName, "\\.", 2)[,2];
      private$TibbleCount$TableName <- gsub("]", "", private$TibbleCount$TableName);
      private$TibbleCount$TableName <- gsub("\\[", "", private$TibbleCount$TableName);
    }
  )
)
