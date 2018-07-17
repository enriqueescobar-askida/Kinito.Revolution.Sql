require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceDbFunctionList <- R6Class("SqlToCsvSqlServerInstanceDbFunctionList",
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
      # tibbleSize <- dim(private$Tibble)[1];
      # isOk <- FALSE;
      # for(num in private$objectTibble$ObjectCount) isOk <- isOk || (tibbleSize==num);
      # if (!isOk) {
      #   private$Tibble <- NULL;
      # } else {
        private$FileParam <- gsub("DbFunctionList.", "DbFunctionParamList.", private$File);
      # }
    },
    getFileParam = function() private$FileParam,
    fileToTibbleParam = function() {
      isNull <- !file.exists(private$FileParam);
      isEmpty <- if(file.exists(private$FileParam)) (file.info(private$FileParam)$size == 0) else FALSE;
      isFileNullOrEmpty <- isNull || isEmpty;
      df <- NULL;
      
      if(!isFileNullOrEmpty){
        df <-
          read_csv(private$FileParam, col_names = c("FunctionName","SchemaName","FunctionType","FunctionDesc","ParameterID","ParameterName","ParameterType","ParamMaxLength","ParameterPrecision","ParameterScale","IsParamOutput"),
                   locale = locale(asciify = TRUE), na = c("NULL","NA","","NAN","NaN"));
        private$TibbleParam <- tibble::as_tibble(df);
      }
      rm(df);
    },
    getTibbleParam = function() {
      isNull <- !file.exists(private$FileParam);
      isEmpty <- if(file.exists(private$FileParam)) (file.info(private$FileParam)$size == 0) else FALSE;
      isFileNullOrEmpty <- isNull || isEmpty;
      df <- NULL;
      
      if(!isFileNullOrEmpty){
        df <-
          read_csv(private$FileParam, col_names = c("FunctionName","SchemaName","FunctionType","FunctionDesc","ParameterID","ParameterName","ParameterType","ParamMaxLength","ParameterPrecision","ParameterScale","IsParamOutput"),
                   locale = locale(asciify = TRUE), na = c("NULL","NA","","NAN","NaN"));
        private$TibbleParam <- tibble::as_tibble(df);
      }
      rm(df);
      
      return(private$TibbleParam);
    }
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_DbFunctionList");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c("FunctionName", "FunctionID", "FunctionType", "FunctionDesc", "FunctionCreated",
                                   "FunctionModified"));
    }
  ),
  private = list(
    objectTibble = NULL,
    FileParam = "",
    TibbleParam = NULL
  )
)
