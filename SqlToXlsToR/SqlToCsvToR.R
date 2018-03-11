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
# R source Csv Sql Server Instance Abstract List
sourceVector[2] <- "SqlToCsvSqlServerInstanceAbstractList.R";
# Sql Server Instance Linked List
sourceVector[3] <- "SqlToCsvSqlServerInstanceLinkedList.R";
# Sql Server Instance Usage List
sourceVector[4] <- "SqlToCsvSqlServerInstanceUsageList.R";
# Sql Server Instance DB Backup List
sourceVector[5] <- "SqlToCsvSqlServerInstanceBackupList.R";
# Sql Server Instance Running List
sourceVector[6] <- "SqlToCsvSqlServerInstanceRunningList.R";
# Sql Server Instance DB Spec List
sourceVector[7] <- "SqlToCsvSqlServerInstanceSpecList.R";
# sourceFile Sql Server
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServer.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);
sqlToCsvSqlServer <- SqlToCsvSqlServer$new(projectPath);
sqlServerVersionVector <- sqlToCsvSqlServer$getVersionVector();
sqlServiceInstance <- sqlToCsvSqlServer$getServiceInstance();
sqlServerInstance <- sqlToCsvSqlServer$getInstance();
sqlServerInstanceUsageFile <- sqlToCsvSqlServer$getUsageFile();
rm(sqlToCsvSqlServer);
gc();
# sourceFile Sql Server Instance Abstract Factory
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServerInstanceFactory.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);
sqlToCsvSqlServerInstanceFactory <-
  SqlToCsvSqlServerInstanceFactory$new(projectSourcePath, sourceVector);
sqlToCsvSqlServerInstanceFactory$setSqlServerInstance(sqlServerInstance);
sqlToCsvSqlServerInstanceFactory$setSqlServiceInstance(sqlServiceInstance);
# sourceFile Sql Server Instance Linked List
sqlServerInstanceLinkedList <- sqlToCsvSqlServerInstanceFactory$getLinkedList();
## sourceFile Sql Server Instance Usage List
sqlServerInstanceUsageList <- sqlToCsvSqlServerInstanceFactory$getUsageList();
sqlToCsvSqlServerInstanceFactory$getUsageListBarplot();
sqlToCsvSqlServerInstanceFactory$getUsageListPiechart();
## sourceFile Sql Server Instance DB Backup List
sqlServerInstanceBackupList <- sqlToCsvSqlServerInstanceFactory$getBackupList();
## sourceFile Sql Server Instance Running List
sqlServerInstanceRunningList <- sqlToCsvSqlServerInstanceFactory$getRunningList();
## sourceFile Sql Server Instance DB Spec List
sqlServerInstanceSpecList <- sqlToCsvSqlServerInstanceFactory$getSpecList();
rm(sqlToCsvSqlServerInstanceFactory);
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
    # DB object source
    projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServerInstanceDbObjectList.R");
    write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
    source(projectSourceFile);
    # DB constraint source
    projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServerInstanceDbConstraintList.R");
    write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
    source(projectSourceFile);
    # DB trigger source
    projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServerInstanceDbTriggerList.R");
    write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
    source(projectSourceFile);
    # DB principal key source
    projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServerInstanceDbPrincipalKeyList.R");
    write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
    source(projectSourceFile);
    # DB foreign key source
    projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServerInstanceDbForeignKeyList.R");
    write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
    source(projectSourceFile);
    # DB list
    dbNameVector <- scan(file = sqlServerInstanceUsageFile, what = character());
    #for (dbName in dbNameVector) {
      dbName <- dbNameVector[1];
      ## DB Object items
      objectTables <- NULL;
      objectViews <- NULL;
      objectFunctions <- NULL;
      objectProcedures <- NULL;
      objectTibble <- NULL;
      objectList <-
        SqlToCsvSqlServerInstanceDbObjectList$new(projectPath,sqlServiceInstance,sqlServerInstance,dbName);
      ## DB object actions
      objectList$getFile();
      objectList$fileToTibble();
      objectTibble <- objectList$getTibble();
      if(objectList$HasTables) objectTables <- objectList$getTables();
      if(objectList$HasViews) objectViews <- objectList$getViews();
      if(objectList$HasFunctions) objectFunctions <- objectList$getFunctions();
      if(objectList$HasProcedures) objectProcedures <- objectList$getProcedures();
      objectList$getBarplotGgplot2();
      objectList$getTablesBarplot();
      objectList$getFunctionsBarplot();
      objectList$getProceduresBarplot();
      objectList$getPiechartGgplot2();
      objectList$getTablesPiechart();
      objectList$getFunctionsPiechart();
      objectList$getProceduresPiechart();
      rm(objectList);
      ## DB Constraint items
      constraintTibble <- NULL;
      constraintList <-
        SqlToCsvSqlServerInstanceDbConstraintList$new(projectPath,sqlServiceInstance,sqlServerInstance,dbName);
      ## DB Constraint actions
      constraintList$getFile();
      constraintList$fileToTibble();
      constraintTibble <- constraintList$getTibble();
      rm(constraintList);
      ## DB trigger items
      triggerTibble <- NULL;
      triggerList <-
        SqlToCsvSqlServerInstanceDbTriggerList$new(projectPath,sqlServiceInstance,sqlServerInstance,dbName);
      ## DB trigger actions
      triggerList$getFile();
      triggerList$fileToTibble();
      triggerTibble <- triggerList$getTibble();
      rm(triggerList);
      ## DB principal key items
      principalKeyTibble <- NULL;
      principalKeyList <-
        SqlToCsvSqlServerInstanceDbPrincipalKeyList$new(projectPath,sqlServiceInstance,sqlServerInstance,dbName);
      ## DB principal key actions
      principalKeyList$getFile();
      principalKeyList$fileToTibble();
      principalKeyTibble <- principalKeyList$getTibble();
      rm(principalKeyList);
      ## DB foreign key items
      foreignKeyTibble <- NULL;
      foreignKeyList <-
        SqlToCsvSqlServerInstanceDbForeignKeyList$new(projectPath,sqlServiceInstance,sqlServerInstance,dbName);
      ## DB foreign key actions
      foreignKeyList$getFile();
      foreignKeyList$fileToTibble();
      foreignKeyTibble <- foreignKeyList$getTibble();
      rm(foreignKeyList);
    #}
    
      rm(objectTibble);
      rm(objectTables);
      rm(objectViews);
      rm(objectFunctions);
      rm(objectProcedures);
      rm(constraintTibble);
      rm(triggerTibble);
      rm(principalKeyTibble);
      rm(foreignKeyTibble);
      rm(dbName);
      rm(dbNameVector);
  }
}

rm(sqlServerInstanceUsageFile);
rm(sqlServiceInstance);
rm(sqlServerInstance);
rm(sqlServerVersionVector);

