require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceDBBackupList <- R6Class("SqlToCsvSqlServerInstanceDBBackupList",
  inherit = SqlToCsvSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_DBBackupList");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c("ServerName", "ServiceName", "DBName", "BackupEndDate", "PhysicalDeviceName"));
    }
  ),
  private = list(
  )
)
