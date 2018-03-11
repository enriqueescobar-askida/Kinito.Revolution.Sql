require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceDbPrincipalKeyList <- R6Class("SqlToCsvSqlServerInstanceDbPrincipalKeyList",
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
      if (missing(value)) return("_DbPrincipalKeyList");
    },
    ColumnTitles = function(value) {
     if (missing(value)) return(c("TableName", "ColumnName", "PrincipalKey", "PrincipalKeyID",
                                  "PKCreated", "PKModified", "PKOrdinal"));

    }
  ),
  private = list(
  )
)
