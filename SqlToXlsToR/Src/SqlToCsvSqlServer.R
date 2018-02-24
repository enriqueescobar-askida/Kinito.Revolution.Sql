require("R6");
# class
SqlToCsvSqlServer <- R6Class("SqlToCsvSqlServer",
# public members
  public = list(
    Path = "_path_",
    Version = "_version_",
    HasVersion = FALSE,
    HasInstance = FALSE,
#' Title
#'
#' @param Path 
#'
#' @return
#' @export
#'
#' @examples
    initialize = function(Path) {
      if (!missing(Path)) self$Path <- Path;
      private$set_path();
      private$set_version();
      self$to_str();
    },
#' Title
#'
#' @return
#' @export
#'
#' @examples
    finalize = function() {
      print("SqlToCsvSqlServer.Finalizer has been called!");
      self$Path <- NA;
      self$HeadVersion <- NA;
      self$HeadInstance <- NA;
      self$Ext <- NA;
      self$to_str();
    },
#' Title
#'
#' @param x 
#'
#' @return
#' @export
#'
#' @examples
    add_item = function(x) {
      private$queue <- c(private$queue, list(x));
      invisible(self);
    },
#' Title
#'
#' @return
#' @export
#'
#' @examples
    rm_item = function() {
      if (private$length() == 0) return(NULL);
      # Can use private$queue for explicit access
      head <- private$queue[[1]];
      private$queue <- private$queue[-1];
      head;
    },
#' Title
#'
#' @param val 
#'
#' @return
#' @export
#'
#' @examples
    set_name = function(val) Path <<- val,
#' Title
#'
#' @param val 
#'
#' @return
#' @export
#'
#' @examples
    set_HeadVersion = function(val) HeadVersion <<- val,
#' Title
#'
#' @return
#' @export
#'
#' @examples
    to_str = function() {
      return(paste0("Hello ", self$Path, "_", self$HeadVersion, "_", self$HeadInstance, "_", self$Ext , "\n"));
    }
  ),
# active members
  active = list(
#' Title
#'
#' @param value 
#'
#' @return
#' @export
#'
#' @examples
    Ext = function(value) {
      if (missing(value)) return(".csv");
    },
    HeadInstance = function(value) {
      if (missing(value)) return("SqlServer-ServiceInstance_");
    },
    HeadVersion = function(value) {
      if (missing(value)) return("SqlServer-Version_");
    }
  ),
# private members
  private = list(
    queue = list(),
#' Title
#'
#' @return
#' @export
#'
#' @examples
    set_path = function(){
      self$Path <- paste0(self$Path, "/../Csv/");
    },
#' Title
#'
#' @return
#' @export
#'
#' @examples
    set_version = function(){
      aPattern <- paste0("*", self$Ext, "$"); 
      csvList <- list.files(self$Path, pattern = aPattern, all.files = TRUE);
      self$Version <- csvList[grepl(self$HeadVersion, csvList)];
      if (length(self$Version) == 1) self$HasVersion = TRUE;
    },
    length = function() base::length(private$queue)
  )
)

