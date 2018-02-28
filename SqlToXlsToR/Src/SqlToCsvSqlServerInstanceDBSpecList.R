require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceDBSpecList <- R6Class("SqlToCsvSqlServerInstanceDBSpecList",
  inherit = SqlToCsvSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_DBSpecList");
    },
    ColumnTitles = function(value) {
     if (missing(value)) return(c("ServerName", "ServiceName", "DBIdentifier", "DBName", "OriginalDBName", "RecoveryModel", "CompatiblityLevel", "DBSize", "DBGrowth", "IsPercentGrowth", "CreatedDate", "CurrentState", "AutoShrink", "SnapshotState", "IsAutoUpdate", "IsArithAbort", "PageVerifyOption", "Collation", "FilePath", "IdSourceDB"));
    }
  ),
  private = list(
  )
)
