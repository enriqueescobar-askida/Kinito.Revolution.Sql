require("R6");
require("tibble");
require("readr");
# class
SqlToCsvSqlServerInstanceFactory <-
  R6Class("SqlToCsvSqlServerInstanceFactory",
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
    IsVectorValid = FALSE,
    initialize = function(path = "_",
                          stringVector = c("")) {
      if (!missing(path)) private$setPath(path);
      if (!missing(stringVector)) private$setSourceVector(stringVector);
      self$IsVectorValid <- private$validateSourceVector();
      private$loadSourceVector();
    },
    getLinkedList = function(){
      aList <-
        SqlToCsvSqlServerInstanceLinkedList$new(private$Path, private$SqlServiceInstance, private$SqlServerInstance);
      aList$fileToTibble();
      aTibble <- aList$getTibble();
      rm(aList);
      return(tibble::as_tibble(aTibble));
    },
    getUsageList = function(){
      aList <-
        SqlToCsvSqlServerInstanceUsageList$new(private$Path, private$SqlServiceInstance, private$SqlServerInstance);
      aList$fileToTibble();
      aTibble <- aList$getTibble();
      rm(aList);
      return(tibble::as_tibble(aTibble));
    },
    getUsageListBarplot = function(){
      aList <-
        SqlToCsvSqlServerInstanceUsageList$new(private$Path, private$SqlServiceInstance, private$SqlServerInstance);
      aList$fileToTibble();
      aBarplot <- aList$getBarplotGgplot2();
      rm(aList);
      
      return(aBarplot);
    },
    getUsageListPiechart = function(){
      aList <-
        SqlToCsvSqlServerInstanceUsageList$new(private$Path, private$SqlServiceInstance, private$SqlServerInstance);
      aList$fileToTibble();
      aPiechart <- aList$getPiechartGgplot2();
      rm(aList);
      
      return(aPiechart);
    },
    getDBBackupList = function(){
      aList <-
        SqlToCsvSqlServerInstanceDBBackupList$new(private$Path, private$SqlServiceInstance, private$SqlServerInstance);
      aList$fileToTibble();
      aTibble <- aList$getTibble();
      rm(aList);
      return(tibble::as_tibble(aTibble));
    },
    getRunningList = function(){
      aList <-
        SqlToCsvSqlServerInstanceRunningList$new(private$Path, private$SqlServiceInstance, private$SqlServerInstance);
      aList$fileToTibble();
      aTibble <- aList$getTibble();
      rm(aList);
      return(tibble::as_tibble(aTibble));
    },
    getDBSpecList = function(){
      aList <-
        SqlToCsvSqlServerInstanceDBSpecList$new(private$Path, private$SqlServiceInstance, private$SqlServerInstance);
      aList$fileToTibble();
      aTibble <- aList$getTibble();
      rm(aList);
      return(tibble::as_tibble(aTibble));
    },
    setSqlServerInstance = function(value) private$SqlServerInstance <- value,
    setSqlServiceInstance = function(value) private$SqlServiceInstance <- value
  ),
  active = list(
    # Tail = function(value) {
    #   if (missing(value)) return("_Factory");
    # },
    # ColumnTitles = function(value) {
    #   if (missing(value)) return(c("ServerName", "LinkedServerID", "LinkedServer", "Product", "Provider", "DataSource", "ModificationDate", "IsLinked"));
    # }
  ),
  private = list(
    Path = "_path_",
    SqlServerInstance = "_sql_server_instance",
    SqlServiceInstance = "_sql_service_instance",
    SourceVector = c("_"),
    TibbleVector = list(as.tibble(data.frame(NULL))),
    setPath = function(value) private$Path <- value,
    setSourceVector = function(value) private$SourceVector <- value,
    validateSourceVector = function(){

      return(!is.na(private$SourceVector) && !is.null(private$SourceVector) &&
               (length(private$SourceVector) >= 1));
    },
    loadSourceVector = function(){
      if (self$IsVectorValid){
        for (sourceIndex in seq_along(private$SourceVector)) {
          projectSourceFile <- paste0(private$Path, "/", private$SourceVector[sourceIndex]);
          write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
          source(projectSourceFile);
        }
        rm(sourceIndex);
        private$SourceVector <- private$SourceVector[-c(1, 2)];
      }
      private$Path <- paste0(private$Path, "/..");
    },
    getSqlServerInstanceList = function(){
      df <- as.tibble(data.frame(NULL));
      
      return(df);
    },
    setTibbleVector = function(){
      for (sourceIndex in seq_along(private$SourceVector))
      {
        if(grepl("LinkedList", private$SourceVector[sourceIndex]))
          private$TibbleVector[[sourceIndex]] <- self$getLinkedList();
        if(grepl("UsageList", private$SourceVector[sourceIndex]))
          private$TibbleVector[[sourceIndex]] <- self$getUsageList();
        if(grepl("DBBackupList", private$SourceVector[sourceIndex]))
          private$TibbleVector[[sourceIndex]] <- self$getDBBackupList();
        if(grepl("RunningList", private$SourceVector[sourceIndex]))
          private$TibbleVector[[sourceIndex]] <- self$getRunningList();
        if(grepl("DBSpecList", private$SourceVector[sourceIndex]))
          private$TibbleVector[[sourceIndex]] <- self$getDBSpecList();
      }
    }
  )
)
