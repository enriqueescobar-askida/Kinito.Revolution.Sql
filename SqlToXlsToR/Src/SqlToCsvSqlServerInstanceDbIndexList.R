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
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_DbIndexList");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c("ServerName", "ServiceName", "DBName", "BackupEndDate", "PhysicalDeviceName"));
    }
  ),
  private = list(
  )
)
