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
      if (!isOk) private$Tibble <- NULL;
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
    objectTibble = NULL
  )
)
