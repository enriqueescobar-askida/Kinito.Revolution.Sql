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
    HasParams = FALSE,
    HasParamsFN = FALSE,
    HasParamsIF = FALSE,
    HasParamsTF = FALSE,
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
        self$HasParamsFN <- nrow(df[df$FunctionType == 'FN',]) >= 1;
        self$HasParamsIF <- nrow(df[df$FunctionType == 'IF',]) >= 1;
        self$HasParamsTF <- nrow(df[df$FunctionType == 'TF',]) >= 1;
      }
      rm(df);
    },
    getTibbleParam = function() {
      # isNull <- !file.exists(private$FileParam);
      # isEmpty <- if(file.exists(private$FileParam)) (file.info(private$FileParam)$size == 0) else FALSE;
      # isFileNullOrEmpty <- isNull || isEmpty;
      # df <- NULL;
      # 
      # if(!isFileNullOrEmpty){
      #   df <-
      #     read_csv(private$FileParam, col_names = c("FunctionName","SchemaName","FunctionType","FunctionDesc","ParameterID","ParameterName","ParameterType","ParamMaxLength","ParameterPrecision","ParameterScale","IsParamOutput"),
      #              locale = locale(asciify = TRUE), na = c("NULL","NA","","NAN","NaN"));
      #   private$TibbleParam <- tibble::as_tibble(df);
      # }
      # rm(df);
      
      return(private$TibbleParam);
    },
    getHistogramParams = function(fnType = "") {
      fnHistogram <- NULL;
      df <- NULL;
      fnValid <- FALSE;
      
      if(fnType == "FN") {
        fnValid <- self$HasParamsFN;
        df <- private$TibbleParam[private$TibbleParam$FunctionType == 'FN',];
      } else if(fnType == "IF") {
        fnValid <- self$HasParamsIF;
        df <- private$TibbleParam[private$TibbleParam$FunctionType == 'IF',];
      } else if(fnType == "TF") {
        fnValid <- self$HasParamsTF;
        df <- private$TibbleParam[private$TibbleParam$FunctionType == 'TF',];
      } else {
        return(fnHistogram);
      }
      
      if (fnValid) {
        fnHistogram <- gsub(super$Ext, paste0("_", fnType), private$FileParam);
        write(fnHistogram, stdout());
        df$ParameterID <- as.integer(df$ParameterID);
        df <- df[, c(1, 5)];
        # titles
        xTitle <- colnames(df)[1];
        yTitle <- colnames(rev(df)[1]);
        mainTitle <- paste0(private$Instance, " Table ", fnType, " List ", yTitle, " Histogram");
        # graph
        fnHistogram <- ggplot(df, aes(x = factor(FunctionName), y = ParameterID)) +
          ##fnHistogram <- ggplot(t, aes(x = factor(TableRows), y = sqrt(KeyRepeats))) +
          geom_bar(stat = "identity", width = 0.8, position = "dodge", fill = "lightblue") +
          ##scale_y_sqrt(paste0("Square root of ", yTitle)) +
          ggtitle(mainTitle) +
          xlab(xTitle) +
          ylab(yTitle) +
          theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5));
        
        rm(df);
        rm(fnValid);
        rm(xTitle);
        rm(yTitle);
        rm(mainTitle);
      }
      
      return(fnHistogram);
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
