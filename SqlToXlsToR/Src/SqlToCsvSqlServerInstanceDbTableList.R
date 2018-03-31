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
    HasFootprint = FALSE,
    HasIO = FALSE,
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
        private$FileIO <- gsub("DbTableList.", "DbTableIOList.", private$File);
        private$PngFootprint <- gsub(".csv", "_Worcloud.png", private$FileFootprint);
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
    getPrimaryKeyHistogram = function(){
      df <- NULL;
      
      if(!is.null(private$TibbleKey)){
        df <- cbind(private$TibbleKey$TableName, private$TibbleKey$PKName);
        colnames(df) <- c("TableName", "PKName");
        df <- tibble::as_tibble(df);
        df <- df[!is.na(df$PKName),];
        df <- aggregate(
          list(KeyRepeats = rep(1, nrow(df[-2]))),
          df[-2],
          length);
        if(!is.na(mean(df$KeyRepeats))){
          aMean <- mean(df$KeyRepeats);
          df <- subset(df, KeyRepeats > aMean);
          colnames(df) <- c("TableName","KeyRepeats");
        }
        df <- tibble::as_tibble(df);
      }
      
      barplot <- NULL;

      if(!is.null(df)){
        # titles
        xTitle <- colnames(df)[1];
        yTitle <- colnames(rev(df)[1]);
        mainTitle <- paste0(private$Instance, " Table Row List Primary Key Histogram");
        # graph
        barplot <- ggplot(df, aes(x = factor(TableName), y = KeyRepeats)) +
          ##barplot <- ggplot(t, aes(x = factor(TableRows), y = sqrt(KeyRepeats))) +
          geom_bar(stat = "identity", width = 0.8, position = "dodge", fill = "lightblue") +
          ##scale_y_sqrt(paste0("Square root of ", yTitle)) +
          ggtitle(mainTitle) +
          xlab(xTitle) +
          ylab(yTitle) +
          theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5));
      }

      return(barplot);
    },
    getForeignKeyHistogram = function(){
      df <- NULL;
      
      if(!is.null(private$TibbleKey)){
        df <- cbind(private$TibbleKey$TableName, private$TibbleKey$FKName);
        colnames(df) <- c("TableName", "FKName");
        df <- tibble::as_tibble(df);
        df <- df[!is.na(df$FKName),];
        df <- aggregate(
          list(KeyRepeats = rep(1, nrow(df[-2]))),
          df[-2],
          length);
        if(!is.na(mean(df$KeyRepeats))){
          aMean <- mean(df$KeyRepeats);
          df <- subset(df, KeyRepeats > aMean);
          colnames(df) <- c("TableName","KeyRepeats");
        }
        df <- tibble::as_tibble(df);
      }
      
      barplot <- NULL;
      
      if(!is.null(df)){
        # titles
        xTitle <- colnames(df)[1];
        yTitle <- colnames(rev(df)[1]);
        mainTitle <- paste0(private$Instance, " Table Row List Foreign Key Histogram");
        # graph
        barplot <- ggplot(df, aes(x = factor(TableName), y = KeyRepeats)) +
          ##barplot <- ggplot(t, aes(x = factor(TableRows), y = sqrt(KeyRepeats))) +
          geom_bar(stat = "identity", width = 0.8, position = "dodge", fill = "lightblue") +
          ##scale_y_sqrt(paste0("Square root of ", yTitle)) +
          ggtitle(mainTitle) +
          xlab(xTitle) +
          ylab(yTitle) +
          theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5));
      }
      
      return(barplot);
    },
    getFileFootprint = function() private$FileFootprint,
    PngFootprintWordcloud = function() {
      t <- self$getTibbleFootprintAboveMeans();
      png(filename = private$PngFootprint, width = 800, height = 800);
      wordcloud(words = t$word,
                freq = t$freq,
                min.freq = 1,
                max.words = 200,
                random.order = FALSE,
                rot.per = 0.35,
                colors = brewer.pal(8, "Dark2"));
      dev.off();
    },
    getTibbleFootprint = function() {
      isNull <- !file.exists(private$FileFootprint);
      isEmpty <- if(file.exists(private$FileFootprint)) (file.info(private$FileFootprint)$size == 0) else FALSE;
      isFileNullOrEmpty <- isNull || isEmpty;
      df <- NULL;
      
      if(!isFileNullOrEmpty){
        self$HasFootprint <- TRUE;
        df <-
          read_csv(private$FileFootprint, col_names = c("TableName","IndexName","RecordCount","TotalPages","UsedPages","DataPages","TotalSpaceMB","UsedSpaceMB","DataSpaceMB"),
                   locale = locale(asciify = TRUE), na = c("NULL","NA","","NAN","NaN"));
        df$IndexName <- NULL;
        private$TibbleFootprint <- tibble::as_tibble(df);
      }
      rm(df);
      
      return(private$TibbleFootprint);
    },
    getTibbleFootprintAboveMeans = function() {
      tableWords <- NULL;
      corpusWords <- NULL;
      aTibble <- private$TibbleFootprint;
      meanRecordCount <- mean(aTibble$RecordCount);
      tableWords <- c(tableWords,
                      as.vector(aTibble[which(aTibble$RecordCount >= meanRecordCount),1]));
      meanTotalPages <- mean(aTibble$TotalPages);
      tableWords <- c(tableWords,
                      as.vector(aTibble[which(aTibble$TotalPages >= meanTotalPages),1]));
      meanUsedPages <- mean(aTibble$UsedPages);
      tableWords <- c(tableWords,
                      as.vector(aTibble[which(aTibble$UsedPages >= meanUsedPages),1]));
      meanDataPages <- mean(aTibble$DataPages);
      tableWords <- c(tableWords,
                      as.vector(aTibble[which(aTibble$DataPages >= meanDataPages),1]));
      meanTotalSpaceMB <- mean(aTibble$TotalSpaceMB);
      tableWords <- c(tableWords,
                      as.vector(aTibble[which(aTibble$TotalSpaceMB >= meanTotalSpaceMB),1]));
      meanUsedSpaceMB <- mean(aTibble$UsedSpaceMB);
      tableWords <- c(tableWords,
                      as.vector(aTibble[which(aTibble$UsedSpaceMB >= meanUsedSpaceMB),1]));
      meanDataSpaceMB <- mean(aTibble$DataSpaceMB);
      tableWords <- c(tableWords,
                      as.vector(aTibble[which(aTibble$DataSpaceMB >= meanDataSpaceMB),1]));
      rm(aTibble);
      # DB table footprint means
      print(names(tableWords));
      # DB table footprint wordcloud
      corpusWords <- Corpus(VectorSource(tableWords))
      inspect(corpusWords);
      termDocMatrixSortDesc <- sort(rowSums(as.matrix(TermDocumentMatrix(corpusWords))),
                                    decreasing  = TRUE);
      termDocDataFrameSortDesc <- data.frame(word = names(termDocMatrixSortDesc),
                                             freq = termDocMatrixSortDesc);
      termDocDataFrameSortDesc <- tibble::as_tibble(termDocDataFrameSortDesc);
      
      return(termDocDataFrameSortDesc);
    },
    getFileIO = function() private$FileIO,
    getTibbleIO = function() {
      isNull <- !file.exists(private$FileIO);
      isEmpty <- if(file.exists(private$FileIO)) (file.info(private$FileIO)$size == 0) else FALSE;
      isFileNullOrEmpty <- isNull || isEmpty;
      df <- NULL;
      
      if(!isFileNullOrEmpty){
        self$HasIO <- TRUE;
        df <-
          read_csv(private$FileIO, col_names = c("ObjectSchema","ObjectName","ReadRatio","WriteRatio","TotalReads","TotalWrites"),
                   locale = locale(asciify = TRUE), na = c("NULL","NA","","NAN","NaN"));
        private$TibbleIO <- tibble::as_tibble(df);
      }
      rm(df);
      
      return(private$TibbleIO);
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
    PngFootprint = "",
    FileIO = NULL,
    TibbleCount = NULL,
    TibbleKey = NULL,
    TibbleFootprint = NULL,
    TibbleIO = NULL,
    cleanTibbleCount = function(){
      private$TibbleCount$TableName <- str_split_fixed(private$TibbleCount$TableName, "\\.", 2)[,2];
      private$TibbleCount$TableName <- gsub("]", "", private$TibbleCount$TableName);
      private$TibbleCount$TableName <- gsub("\\[", "", private$TibbleCount$TableName);
    }
  )
)
