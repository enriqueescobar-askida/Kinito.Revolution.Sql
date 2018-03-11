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
    HasViews = FALSE,
    HasTables = FALSE,
    HasFunctions = FALSE,
    HasProcedures = FALSE,
    initialize = function(path, serviceInstance, instance, dbName) {
      instance <- paste0(instance, "_", dbName);
      super$initialize(path, serviceInstance, instance);
    },
    fileToTibble = function() {
      super$fileToTibble();
      return(private$fixTibble());
    },
    getPiechartGgplot2 = function(aTibble = NULL){
      piechart <- NULL;
      if (missing(aTibble)) aTibble <- private$Tibble;
      if (!is.null(aTibble) & (ncol(aTibble) == 2)) {
        # titles
        xTitle <- colnames(aTibble)[1];
        yTitle <- colnames(aTibble)[2];
        mainTitle <- paste0("Object", " PieChart");
        # lists
        PercentList <- round(aTibble$ObjectCount / sum(aTibble$ObjectCount) * 100, digits = 2);
        labelList <- paste0(aTibble$ObjectName, " ", PercentList, "%");
        labelName <- paste0(xTitle, " list");
        ColorList <- heat.colors(length(PercentList));
        # graph
        piechart <- ggplot(aTibble,
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
          labs(fill = labelName) +
          coord_polar(theta = "y");
      }
      
      return(piechart);
    },
    getBarplotGgplot2 = function(aTibble = NULL){
      barplot <- NULL;
      if (missing(aTibble)) aTibble <- private$Tibble;
      if (!is.null(aTibble) & (ncol(aTibble) == 2)) {
        # titles
        xTitle <- colnames(aTibble)[1];
        yTitle <- colnames(aTibble)[-1];
        mainTitle <- "ObjectList count";
        # graph
        barplot <- ggplot(aTibble,
                          aes(x = factor(ObjectName), y = ObjectCount)) +
          geom_bar(stat = "identity",
                   width = 0.8,
                   position = "dodge",
                   fill = "lightblue") +
          ggtitle(mainTitle) +
          xlab(xTitle) +
          ylab(yTitle) +
          theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5));
      }
      
      return(barplot);
    },
    getTables = function(){
      return(private$TableTibble);
    },
    getViews = function(){
      return(private$ViewTibble);
    },
    getFunctions = function(){
      return(private$FunctionTibble);
    },
    getProcedures = function(){
      return(private$ProcedureTibble);
    },
    getTablesBarplot = function(){
      return(self$getBarplotGgplot2(private$TableTibble));
    },
    getFunctionsBarplot = function(){
      return(self$getBarplotGgplot2(private$FunctionTibble));
    },
    getProceduresBarplot = function(){
      return(self$getBarplotGgplot2(private$ProcedureTibble));
    },
    getTablesPiechart = function(){
      return(self$getPiechartGgplot2(private$TableTibble));
    },
    getFunctionsPiechart = function(){
      return(self$getPiechartGgplot2(private$FunctionTibble));
    },
    getProceduresPiechart = function(){
      return(self$getPiechartGgplot2(private$ProcedureTibble));
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
    TableTibble = NULL,
    ViewTibble = NULL,
    FunctionTibble = NULL,
    ProcedureTibble = NULL,
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
      self$HasTables <- private$findInTibble("Tables");
      if(self$HasTables) private$TableTibble <- private$getInTibble("Tables");
      self$HasViews <- private$findInTibble("Views");
      if(self$HasViews) private$ViewTibble <- private$getInTibble("Views");
      self$HasFunctions <- private$findInTibble("Function-");
      if(self$HasFunctions) private$FunctionTibble <- private$getInTibble("Function-");
      self$HasProcedures <- private$findInTibble("Procedures");
      if(self$HasProcedures) private$ProcedureTibble <- private$getInTibble("Procedures");
      
      rm(objNameCol);rm(objCountCol);rm(objName);rm(itExist);rm(df);
    },
    findInTibble = function(str = ""){
      isFound <- FALSE;
      matches <- private$Tibble[grep(str, private$Tibble$ObjectName),][[2]];
      
      for(m in matches) isFound <- isFound || m!=0;
      
      return(isFound);
    },
    getInTibble = function(str = ""){
      
      return(private$Tibble[grep(str, private$Tibble$ObjectName),]);
    }
  )
)
