require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceDbForeignKeyList <- R6Class("SqlToCsvSqlServerInstanceDbForeignKeyList",
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
      if (missing(value)) return("_DbForeignKeyList");
    },
    ColumnTitles = function(value) {
     if (missing(value)) return(c("TableName", "ColumnName", "ForeignKey", "ForeignKeyID",
                                  "ReferenceTableName", "ReferenceColumnName", "FKCreated", "FKModified",
                                  "FKnotTrusted", "OnDelete", "OnUpdate", "SYSFK"));

    }
  ),
  private = list(
  )
)
