require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceAbstractList <-
  R6Class("SqlToCsvSqlServerInstanceAbstractList",
  inherit = SqlToFileSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
    fileToTibble = function() {
      df <- NULL;
      if(!self$IsFileNullOrEmpty){
        df <-
          read_csv(private$File, col_names = self$ColumnTitles,
                   locale = locale(asciify = TRUE), na = c("NULL","NA","","NAN","NaN"));
        private$Tibble <- tibble::as_tibble(df);
      }
      rm(df);
    }
  ),
  active = list(
    Ext = function(value) {
      if (missing(value)) return(".csv");
    }
  ),
  private = list(
    setPath = function(value) private$Path <- paste0(value, "/../Csv/")
  )
)
