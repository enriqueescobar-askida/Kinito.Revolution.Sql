require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceUsageList <- R6Class("SqlToCsvSqlServerInstanceUsageList",
  inherit = SqlToCsvSqlServerInstanceAbstractList,
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
