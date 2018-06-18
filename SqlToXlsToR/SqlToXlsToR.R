# sourcePath
projectSourcePath <- paste0(projectPath, "/Src");
write(paste0(c("sourcePath ...\t", projectSourcePath), sep = "", collapse = ""), stdout());
# sql server info
sqlServiceInstance <- "";
sqlServerInstance <- "";
sqlServerInstanceUsageFile <- "";
sqlServerVersionVector <- vector(mode = "character");
sourceVector <- vector(mode = "character", length = 6);
sqlServerInstanceLinkedList <- tibble::as_tibble(data.frame(NULL));
sqlServerInstanceUsageList <- tibble::as_tibble(data.frame(NULL));
sqlServerInstanceBackupList <- tibble::as_tibble(data.frame(NULL));
sqlServerInstanceRunningList <- tibble::as_tibble(data.frame(NULL));
sqlServerInstanceSpecList <- tibble::as_tibble(data.frame(NULL));
# R source files
# R source files Sql Server Instance Abstract List
sourceVector[1] <- "SqlToFileSqlServerInstanceAbstractList.R";
# R source Xls Sql Server Instance Abstract List
sourceVector[2] <- "SqlToXlsSqlServerInstanceAbstractList.R";
# Sql Server Instance Linked List
sourceVector[3] <- "SqlToXlsSqlServerInstanceLinkedList.R";
# Sql Server Instance Usage List
sourceVector[4] <- "SqlToXlsSqlServerInstanceUsageList.R";
# Sql Server Instance DB Backup List
sourceVector[5] <- "SqlToXlsSqlServerInstanceBackupList.R";
# Sql Server Instance Running List
sourceVector[6] <- "SqlToXlsSqlServerInstanceRunningList.R";
# Sql Server Instance DB Spec List
sourceVector[7] <- "SqlToXlsSqlServerInstanceSpecList.R";
# sourceFile Sql Server
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToXlsSqlServer.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);
sqlToXlsSqlServer <- SqlToXlsSqlServer$new(projectPath);
sqlServerVersionVector <- sqlToXlsSqlServer$getVersionVector();
sqlServiceInstance <- sqlToXlsSqlServer$getServiceInstance();
sqlServerInstance <- sqlToXlsSqlServer$getInstance();
sqlServerInstanceUsageFile <- sqlToXlsSqlServer$getUsageFile();
rm(sqlToXlsSqlServer);
gc();
# sourceFile Sql Server Instance Abstract Factory
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToXlsSqlServerInstanceFactory.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);
sqlToXlsSqlServerInstanceFactory <-
  SqlToXlsSqlServerInstanceFactory$new(projectSourcePath, sourceVector);
sqlToXlsSqlServerInstanceFactory$setSqlServerInstance(sqlServerInstance);
sqlToXlsSqlServerInstanceFactory$setSqlServiceInstance(sqlServiceInstance);
# sourceFile Sql Server Instance Linked List
sqlServerInstanceLinkedList <- sqlToXlsSqlServerInstanceFactory$getLinkedList();
## sourceFile Sql Server Instance Usage List
sqlServerInstanceUsageList <- sqlToXlsSqlServerInstanceFactory$getUsageList();
sqlToXlsSqlServerInstanceFactory$getUsageListBarplot();
sqlToXlsSqlServerInstanceFactory$getUsageListPiechart();
## sourceFile Sql Server Instance DB Backup List
sqlServerInstanceBackupList <- sqlToXlsSqlServerInstanceFactory$getBackupList();
## sourceFile Sql Server Instance Running List
sqlServerInstanceRunningList <- sqlToXlsSqlServerInstanceFactory$getRunningList();
## sourceFile Sql Server Instance DB Spec List
sqlServerInstanceSpecList <- sqlToXlsSqlServerInstanceFactory$getSpecList();
rm(sqlToXlsSqlServerInstanceFactory);
rm(sqlServerInstanceLinkedList);
rm(sqlServerInstanceUsageList);
rm(sqlServerInstanceBackupList);
rm(sqlServerInstanceRunningList);
rm(sqlServerInstanceSpecList);
rm(sourceVector);
gc();
# Screen DB list
if (file.exists(sqlServerInstanceUsageFile)) {
  if (file.info(sqlServerInstanceUsageFile)$size > 0) {
    # DB Object source
    projectSourceFile <- paste0(projectSourcePath, "/", "SqlToXlsSqlServerInstanceDbObjectList.R");
    write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
    source(projectSourceFile);
    # DB Constraint source
    projectSourceFile <- paste0(projectSourcePath, "/", "SqlToXlsSqlServerInstanceDbConstraintList.R");
    write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
    source(projectSourceFile);
    # DB Trigger source
    projectSourceFile <- paste0(projectSourcePath, "/", "SqlToXlsSqlServerInstanceDbTriggerList.R");
    write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
    source(projectSourceFile);
    # DB Principal key source
    projectSourceFile <- paste0(projectSourcePath, "/", "SqlToXlsSqlServerInstanceDbPrincipalKeyList.R");
    write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
    source(projectSourceFile);
    # DB Foreign key source
    projectSourceFile <- paste0(projectSourcePath, "/", "SqlToXlsSqlServerInstanceDbForeignKeyList.R");
    write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
    source(projectSourceFile);
    # DB Index source
    projectSourceFile <- paste0(projectSourcePath, "/", "SqlToXlsSqlServerInstanceDbIndexList.R");
    write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
    source(projectSourceFile);
    # DB list
    dbNameVector <- scan(file = sqlServerInstanceUsageFile, what = character());
    for (dbName in dbNameVector) {
      write(paste0(c("dbName dbfile ...\t", dbName), sep = "", collapse = ""), stdout());
      ## DB Object items
      objectTables <- NULL;
      objectViews <- NULL;
      objectFunctions <- NULL;
      objectProcedures <- NULL;
      objectTibble <- NULL;
      objectList <-
        SqlToXlsSqlServerInstanceDbObjectList$new(
          projectPath,sqlServiceInstance,sqlServerInstance,dbName);
      ## DB Object actions
      objectList$getFile();
      objectList$fileToTibble();
      objectTibble <- objectList$getTibble();
      objectList$getBarplotGgplot2();
      objectList$getPiechartGgplot2();
      
      ## DB Object Tables
      if(objectList$HasTables) {
      ### DB Object Table source
      ### DB Object Table items
      ### DB Object Table actions
      }
      
      ## DB Object Views
      if(objectList$HasViews) {
      ###
      ###
      ###
      }
      
      ## DB Object Functions
      if(objectList$HasFunctions) {
      ###
      ###
      ###
      }
      
      ## DB Object Procedures
      if(objectList$HasProcedures) {
      ###
      ###
      ###
      }
      
    }
  }
}

# for (sourceIndex in seq_along(sourceVector)) {
#   projectSourceFile <- paste0(projectSourcePath, "/", sourceVector[sourceIndex]);
#   write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
#   source(projectSourceFile);
# }

rm(sqlServerInstanceUsageFile);
rm(sqlServiceInstance);
rm(sqlServerInstance);
rm(sqlServerVersionVector);

