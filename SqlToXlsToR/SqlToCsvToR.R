# sourcePath
projectSourcePath <- paste0(projectPath, "/Src");
write(paste0(c("sourcePath ...\t", projectSourcePath), sep = "", collapse = ""), stdout());
# sql server info
sqlServiceInstance <- "";
sqlServerInstance <- "";
sqlServerInstanceUsageFile <- paste0(projectPath, "/../Csv/SqlServer-Instance_");
sqlServerVersionVector <- vector(mode = "character");
sourceVector <- vector(mode = "character", length = 6);
sqlServerInstanceLinkedList <- tibble::as_tibble(data.frame(NULL));
sqlServerInstanceUsageList <- tibble::as_tibble(data.frame(NULL));
sqlServerInstanceBackupList <- tibble::as_tibble(data.frame(NULL));
sqlServerInstanceRunningList <- tibble::as_tibble(data.frame(NULL));
sqlServerInstanceSpecList <- tibble::as_tibble(data.frame(NULL));
# sourceFile Sql Server
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServer.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);
sqlToCsvSqlServer <- SqlToCsvSqlServer$new(projectPath);
sqlServerVersionVector <- sqlToCsvSqlServer$getVersionVector();
sqlServiceInstance <- sqlToCsvSqlServer$getServiceInstance();
sqlServerInstanceUsageFile <- paste0(sqlServerInstanceUsageFile,sqlServiceInstance,"_");
sqlServerInstance <- sqlToCsvSqlServer$getInstance();
sqlServerInstanceUsageFile <- paste0(sqlServerInstanceUsageFile,sqlServerInstance,"_UsageList.txt");
rm(sqlToCsvSqlServer);
gc();
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
# load
for (sourceIndex in seq_along(sourceVector)) {
  projectSourceFile <- paste0(projectSourcePath, "/", sourceVector[sourceIndex]);
  write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
  source(projectSourceFile);
}
rm(sourceIndex);
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
gc();
##
rm(sourceVector);
# rm(sqlServiceInstance);
# rm(sqlServerInstance);
# rm(sqlServerVersionVector);
# rm(sqlServerInstanceLinkedList);
# rm(sqlServerInstanceUsageList);
# rm(sqlServerInstanceBackupList);
# rm(sqlServerInstanceRunningList);
# rm(sqlServerInstanceSpecList);
gc();
dbNameVector <- vector(mode = "character");
dbNameVector <- scan(file = sqlServerInstanceUsageFile, what = character());
# dbNameVector[1] <- sqlServerInstanceUsageList[[2]][[4]];
# dbNameVector[2] <- sqlServerInstanceUsageList[[2]][[8]];
# dbNameVector[3] <- sqlServerInstanceUsageList[[2]][[12]];
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServerInstanceDbObjectList.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);

#for (dbName in dbNameVector) {
dbName <- dbNameVector[3];
  objectList <-
    SqlToCsvSqlServerInstanceDbObjectList$new(projectPath,sqlServiceInstance,sqlServerInstance,dbName);
  objectList$getFile();
  objectList$fileToTibble();
  objectList$getTibble();
  objectList$getBarplotGgplot2();
  objectList$getPiechartGgplot2();
#}


