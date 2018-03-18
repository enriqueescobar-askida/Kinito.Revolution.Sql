require("R6");
require("tibble");
require("dplyr");
require("tm");
require("wordcloud");
# class
SqlToFileSqlServerInstanceAbstractList <-
  R6Class("SqlToFileSqlServerInstanceAbstractList",
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
    IsFileNullOrEmpty = TRUE,
    getPath = function() private$Path,
    getServiceInstance = function() private$ServiceInstance,
    getInstance = function() private$Instance,
    getFile = function() private$File,
    getTibble = function() private$Tibble,
    initialize = function(path, serviceInstance, instance) {
      if (!missing(path)) private$setPath(path);
      if (!missing(serviceInstance)) private$setServiceInstance(serviceInstance);
      if (!missing(instance)) private$setInstance(instance);
      private$setFile();
      cat(self$toString());
    },
    finalize = function() {
      print("SqlToFileSqlServerInstanceAbstractList.finalize has been called!");
      private$Path <- NULL;
      private$ServiceInstance <- NULL;
      private$Instance <- NULL;
      private$File <- NULL;
      private$Tibble <- NULL;
      cat(self$toString());
    },
    toString = function() {
      aStr <- paste0("--\n", projectNamespace, "\t", self$Ext, "\n\t");
      aStr <- paste0(aStr, self$Header, "\t", private$Path, "\n\t");
      aStr <- paste0(aStr, private$ServiceInstance, "\t", private$Instance, "\n\t");
      aStr <- paste0(aStr, private$File, "\t", paste(colnames(private$Tibble),collapse=" "), "\n\t");
      
      return(base::toString(aStr));
    },
    getPiechartGgplot2 = function(){
      return(NULL);
    },
    getBarplotGgplot2 = function(){
      return(NULL);
    },
    pngPiechartGgplot2 = function(){
      if(!is.null(private$Tibble)){
        if(!is.null(self$getPiechartGgplot2())){
          
          return(self$pngGgplot2("_Piechart", self$getPiechartGgplot2()));
        }
      }
    },
    pngBarplotGgplot2 = function(){
      if(!is.null(private$Tibble)){
        if(!is.null(self$getBarplotGgplot2())){
          
          return(self$pngGgplot2("_Barplot", self$getBarplotGgplot2()));
        }
      }
    },
    pngGgplot2 = function(tail = "", aPlot = NULL) {
      pngFile <- gsub(self$Ext, "", private$File);
      pngFile <- paste0(pngFile,tail,".png");
      #ggsave(filename = private$File, plot = aPlot, dpi = 100);
      
      return(pngFile);
    }
  ),
  active = list(
    Header = function(value) {
      if (missing(value)) return("SqlServer-Instance_");
    },
    Tail = function(value) {
      if (missing(value)) return("_tail_");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c(""));
    }
  ),
  private = list(
    Path = "_path_",
    ServiceInstance = "_service_instance_",
    Instance = "_instance_",
    File = "_file_",
    Tibble = NULL,
    setServiceInstance = function(value) private$ServiceInstance <- value,
    setInstance = function(value) private$Instance <- value,
    setFile = function() {
      private$File <-
      paste0(private$Path, self$Header, private$ServiceInstance, "_", private$Instance, self$Tail, self$Ext);
      isNull <- !file.exists(private$File);
      isEmpty <- if(file.exists(private$File)) (file.info(private$File)$size == 0) else FALSE;
      self$IsFileNullOrEmpty <- isNull || isEmpty;
    },
    getFrequencyTable = function(colName = "") {
      frequencyTable <- NULL;
      
      if (!is.null(private$Tibble) & !is.null(colName)) {
        frequencyTable <- table(private$Tibble[colName]);
      }
      
      return(frequencyTable);
    }
  )
)
