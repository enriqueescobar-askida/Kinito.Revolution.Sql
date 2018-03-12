require("R6");
require("readr");
require("tibble");
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
    objectTibble = NULL
  )
)
