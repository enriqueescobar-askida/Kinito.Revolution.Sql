require("R6");
# class
SqlToCsvSqlServer <- R6Class("SqlToCsvSqlServer",
# public members
  public = list(
    Path = "_path_",
    hair = "_hair_",
    hundred = 100,
#' Title
#'
#' @param Path 
#' @param hair 
#'
#' @return
#' @export
#'
#' @examples
    initialize = function(Path, hair) {
      if (!missing(Path)) self$Path <- Path;
      if (!missing(hair)) self$hair <- hair;
      private$set_path();
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
      self$hair <- NA;
      self$hundred <- NA;
      self$x2 <- NA;
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
    #   {
    #   self$Path <- val;
    # },
#' Title
#'
#' @param val 
#'
#' @return
#' @export
#'
#' @examples
    set_hair = function(val) hair <<- val,
    #   {
    #   self$hair <- val;
    # },
#' Title
#'
#' @return
#' @export
#'
#' @examples
    to_str = function() {
      cat(paste0("Hello, my Path is ", self$Path, "_", self$hair, "_", self$hundred, "_", self$x2 , ".\n"));
    }
  ),
# active members
  active = list(
    x2 = function(value) {
      if (missing(value)) return(self$hundred * 2);
      #else self$hundred <- value / 2;
    }#,
    #rand = function() rnorm(1);
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
      self$Path <- paste0(self$Path, "../Csv");
    },
    length = function() base::length(private$queue)
  )
)

