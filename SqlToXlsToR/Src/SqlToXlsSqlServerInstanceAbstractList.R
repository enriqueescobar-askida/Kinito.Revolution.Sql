require("R6");
require("readxl");
require("tibble");
# class
SqlToXlsSqlServerInstanceAbstractList <-
  R6Class("SqlToXlsSqlServerInstanceAbstractList",
  inherit = SqlToFileSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
    fileToTibble = function() {
      df <- 
        read_excel(private$File, na = "NA", skip = 1,
                  col_names = self$ColumnTitles, trim_ws = TRUE);#locale = locale(asciify = TRUE),
      private$Tibble <- tibble::as_tibble(df);
      rm(df);
    },
    getPiechartGgplot2 = function(){
      return(NULL);
    },
    getBarplotGgplot2 = function(){
      return(NULL);
    }
  ),
  active = list(
    Ext = function(value) {
      if (missing(value)) return(".xls");
    }
  ),
  private = list(
    setPath = function(value) private$Path <- paste0(value, "/../Xls/")
  )
)
