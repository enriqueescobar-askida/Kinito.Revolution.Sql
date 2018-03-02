require("R6");
require("readxl");
require("tibble");
require("ggplot2");
require("gridExtra");
# class
SqlToXlsSqlServerInstanceUsageList <- R6Class("SqlToXlsSqlServerInstanceUsageList",
  inherit = SqlToXlsSqlServerInstanceAbstractList,
  portable = TRUE,
  class = TRUE,
  cloneable = TRUE,
  public = list(
    getPiechartGgplot2 = function(){
      if (is.null(private$Tibble)) {
        
        return(NULL);
      } else {
        PercentList <- round(private$Tibble$DBBufferMB / sum(private$Tibble$DBBufferMB) * 100, digits = 2);
        labelList <- paste0(private$Tibble$DBName," ",PercentList, "%");
        ColorList <- heat.colors(length(PercentList));
        # titles
        xTitle <- colnames(private$Tibble)[2];
        yTitle <- colnames(rev(private$Tibble)[1]);
        mainTitle <- "Usage List Piechart";
        # graph
        piechart <- ggplot(private$Tibble,
                           aes(x = factor(1), y = PercentList, fill = labelList)) +
          # make stacked bar chart with black border
          geom_bar(stat = "identity",
                   color = "grey80",
                   width = 1) +
          # add the percents to the interior of the chart
          #geom_text(aes(x = 1.5, y = PercentList, label = labelList), size = 4) +
          ggtitle(mainTitle) +
          xlab(xTitle) +
          ylab(yTitle) +
          coord_polar(theta = "y");
        
        return(piechart);
      }
    },
    getBarplotGgplot2 = function(){
      if (is.null(private$Tibble)) {
        
        return(NULL);
      } else {
        # titles
        xTitle <- colnames(private$Tibble)[2];
        yTitle <- colnames(rev(private$Tibble)[1]);
        mainTitle <- "Usage List count";
        # graph
        barplot <- ggplot(private$Tibble,
                          aes(x = factor(DBName), y = DBBufferMB)) +
          geom_bar(stat = "identity",
                   width = 0.8,
                   position = "dodge",
                   fill = "lightblue") +
          xlab(xTitle) +
          ylab(yTitle) +
          ggtitle(mainTitle) +
          theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5));
        
        return(barplot);
      }
    }
  ),
  active = list(
    Tail = function(value) {
      if (missing(value)) return("_UsageList");
    },
    ColumnTitles = function(value) {
     if (missing(value)) return(c("DBIdentifier", "DBName", "DBBufferPages", "DBBufferMB"));
    }
  ),
  private = list(
  )
)
