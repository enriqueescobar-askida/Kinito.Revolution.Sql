require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceLinkedList <- R6Class("SqlToCsvSqlServerInstanceLinkedList",
  inherit = SqlToCsvSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
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
    Tail = function(value) {
      if (missing(value)) return("_LinkedList");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c("ServerName", "LinkedServerID", "LinkedServer", "Product", "Provider", "DataSource", "ModificationDate", "IsLinked"));
    }
  ),
  private = list(
  )
)
