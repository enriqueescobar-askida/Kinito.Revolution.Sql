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
    HasRowRepeats = FALSE,
    initialize = function(path, serviceInstance, instance, dbName) {
      instance <- paste0(instance, "_", dbName);
      super$initialize(path, serviceInstance, instance);
    },
    fileToTibble = function() {
      super$fileToTibble();
      return(private$fixTibble());
    },
    getBarplotGgplot2 = function(){
      t <- self$getTriggerGroupFrequencyTibble();
      barplot <- NULL;
      
      if(!is.null(t) && dim(t)[1]!=0 && dim(t)[2]!=0){
        # titles
        xTitle <- colnames(t)[1];
        yTitle <- colnames(t)[2];
        mainTitle <- paste0(private$Instance, " TriggerGroup Barplot");
        colnames(t) <- NULL;
        names(t)[1] <- "X";
        names(t)[2] <- "Y";
        # calculations
        PercentList <- round(t$Y / sum(t$Y) * 100);
        TypeList <- paste0(t$X," ",PercentList, "%");
        ColorList <- heat.colors(length(TypeList));
        # graph
        barplot <- ggplot(t,
                           aes(x = "", y = Y, fill = TypeList)) +
          labs(fill = xTitle) +
          geom_bar(width = 1, stat = "identity") +
          ggtitle(mainTitle) +
          xlab(xTitle) +
          ylab(yTitle);
      }
      return(barplot);
    },
    getPiechartGgplot2 = function(){
      t <- self$getTriggerGroupFrequencyTibble();
      piechart <- NULL;
      
      if(!is.null(t) && dim(t)[1]!=0 && dim(t)[2]!=0){
        # titles
        xTitle <- colnames(t)[1];
        yTitle <- colnames(t)[2];
        mainTitle <- paste0(private$Instance, " TriggerGroup Piechart");
        colnames(t) <- NULL;
        names(t)[1] <- "X";
        names(t)[2] <- "Y";
        # calculations
        PercentList <- round(t$Y / sum(t$Y) * 100);
        TypeList <- paste0(t$X," ",PercentList, "%");
        ColorList <- heat.colors(length(TypeList));
        # graph
        piechart <- ggplot(t,
                            aes(x = factor(1), y = PercentList, fill = TypeList)) +
          # make stacked bar chart with black border
          geom_bar(stat = "identity", color = "grey80", width = 1) +
          # add the percents to the interior of the chart
          #geom_text(aes(x = 1.5, y = PercentList, label = FunctionTypes), size = 4) +
          ggtitle(mainTitle) +
          xlab(xTitle) +
          ylab(yTitle) +
          coord_polar(theta = "y");
      }
      
      return(piechart);
    },
    getTriggerGroupFrequency = function(){
      
      if(!is.null(private$Tibble) && dim(private$Tibble)[1]!=0 && dim(private$Tibble)[2]!=0){
        return(private$getFrequencyTable(colName = "TriggerGroup"));
      } else {
        return(NULL);
      }
    },
    getTriggerSubgroupFrequency = function(){
      
      if(!is.null(private$Tibble) && dim(private$Tibble)[1]!=0 && dim(private$Tibble)[2]!=0){
        return(private$getFrequencyTable(colName = "TriggerSubgroup"));
      } else {
        return(NULL);
      }
    },
    getTriggerGroupFrequencyTibble = function(){
      t <- NULL;

      if (!is.null(private$Tibble) && dim(private$Tibble)[1]!=0 && dim(private$Tibble)[2]!=0) {
        t <- data.frame(sort(table(private$Tibble$TriggerGroup), decreasing = TRUE));

        if(ncol(t) == 1){
          TriggerGroup <- row.names(t);
          t <- data.frame(TriggerGroup, t, row.names = NULL);
        }

        colnames(t) <- c("TriggerGroup", "TriggerCount");
        t <- tibble::as_tibble(t);
        t$TriggerGroup <- as.character(t$TriggerGroup);
        if(dim(t)[1]==1){
          if("AfterTrigger" %in% t$TriggerGroup){
            t <- rbind(t, c("InsteadOfTrigger",0));
          } else {
            t <- rbind(t, c("AfterTrigger",0));
          }
        }
        t$TriggerCount <- as.integer(t$TriggerCount);
      }
      
      return(t);
    },
    getTriggerSubgroupFrequencyTibble = function(){
      t <- NULL;
      
      if (!is.null(private$Tibble) && dim(private$Tibble)[1]!=0 && dim(private$Tibble)[2]!=0) {
        t <- data.frame(sort(table(private$Tibble$TriggerSubgroup), decreasing = TRUE));
        
        if(ncol(t) == 1){
          TriggerSubgroup <- row.names(t);
          t <- data.frame(TriggerSubgroup, t, row.names = NULL);
        }
        
        colnames(t) <- c("TriggerSubgroup", "TriggerCount");
        t <- tibble::as_tibble(t);
        t$TriggerCount <- as.integer(t$TriggerCount);
      }
      
      return(t);
    },
    getTriggerGroupFrequencyHistogram = function(){
      histo <- NULL;
      
      if(!is.null(private$Tibble) && dim(private$Tibble)[1]!=0 && dim(private$Tibble)[2]!=0){
        t <- data.frame(sort(table(private$Tibble$TableName), decreasing = TRUE));
        
        if(ncol(t) == 1){
          TableName <- row.names(t);
          t <- data.frame(TableName, t, row.names = NULL);
        }
        
        colnames(t) <- c("TableName", "TriggerCount");
        t <- tibble::as_tibble(t);
        t <- head(t, 50);
        # titles
        xTitle <- colnames(t)[1];
        yTitle <- colnames(t)[2];
        mainTitle <- paste0(private$Instance, " Trigger TableName Frequency Histogram");
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
