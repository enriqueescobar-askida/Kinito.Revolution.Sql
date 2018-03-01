require("R6");
require("readxl");
require("tibble");
# class
SqlToXlsSqlServerInstanceRunningList <- R6Class("SqlToXlsSqlServerInstanceRunningList",
  inherit = SqlToXlsSqlServerInstanceAbstractList,
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
