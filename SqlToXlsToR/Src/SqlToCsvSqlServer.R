require("R6");
# class
SqlToCsvSqlServer <- R6Class("SqlToCsvSqlServer",
# public members
  public = list(
    Path = "_path_",
    VersionVector = c("_version_"),
    HasVersion = FALSE,
    ServiceInstance = "_server_instance_",
    HasService = FALSE,
    Instance = "_instance_",
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
      private$set_service_instance();
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
      self$VersionVector <- csvList[grepl(self$HeadVersion, csvList)];
      if (length(self$VersionVector) == 1) {
        self$VersionVector <- paste0(self$Path, self$VersionVector);
        self$VersionVector <-
          read.csv(self$VersionVector, header = FALSE, sep = "\t")[[1]];
        self$VersionVector <- strsplit(as.character(self$VersionVector), "\t");
        self$VersionVector <-
          trimws(unlist(self$VersionVector), which = c("both", "left", "right"));
        self$HasVersion = TRUE;
      }
    },
#' Title
#'
#' @return
#' @export
#'
#' @examples
    set_service_instance = function() {
      aPattern <- paste0("*", self$Ext, "$"); 
      csvList <- list.files(self$Path, pattern = aPattern, all.files = TRUE);
      private$set_instance(self$ServiceInstance);
      if (length(self$ServiceInstance) == 1) {
        self$ServiceInstance <- paste0(self$Path, self$ServiceInstance);
        self$ServiceInstance <-
          read.table(self$ServiceInstance, row.names=NULL, quote="\"", comment.char="")[[1]];
        self$ServiceInstance <- as.character(self$ServiceInstance);
        self$ServiceInstance <-
          trimws(self$ServiceInstance, which = c("both", "left", "right"));
        self$HasService = TRUE;
      }
    },
#' Title
#'
#' @param serviceInstance 
#'
#' @return
#' @export
#'
#' @examples
    set_instance = function(serviceInstance = ""){
      self$Instance <- gsub(self$HeadInstance, "", serviceInstance);
      self$Instance <- gsub(self$Ext, "", self$Instance);
    },
    length = function() base::length(private$queue)
  )
)

