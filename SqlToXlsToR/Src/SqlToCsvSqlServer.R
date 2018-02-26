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
    HasInstance = FALSE,
#' Title
#' Constructor
#' @param Path 
#' 
#' @export
    initialize = function(Path) {
      if (!missing(Path)) self$Path <- Path;
      private$set_path();
      private$set_version();
      private$set_service_instance();
      private$set_instance();
      cat(self$to_str());
    },
#' Title
#' Destructor
#' @export
    finalize = function() {
      print("SqlToCsvSqlServer.Finalizer has been called!");
      self$Path <- NA;
      self$HasVersion <- NA;
      self$VersionVector <- NA;
      self$HasService <- NA;
      self$ServiceInstance <- NA;
      self$HasInstance <- NA;
      self$Instance <- NA;
      cat(self$to_str());
    },
#' Title
#' set_HeadVersion
#' @param val 
#'
#' @return HeadVersion
#' @export
    set_HeadVersion = function(val) HeadVersion <<- val,
#' Title
#' to_str
#' @return
#' @export
    to_str = function() {
      aStr <- paste0("--\n", projectNamespace, "\n\t");
      aStr <- paste0(aStr, self$Ext, "\t", self$Path, "\n\t");
      aStr <- paste0(aStr, self$HeadVersion, "\t", self$HasVersion, "\n\t");
      aStr <- paste0(aStr, self$HeadService, "\t", self$HasService, "\n\t");
      aStr <- paste0(aStr, self$HeadInstance, "\t", self$HasInstance, "\n\t");
      
      return(aStr);
    }
  ),
# active members
  active = list(
#' Title
#' Ext
#' @param value 
#'
#' @return Ext
#' @export
    Ext = function(value) {
      if (missing(value)) return(".csv");
    },
    HeadService = function(value) {
      if (missing(value)) return("SqlServer-ServiceInstance_");
    },
    HeadVersion = function(value) {
      if (missing(value)) return("SqlServer-Version_");
    },
    HeadInstance = function(value) {
      if (missing(value)) return("SqlServer-Instance_");
    }
  ),
# private members
  private = list(
#' Title
#' set_path
#' @export
    set_path = function(){
      self$Path <- paste0(self$Path, "/../Csv/");
    },
#' Title
#' set_version
#' @export
    set_version = function(){
      self$VersionVector <- private$filter_csv_files(self$HeadVersion);
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
#' set_instance
#' @export
    set_instance = function() {
      self$Instance <- paste0(self$HeadInstance, self$ServiceInstance, "_*");
      self$Instance <- private$filter_csv_files(self$Instance);
      index <- which(nchar(self$Instance) %in% min(nchar(self$Instance)));
      self$Instance <- self$Instance[index];
      index <- paste0(self$Path, self$Instance);
      index <- read.table(index, row.names=NULL, quote="\"", comment.char="")[[1]];
      index <- as.character(index);
      index <- trimws(index, which = c("both", "left", "right"));
      self$Instance <- gsub(self$HeadInstance, "", self$Instance);
      self$Instance <- gsub(self$ServiceInstance, "", self$Instance);
      self$Instance <- gsub(self$Ext, "", self$Instance);
      self$Instance <- gsub("_", "", self$Instance);
      self$HasInstance <- index; #grepl(paste0("*", self$Instance, "$"), index);
      rm(index);
      self$HasInstance <- grepl(paste0("*", self$Instance, "$"), self$HasInstance);
      if (self$HasInstance) self$Instance <- self$Instance;
    },
#' Title
#' set_service_instance
#' @export
    set_service_instance = function() {
      self$ServiceInstance <- private$filter_csv_files(self$HeadService);
      private$check_service_instance(self$ServiceInstance);
      if (length(self$ServiceInstance) == 1) {
        self$ServiceInstance <- paste0(self$Path, self$ServiceInstance);
        self$ServiceInstance <-
          read.table(self$ServiceInstance, row.names=NULL, quote="\"", comment.char="")[[1]];
        self$ServiceInstance <- as.character(self$ServiceInstance);
        self$ServiceInstance <-
          trimws(self$ServiceInstance, which = c("both", "left", "right"));
        self$HasService <- grepl(paste0("*", self$Instance, "$"), self$ServiceInstance);
        if (self$HasService) self$ServiceInstance <- self$Instance;
      }
    },
#' Title
#' check_service_instance
#' @param serviceInstance 
#'
#' @export
    check_service_instance = function(serviceInstance = ""){
      self$Instance <- gsub(self$HeadService, "", serviceInstance);
      self$Instance <- gsub(self$Ext, "", self$Instance);
    },
#' Title
#' filter_csv_files
#' @param aFilter 
#'
#' @return csvList
#' @export
    filter_csv_files = function(aFilter = ""){
      aPattern <- paste0("*", self$Ext, "$"); 
      csvList <- list.files(self$Path, pattern = aPattern, all.files = TRUE);
      
      return(csvList[grepl(aFilter, csvList)]);
    }
  )
)

