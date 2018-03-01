require("R6");
require("readxl");
require("tibble");
# class
SqlToXlsSqlServerInstanceUsageList <- R6Class("SqlToXlsSqlServerInstanceUsageList",
  inherit = SqlToXlsSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_UsageList");
    },
    ColumnTitles = function(value) {
     if (missing(value)) return(c("DBIdentifier", "DBName", "DBBufferPages", "DBBufferMB"));
    }
  ),
  private = list(
  )
)
