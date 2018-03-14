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
      }
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
      }
      
      private$TibbleCount <- tibble::as_tibble(df);
      rm(df);
      private$cleanTibbleCount();
      
      return(private$TibbleCount);
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
    TibbleCount = NULL,
    cleanTibbleCount = function(){
      private$TibbleCount$TableName <- str_split_fixed(private$TibbleCount$TableName, "\\.", 2)[,2];
      private$TibbleCount$TableName <- gsub("]", "", private$TibbleCount$TableName);
      private$TibbleCount$TableName <- gsub("\\[", "", private$TibbleCount$TableName);
    }
  )
)
