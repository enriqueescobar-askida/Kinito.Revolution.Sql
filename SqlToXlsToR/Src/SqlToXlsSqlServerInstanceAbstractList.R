require("R6");
require("readxl");
require("tibble");
# class
SqlToXlsSqlServerInstanceAbstractList <-
  R6Class("SqlToXlsSqlServerInstanceAbstractList",
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
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
      print("SqlToXlsSqlServerInstanceAbstractList.finalize has been called!");
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
    fileToTibble = function() {
      df <- 
        read_excel(private$File, na = "NA", skip = 1,
                  col_names = self$ColumnTitles, trim_ws = TRUE);#locale = locale(asciify = TRUE),
      private$Tibble <- tibble::as_tibble(df);
      rm(df);
    }
  ),
  active = list(
    Ext = function(value) {
      if (missing(value)) return(".xls");
    },
    Header = function(value) {
      if (missing(value)) return("SqlServer-Instance_");
    },
    Tail = function(value) {
      if (missing(value)) return("_tail_");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c(""));
    },
    ColumnTypes = function(value) {
      if (missing(value)) return(c("?"));
    }
  ),
  private = list(
    Path = "_path_",
    ServiceInstance = "_service_instance_",
    Instance = "_instance_",
    File = "_file_",
    Tibble = tibble::as_tibble(data.frame(NULL)),
    setPath = function(value) private$Path <- paste0(value, "/../Xls/"),
    setServiceInstance = function(value) private$ServiceInstance <- value,
    setInstance = function(value) private$Instance <- value,
    setFile = function() private$File <-
      paste0(private$Path, self$Header, private$ServiceInstance, "_", private$Instance, self$Tail, self$Ext)
  )
)
