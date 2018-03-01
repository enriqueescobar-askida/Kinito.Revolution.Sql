require("R6");
require("readxl");
require("tibble");
# class
SqlToXlsSqlServerInstanceDBBackupList <- R6Class("SqlToXlsSqlServerInstanceDBBackupList",
  inherit = SqlToXlsSqlServerInstanceAbstractList,
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
