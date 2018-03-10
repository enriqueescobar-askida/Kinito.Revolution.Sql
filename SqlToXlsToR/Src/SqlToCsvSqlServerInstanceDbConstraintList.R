require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceDbConstraintList <- R6Class("SqlToCsvSqlServerInstanceDbConstraintList",
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
      if (missing(value)) return("_DbConstraintList");
    },
    ColumnTitles = function(value) {
     if (missing(value)) return(c("DBName", "TableName", "ColumnNumber", "ColumnName", "ConstraintName",
                                  "ConstraintType", "ConstraintDescription", "CreatedDate", "ConstraintDefinition", "name",
                                  "object_id", "principal_id", "schema_id", "parent_object_id", "type",
                                  "type_desc", "create_date", "modify_date", "is_ms_shipped", "is_published",
                                  "is_schema_published", "is_disabled", "is_not_for_replication", "is_not_trusted", "parent_column_id",
                                  "definition", "uses_database_collation", "is_system_named"));

    }
  ),
  private = list(
  )
)
