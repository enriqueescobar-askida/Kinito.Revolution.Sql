require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceRunningList <- R6Class("SqlToCsvSqlServerInstanceRunningList",
  inherit = SqlToCsvSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_RunningList");
    },
    ColumnTitles = function(value) {
     if (missing(value)) return(c("ServerName", "ServiceName", "ServerStarted", "DaysRunning"));
    }
  ),
  private = list(
  )
)
