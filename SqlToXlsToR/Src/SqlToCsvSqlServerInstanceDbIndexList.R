require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceDbIndexList <- R6Class("SqlToCsvSqlServerInstanceDbIndexList",
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
      if (missing(value)) return("_DbIndexList");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c("DBName", "TableName", "ColumnNumber", "ColumnName", "ConstraintName",
                                   "ConstraintType", "ConstraintDescription", "CreatedDate", "ConstraintDefinition", "Physical",
                                   "UsesDBCollation", "IsSystemNamed"));
    }
  ),
  private = list(
  )
)
