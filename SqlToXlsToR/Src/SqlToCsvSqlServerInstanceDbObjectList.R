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
    getPiechartGgplot2 = function(){
      aPierchart <- NULL;
      if (!is.null(private$Tibble) & (ncol(private$Tibble) == 2)) {
        # titles
        xTitle <- colnames(private$Tibble)[1];
        names(private$Tibble)[1] <- "X";
        yTitle <- colnames(private$Tibble)[2];
        names(private$Tibble)[2] <- "Y";
        mainTitle <- paste0("mainTitle", " PieChart");#
        # lists
        PercentList <- round(private$Tibble$Y / sum(private$Tibble$Y) * 100, digits = 2);
        labelList <- paste0(private$Tibble$X, " ", PercentList, "%");
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
  )
)
