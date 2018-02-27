require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceLinkedList <- R6Class("SqlToCsvSqlServerInstanceLinkedList",
  portable = TRUE,
  public = list(
    getPath = function() private$Path,
    getServiceInstance = function() private$ServiceInstance,
    getInstance = function() private$Instance,
    getFile = function() private$File,
    getTibble = function() private$Tibble,
#' Title
#' initialize
#' @param path 
#' @param serviceInstance 
#' @param instance 
#'
#' @export
    initialize = function(path, serviceInstance, instance) {
      if (!missing(path)) private$setPath(path);
      if (!missing(serviceInstance)) private$setServiceInstance(serviceInstance);
      if (!missing(instance)) private$setInstance(instance);
      private$setFile();
      cat(self$toString());
    },
#' Title
#' finalize
#' @export
    finalize = function() {
      print("SqlToCsvSqlServerInstanceLinkedList.Finalizer has been called!");
      private$Path <- NULL;
      private$ServiceInstance <- NULL;
      private$Instance <- NULL;
      private$File <- NULL;
      private$Tibble <- NULL;
      cat(self$toString());
    },
#' Title
#' toString
#' @export
    toString = function() {
      aStr <- paste0("--\n", projectNamespace, "\n\t");
      aStr <- paste0(aStr, self$Ext, "\t", private$Path, "\n\t");
      aStr <- paste0(aStr, private$ServiceInstance, "\t", private$Instance, "\n\t");
      aStr <- paste0(aStr, private$File, "\t", colnames(private$Tibble), "\n\t");
      
      return(base::toString(aStr));
    },
#' Title
#' fileToTibble
#' @export
    fileToTibble = function() {
      df <- 
        read_csv(private$File, col_names = FALSE, locale = locale(asciify = TRUE), na = "NA");
      colnames(df) <- self$ColumnTitles;
      private$Tibble <- df;
      rm(df);
    }
  ),
  active = list(
    Ext = function(value) {
      if (missing(value)) return(".csv");
    },
    HeadInstance = function(value) {
      if (missing(value)) return("SqlServer-Instance_");
    },
    Tail = function(value) {
      if (missing(value)) return("_LinkedList");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c("ServerName", "LinkedServerID", "LinkedServer", "Product", "Provider", "DataSource", "ModificationDate", "IsLinked"));
    }
  ),
  private = list(
    Path = "_path_",
    ServiceInstance = "_service_instance_",
    Instance = "_instance_",
    File = "_file_",
    Tibble = tibble::as_tibble(data.frame(NULL)),
    setPath = function(value) private$Path <- paste0(value, "/../Csv/"),
    setServiceInstance = function(value) private$ServiceInstance <- value,
    setInstance = function(value) private$Instance <- value,
    setFile = function() private$File <-
      paste0(private$Path, self$HeadInstance, private$ServiceInstance, "_", private$Instance, self$Tail, self$Ext)
  )
)