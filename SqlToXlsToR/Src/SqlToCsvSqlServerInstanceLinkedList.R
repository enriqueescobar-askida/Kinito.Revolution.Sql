require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceLinkedList <- R6Class("SqlToCsvSqlServerInstanceLinkedList",
  inherit = SqlToCsvSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_LinkedList");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c("ServerName", "LinkedServerID", "LinkedServer", "Product", "Provider", "DataSource", "ModificationDate", "IsLinked"));
    }
  ),
  private = list(
  )
)
