require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceAbstractList <-
  R6Class("SqlToCsvSqlServerInstanceAbstractList",
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
    Name = NA,
    getPath = function() private$Path,
    getServiceInstance = function() private$ServiceInstance,
    getInstance = function() private$Instance,
    getFile = function() private$File,
    getTibble = function() private$Tibble,
    toString = function() {
      aStr <- paste0("--\n", projectNamespace, "\t", self$Ext, "\n\t");
      aStr <- paste0(aStr, self$Header, "\t", private$Path, "\n\t");
      aStr <- paste0(aStr, private$ServiceInstance, "\t", private$Instance, "\n\t");
      aStr <- paste0(aStr, private$File, "\t", colnames(private$Tibble), "\n\t");
      
      return(base::toString(aStr));
    }
  ),
  active = list(
    Ext = function(value) {
      if (missing(value)) return(".csv");
    },
    Header = function(value) {
      if (missing(value)) return("SqlServer-Instance_");
    }
  ),
  private = list(
    Path = "_path_",
    ServiceInstance = "_service_instance_",
    Instance = "_instance_",
    File = "_file_",
    Tibble = tibble::as_tibble(data.frame(NULL)),
    setPath = function(value) private$Path <- paste0(value, "/../Csv/"),
    setServiceInstance = function(value) private$ServiceInstance <- value,
    setInstance = function(value) private$Instance <- value,
    setFile = function() private$File <-
      paste0(private$Path, self$Header, private$ServiceInstance, "_", private$Instance, self$Tail, self$Ext)
  )
)
