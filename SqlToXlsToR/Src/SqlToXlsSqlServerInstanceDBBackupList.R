require("R6");
require("readxl");
require("tibble");
# class
SqlToXlsSqlServerInstanceBackupList <- R6Class("SqlToXlsSqlServerInstanceBackupList",
  inherit = SqlToXlsSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_BackupList");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c("ServerName", "ServiceName", "DBName", "BackupEndDate", "PhysicalDeviceName"));
    }
  ),
  private = list(
  )
)
