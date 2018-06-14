require("R6");
require("readxl");
require("tibble");
# class
SqlToXlsSqlServerInstanceDbConstraintList <- R6Class("SqlToXlsSqlServerInstanceDbConstraintList",
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
        
        colnames(t) <- c("TableName", "ConstraintCount");
        t <- tibble::as_tibble(t);
      }
      
      return(t);
    },
    getTableNameFrequencyHistogram = function(){
      barplot <- NULL;
      mainTitle <- paste0(private$Instance, " Constraint TableName Frequency Histogram");
      t <- self$getTableNameFrequencyTibble();
      
      if (is.null(t)) {
        
        return(NULL);
      } else {
        t <- head(t, 50);
        # titles
        xTitle <- colnames(t)[1];
        yTitle <- colnames(t)[2];
        colnames(t) <- NULL;
        names(t)[1] <- "X";
        names(t)[2] <- "Y";
        # graph
        barplot <- ggplot(t,
                          aes(x = factor(X), y = Y)) +
          geom_bar(stat = "identity", width = 0.8, position = "dodge", fill = "lightblue") +
          xlab(xTitle) +
          ylab(yTitle) +
          ggtitle(mainTitle) +
          theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5));
        
        return(barplot);
      }
      
      return(barplot);
    }
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_DbConstraintList");
    },
    ColumnTitles = function(value) {
     if (missing(value)) return(c("DBName", "TableName", "ColumnNumber", "ColumnName", "ConstraintName",
                                  "ConstraintType", "ConstraintDescription", "CreatedDate", "ConstraintDefinition", "name",
                                  "object_id", "principal_id", "schema_id", "parent_object_id", "type",
                                  "type_desc", "create_date", "modify_date", "is_ms_shipped", "is_published",
                                  "is_schema_published", "is_disabled", "is_not_for_replication", "is_not_trusted", "parent_column_id",
                                  "definition", "uses_database_collation", "is_system_named"));

    }
  ),
  private = list(
  )
)
