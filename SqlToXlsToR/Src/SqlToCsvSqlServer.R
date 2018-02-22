require("R6");
# class
SqlToCsvSqlServer <- R6Class("SqlToCsvSqlServer",
# public members
  public = list(
    name = "_name_",
    hair = "_hair_",
    hundred = 100,
#' Title
#'
#' @param name 
#' @param hair 
#'
#' @return
#' @export
#'
#' @examples
    initialize = function(name, hair) {
      if (!missing(name)) self$name <- name;
      if (!missing(hair)) self$hair <- hair;
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
      self$name <- NA;
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
    set_name = function(val) name <<- val,
    #   {
    #   self$name <- val;
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
      cat(paste0("Hello, my name is ", self$name, "_", self$hair, "_", self$hundred, "_", self$x2 , ".\n"));
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
    length = function() base::length(private$queue)
  )
)

