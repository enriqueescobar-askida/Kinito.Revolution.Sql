require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceDbTriggerList <- R6Class("SqlToCsvSqlServerInstanceDbTriggerList",
  inherit = SqlToCsvSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
    initialize = function(path, serviceInstance, instance, dbName) {
      instance <- paste0(instance, "_", dbName);
      super$initialize(path, serviceInstance, instance);
    },
    fileToTibble = function() {
      super$fileToTibble();
      return(private$fixTibble());
    }
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_DbTriggerList");
    },
    ColumnTitles = function(value) {
     if (missing(value)) return(c("TableName", "TriggerObjectId", "TriggerName", "TriggerText", "TriggerCreation",
                                  "TriggerRefDate", "TriggerVersion", "TriggerType", "ObjectType", "TriggerDesc",
                                  "IsInsteadOfTrigger", "IsUpdate", "IsDelete", "IsInsert", "IsAfterTrigger"));

    }
  ),
  private = list(
    fixTibble = function() {
      private$Tibble$TriggerGroup <- "";
      private$Tibble$TriggerSubgroup <- "";
      
      for(i in 1:length(private$Tibble$IsAfterTrigger)){
        
        if(as.logical(private$Tibble$IsAfterTrigger[i]) == TRUE){
          private$Tibble$TriggerGroup[i] <- "AfterTrigger";
          private$Tibble$TriggerSubgroup[i] <- "After";
        } else {
          private$Tibble$TriggerGroup[i] <- "InsteadOfTrigger";
          private$Tibble$TriggerSubgroup[i] <- "InsteadOf";
        }
        
        if(as.logical(private$Tibble$IsUpdate[i]) == TRUE){
          private$Tibble$TriggerSubgroup[i] <-
            paste0(private$Tibble$TriggerSubgroup[i], "Update");
        }
        
        if(as.logical(private$Tibble$IsDelete[i]) == TRUE){
          private$Tibble$TriggerSubgroup[i] <-
            paste0(private$Tibble$TriggerSubgroup[i], "Delete");
        }
        
        if(as.logical(private$Tibble$IsInsert[i]) == TRUE){
          private$Tibble$TriggerSubgroup[i] <-
            paste0(private$Tibble$TriggerSubgroup[i], "Insert");
        }
      }
      rm(i);
    }
  )
)
