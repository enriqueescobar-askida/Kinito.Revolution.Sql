require("R6");
require("readr");
require("tibble");
# class
SqlToCsvSqlServerInstanceDbObjectList <- R6Class("SqlToCsvSqlServerInstanceDbObjectList",
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
    },
    getPiechartGgplot2 = function(){
      aPierchart <- NULL;
      if (!is.null(private$Tibble) & (ncol(private$Tibble) == 2)) {
        # titles
        xTitle <- colnames(private$Tibble)[1];
        yTitle <- colnames(private$Tibble)[2];
        mainTitle <- paste0("Object", " PieChart");
        # lists
        PercentList <- round(private$Tibble$ObjectCount / sum(private$Tibble$ObjectCount) * 100, digits = 2);
        labelList <- paste0(private$Tibble$ObjectName, " ", PercentList, "%");
        labelName <- paste0(xTitle, " list");
        ColorList <- heat.colors(length(PercentList));
        # graph
        aPierchart <- ggplot(private$Tibble,
                             aes(x = factor(1), y = PercentList, fill = labelList)) +
          # make stacked bar chart with black border
          geom_bar(stat = "identity",
                   color = "grey80",
                   width = 1) +
          #geom_text(aes(x = 1.5, y = PercentList, label = labelList), size = 4) +
          ggtitle(mainTitle) +
          xlab(xTitle) +
          ylab(yTitle) +
          labs(fill = labelName) +
          coord_polar(theta = "y");
      }
      
      return(aPierchart);
    },
    getBarplotGgplot2 = function(){
      if (is.null(private$Tibble)) {
        
        return(NULL);
      }else{
        # titles
        xTitle <- colnames(private$Tibble)[1];
        yTitle <- colnames(private$Tibble)[-1];
        mainTitle <- "ObjectList count";
        # graph
        barplot <- ggplot(private$Tibble,
                          aes(x = factor(ObjectName), y = ObjectCount)) +
          geom_bar(stat = "identity",
                   width = 0.8,
                   position = "dodge",
                   fill = "lightblue") +
          ggtitle(mainTitle) +
          xlab(xTitle) +
          ylab(yTitle);
        
        return(barplot);
      }
    }
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_DbObjectList");
    },
    ColumnTitles = function(value) {
      if (missing(value)) return(c("ObjectName", "ObjectCount"));
    }
  ),
  private = list(
    fixTibble = function() {
      objNameCol <-
        c("Function-InlineTabValued","Function-Scalar","Function-TabValued",
          "Internal Tables","System Tables","User Defined Tables",
          "Stored Procedures","CLR Stored Procedures","Extended Stored Procedures",
          "Views");
      objCountCol = c(0,0,0,
                      0,0,0,
                      0,0,0,
                      0);
      df <- tibble(as.character(objNameCol), as.integer(objCountCol));
      colnames(df) <- self$ColumnTitles;
      
      for(i in 1:nrow(df)){
        objName <- df[i,]$ObjectName;
        itExist <- objName %in% private$Tibble$ObjectName;
        if(itExist) df[i,]$ObjectCount <- private$Tibble$ObjectCount[private$Tibble$ObjectName==objName];
      }
      private$Tibble <- tibble::as_tibble(df);
      rm(objNameCol);rm(objCountCol);rm(objName);rm(itExist);rm(df);
    }
  )
)
