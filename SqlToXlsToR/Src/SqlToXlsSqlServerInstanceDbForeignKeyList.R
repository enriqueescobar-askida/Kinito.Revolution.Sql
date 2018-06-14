require("R6");
require("readxl");
require("tibble");
# class
SqlToXlsSqlServerInstanceDbForeignKeyList <- R6Class("SqlToXlsSqlServerInstanceDbForeignKeyList",
  inherit = SqlToXlsSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
    initialize = function(path, serviceInstance, instance, dbName) {
      instance <- paste0(instance, "_", dbName);
      super$initialize(path, serviceInstance, instance);
    },
    getTableNameFrequency = function(){
      
      if(!is.null(private$Tibble) && dim(private$Tibble)[1]!=0 && dim(private$Tibble)[2]!=0){
        return(private$getFrequencyTable(colName = "TableName"));
      } else {
        return(NULL);
      }
    },
    getTableNameFrequencyTibble = function(){
      t <- NULL;
      
      if (!is.null(private$Tibble) && dim(private$Tibble)[1]!=0 && dim(private$Tibble)[2]!=0) {
        t <- data.frame(sort(table(private$Tibble$TableName), decreasing = TRUE));
        
        if(ncol(t) == 1){
          TableName <- row.names(t);
          t <- data.frame(TableName, t, row.names = NULL);
        }
        
        colnames(t) <- c("TableName", "PrincipalKeyCount");
        # t$TriggerGroup <- as.character(t$TriggerGroup);
        # t$TriggerCount <- as.integer(t$TriggerCount);
        t <- tibble::as_tibble(t);
      }
      
      return(t);
    },
    getTableNameFrequencyHistogram = function(){
      histo <- NULL;
      
      if(!is.null(private$Tibble) && dim(private$Tibble)[1]!=0 && dim(private$Tibble)[2]!=0){
        t <- data.frame(sort(table(private$Tibble$TableName), decreasing = TRUE));
        
        if(ncol(t) == 1){
          TableName <- row.names(t);
          t <- data.frame(TableName, t, row.names = NULL);
        }
        
        colnames(t) <- c("TableName", "ForeignKeyCount");
        t <- tibble::as_tibble(t);
        t <- head(t, 50);
        # titles
        xTitle <- colnames(t)[1];
        yTitle <- colnames(t)[2];
        mainTitle <- paste0(private$Instance, " ForeignKey TableName Frequency Histogram");
        colnames(t) <- NULL;
        names(t)[1] <- "X";
        names(t)[2] <- "Y";
        # graph
        histo <- ggplot(t,
                        aes(x = factor(X), y = Y)) +
          geom_bar(stat = "identity", width = 0.8, position = "dodge", fill = "lightblue") +
          xlab(xTitle) +
          ylab(yTitle) +
          ggtitle(mainTitle) +
          theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5));
      }
      
      return(histo);
    }
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_DbForeignKeyList");
    },
    ColumnTitles = function(value) {
     if (missing(value)) return(c("TableName", "ColumnName", "ForeignKey", "ForeignKeyID",
                                  "ReferenceTableName", "ReferenceColumnName", "FKCreated", "FKModified",
                                  "FKnotTrusted", "OnDelete", "OnUpdate", "SYSFK"));

    }
  ),
  private = list(
  )
)
