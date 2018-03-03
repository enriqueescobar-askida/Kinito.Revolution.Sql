require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceDbObjectList <- R6Class("SqlToCsvSqlServerInstanceDbObjectList",
  inherit = SqlToCsvSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
    initialize = function(path, serviceInstance, instance, dbName) {
      instance <- paste0(instance, "_", dbName);
      super$initialize(path, serviceInstance, instance);
    }
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_DbObjectList");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c("ServerName", "ServiceName", "DBName", "DbObjectEndDate", "PhysicalDeviceName"));
    }
  ),
  private = list(
  )
)
