require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceDbTriggerList <- R6Class("SqlToCsvSqlServerInstanceDbTriggerList",
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
      if (missing(value)) return("_DbTriggerList");
    },
    ColumnTitles = function(value) {
     if (missing(value)) return(c("TableName", "TriggerObjectId", "TriggerName", "TriggerText", "TriggerCreation",
                                  "TriggerRefDate", "TriggerVersion", "TriggerType", "ObjectType", "TriggerDesc",
                                  "IsInsteadOfTrigger", "IsUpdate", "IsDelete", "IsInsert", "IsAfterTrigger"));

    }
  ),
  private = list(
  )
)
