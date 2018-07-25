require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceDbProcedureList <- R6Class("SqlToCsvSqlServerInstanceDbProcedureList",
  inherit = SqlToCsvSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
    HasParams = FALSE,
    HasParamsP = FALSE,
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
        private$FileParam <- gsub("DbProcedureList.", "DbProcedureParamList.", private$File);
        private$FileIO <- gsub("DbProcedureList.", "DbProcedureIOList.", private$File);
      }
    },
    getFileIO = function() private$FileIO,
    getTibbleIO = function() {
      isNull <- !file.exists(private$FileIO);
      isEmpty <- if(file.exists(private$FileIO)) (file.info(private$FileIO)$size == 0) else FALSE;
      isFileNullOrEmpty <- isNull || isEmpty;
      df <- NULL;
      
      if(!isFileNullOrEmpty){
        df <-
          read_csv(private$FileIO, col_names = c("StoreProcName","TotalPhysicalReads","TotalElapsedTime","ExecutionCount","CachedTime","TotalLogicalReads","TotalLogicalWrites"),
                   locale = locale(asciify = TRUE), na = c("NULL","NA","","NAN","NaN"));
        private$TibbleIO <- tibble::as_tibble(df);
      }
      rm(df);
      
      return(private$TibbleIO);
    },
    getFileParam = function() private$FileParam,
    fileToTibbleParam = function() {
      isNull <- !file.exists(private$FileParam);
      isEmpty <- if(file.exists(private$FileParam)) (file.info(private$FileParam)$size == 0) else FALSE;
      isFileNullOrEmpty <- isNull || isEmpty;
      df <- NULL;
      
      if(!isFileNullOrEmpty){
        self$HasParams <- TRUE;
        df <-
          read_csv(private$FileParam, col_names = c("ProcedureName","SchemaName","ProcedureType","ProcedureDesc","ParameterID","ParameterName","ParameterType","ParamMaxLength","ParameterPrecision","ParameterScale","IsParamOutput"),
                   locale = locale(asciify = TRUE), na = c("NULL","NA","","NAN","NaN"));
        private$TibbleParam <- tibble::as_tibble(df);
        self$HasParamsP <- nrow(df[df$ProcedureType == 'P',]) >= 1;
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
      #   self$HasParams <- TRUE;
      #   df <-
      #     read_csv(private$FileParam, col_names = c("ProcedureName","SchemaName","ProcedureType","ProcedureDesc","ParameterID","ParameterName","ParameterType","ParamMaxLength","ParameterPrecision","ParameterScale","IsParamOutput"),
      #              locale = locale(asciify = TRUE), na = c("NULL","NA","","NAN","NaN"));
      #   private$TibbleParam <- tibble::as_tibble(df);
      # }
      # rm(df);
      
      return(private$TibbleParam);
    },
    getHistogramParams = function(procType = "") {
      procHistogram <- NULL;
      df <- NULL;
      procValid <- FALSE;
      
      if(procType == "P") {
        procValid <- self$HasParamsP;
        df <- private$TibbleParam[private$TibbleParam$ProcedureType == 'P',];
      } else {
        return(procHistogram);
      }
      
      if (procValid) {
        procHistogram <- gsub(super$Ext, paste0("_", procType), private$FileParam);
        write(procHistogram, stdout());
        df$ParameterID <- as.integer(df$ParameterID);
        df <- df[, c(1, 5)];
        # titles
        xTitle <- colnames(df)[1];
        yTitle <- colnames(rev(df)[1]);
        mainTitle <- paste0(private$Instance, " Table ", procType, " List ", yTitle, " Histogram");
        # graph
        procHistogram <- ggplot(df, aes(x = factor(ProcedureName), y = ParameterID)) +
          ##procHistogram <- ggplot(t, aes(x = factor(TableRows), y = sqrt(KeyRepeats))) +
          geom_bar(stat = "identity", width = 0.8, position = "dodge", fill = "lightblue") +
          ##scale_y_sqrt(paste0("Square root of ", yTitle)) +
          ggtitle(mainTitle) +
          xlab(xTitle) +
          ylab(yTitle) +
          theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5));
        
        rm(df);
        rm(procValid);
        rm(xTitle);
        rm(yTitle);
        rm(mainTitle);
      }
      
      return(procHistogram);
    }
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_DbProcedureList");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c("ProcedureName", "ProcedureID", "ProcedureType", "ProcedureDesc", "ProcedureCreated",
                                   "ProcedureModified","IsProcedureMSShipped"));
    }
  ),
  private = list(
    objectTibble = NULL,
    FileIO = "",
    FileParam = "",
    TibbleIO = NULL,
    TibbleParam = NULL
  )
)
