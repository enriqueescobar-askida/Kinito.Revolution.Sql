require("R6");
require("readxl");
# class
SqlToXlsSqlServer <- R6Class("SqlToXlsSqlServer",
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
# public members
  public = list(
    HasVersion = FALSE,
    HasService = FALSE,
    HasInstance = FALSE,
#' Title
#' Constructor
#' @param path 
#' 
#' @export
    initialize = function(path) {
      if (!missing(path)) private$setPath(path);
      private$setVersion();
      private$setServiceInstance();
      private$setInstance();
      cat(self$toString());
    },
#' Title
#' Destructor
#' @export
    finalize = function() {
      print("SqlToXlsSqlServer.Finalizer has been called!");
      private$Path <- NULL;
      self$HasVersion <- NULL;
      private$VersionVector <- NULL;
      self$HasService <- NULL;
      private$ServiceInstance <- NULL;
      self$HasInstance <- NULL;
      private$Instance <- NULL;
      cat(self$toString());
    },
    getPath = function() private$Path,
    getVersionVector = function() private$VersionVector,
    getServiceInstance = function() private$ServiceInstance,
    getInstance = function() private$Instance,
#' Title
#' toString
#' @return
#' @export
    toString = function() {
      aStr <- paste0("--\n", projectNamespace, "\n\t");
      aStr <- paste0(aStr, self$Ext, "\t", private$Path, "\n\t");
      aStr <- paste0(aStr, self$HeadVersion, "\t", self$HasVersion, "\n\t");
      aStr <- paste0(aStr, self$HeadService, "\t", self$HasService, "\n\t");
      aStr <- paste0(aStr, self$HeadInstance, "\t", self$HasInstance, "\n\t");
      
      return(base::toString(aStr));
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
      if (missing(value)) return(".xls");
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
    Path = "_path_",
    VersionVector = c("_version_"),
    ServiceInstance = "_server_instance_",
    Instance = "_instance_",
#' Title
#' setPath
#' @export
    setPath = function(value){
      private$Path <- paste0(value, "/../Xls/");
    },
#' Title
#' setVersion
#' @export
    setVersion = function(){
      private$VersionVector <- private$filterXlsFiles(self$HeadVersion);
      if (length(private$VersionVector) == 1) {
        private$VersionVector <- paste0(private$Path, private$VersionVector);
        private$VersionVector <-
          read_excel(private$VersionVector, na = "NA", skip = 1,
                    col_names = FALSE, trim_ws = TRUE)[[1]];#, locale = locale(asciify = TRUE)
        private$VersionVector <- strsplit(as.character(private$VersionVector), "\t");
        private$VersionVector <-
          trimws(unlist(private$VersionVector), which = c("both", "left", "right"));
        self$HasVersion = TRUE;
      }
    },
#' Title
#' setInstance
#' @export
    setInstance = function() {
      private$Instance <- paste0(self$HeadInstance, private$ServiceInstance, "_*");
      private$Instance <- private$filterXlsFiles(private$Instance);
      index <- which(nchar(private$Instance) %in% min(nchar(private$Instance)));
      private$Instance <- private$Instance[index];
      index <- paste0(private$Path, private$Instance);
      index <-
        read_excel(index, na = "NA", skip = 1,
                   col_names = FALSE, trim_ws = TRUE)[[1]];#, locale = locale(asciify = TRUE)
      # index <- as.character(index);
      # index <- trimws(index, which = c("both", "left", "right"));
      # private$Instance <- gsub(self$HeadInstance, "", private$Instance);
      # private$Instance <- gsub(private$ServiceInstance, "", private$Instance);
      # private$Instance <- gsub(self$Ext, "", private$Instance);
      # private$Instance <- gsub("_", "", private$Instance);
      private$Instance <- index;
      private$Instance <- gsub("_", "", private$Instance);
      private$Instance <- gsub("\\\\","-",private$Instance);
      self$HasInstance <- TRUE; #grepl(paste0("*", private$Instance, "$"), index);
      rm(index);
      # self$HasInstance <- grepl(paste0("*", private$Instance, "$"), self$HasInstance);
      # if (self$HasInstance) private$Instance <- private$Instance;
    },
#' Title
#' setServiceInstance
#' @export
    setServiceInstance = function() {
      private$ServiceInstance <- private$filterXlsFiles(self$HeadService);
      private$checkServiceInstance(private$ServiceInstance);
      if (length(private$ServiceInstance) == 1) {
        private$ServiceInstance <- paste0(private$Path, private$ServiceInstance);
        private$ServiceInstance <-
          read_excel(private$ServiceInstance, na = "NA", skip = 1,
                     col_names = FALSE, trim_ws = TRUE)[[1]];#, locale = locale(asciify = TRUE)
        private$ServiceInstance <- as.character(private$ServiceInstance);
        private$ServiceInstance <-
          trimws(private$ServiceInstance, which = c("both", "left", "right"));
        self$HasService <- grepl(paste0("*", private$Instance, "$"), private$ServiceInstance);
        if (self$HasService) private$ServiceInstance <- private$Instance;
      }
    },
#' Title
#' checkServiceInstance
#' @param serviceInstance 
#'
#' @export
    checkServiceInstance = function(serviceInstance = ""){
      private$Instance <- gsub(self$HeadService, "", serviceInstance);
      private$Instance <- gsub(self$Ext, "", private$Instance);
    },
#' Title
#' filterXlsFiles
#' @param aFilter 
#'
#' @return xlsList
#' @export
    filterXlsFiles = function(aFilter = ""){
      aPattern <- paste0("*", self$Ext, "$"); 
      xlsList <- list.files(private$Path, pattern = aPattern, all.files = TRUE);
      
      return(xlsList[grepl(aFilter, xlsList)]);
    }
  )
)

