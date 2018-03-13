require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceDbViewList <- R6Class("SqlToCsvSqlServerInstanceDbViewList",
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
      if (private$objectTibble[[2]] != dim(private$Tibble)[1]) private$Tibble <- NULL;
    }
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_DbViewList");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c("ServerName", "ServiceName", "DBName", "DbViewEndDate", "PhysicalDeviceName"));
    }
  ),
  private = list(
    objectTibble = NULL
  )
)
