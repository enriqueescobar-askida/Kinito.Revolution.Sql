# sourcePath
projectSourcePath <- paste0(projectPath, "/Src");
write(paste0(c("sourcePath ...\t", projectSourcePath), sep = "", collapse = ""), stdout());
# sql server info
sqlServiceInstance <- "";
sqlServerInstance <- "";
sqlServerVersionVector <- vector(mode = "character");
sourceVector <- vector(mode = "character", length = 6);
sqlServerInstanceLinkedList <- tibble::as_tibble(data.frame(NULL));
sqlServerInstanceUsageList <- tibble::as_tibble(data.frame(NULL));
sqlServerInstanceDBBackupList <- tibble::as_tibble(data.frame(NULL));
sqlServerInstanceRunningList <- tibble::as_tibble(data.frame(NULL));
sqlServerInstanceDBSpecList <- tibble::as_tibble(data.frame(NULL));
# sourceFile Sql Server
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServer.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);
sqlToCsvSqlServer <- SqlToCsvSqlServer$new(projectPath);
sqlServerVersionVector <- sqlToCsvSqlServer$getVersionVector();
sqlServiceInstance <- sqlToCsvSqlServer$getServiceInstance();
sqlServerInstance <- sqlToCsvSqlServer$getInstance();
rm(sqlToCsvSqlServer);
gc();
# R source files
# R source files Sql Server Instance Abstract List
sourceVector[1] <- "SqlToCsvSqlServerInstanceAbstractList.R";
# Sql Server Instance Linked List
sourceVector[2] <- "SqlToCsvSqlServerInstanceLinkedList.R";
# Sql Server Instance Usage List
sourceVector[3] <- "SqlToCsvSqlServerInstanceUsageList.R";
# Sql Server Instance DB Backup List
sourceVector[4] <- "SqlToCsvSqlServerInstanceDBBackupList.R";
# Sql Server Instance Running List
sourceVector[5] <- "SqlToCsvSqlServerInstanceRunningList.R";
# Sql Server Instance DB Spec List
sourceVector[6] <- "SqlToCsvSqlServerInstanceDBSpecList.R";
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
## sourceFile Sql Server Instance DB Backup List
sqlServerInstanceDBBackupList <- sqlToCsvSqlServerInstanceFactory$getDBBackupList();
## sourceFile Sql Server Instance Running List
sqlServerInstanceRunningList <- sqlToCsvSqlServerInstanceFactory$getRunningList();
## sourceFile Sql Server Instance DB Spec List
sqlServerInstanceDBSpecList <- sqlToCsvSqlServerInstanceFactory$getDBSpecList();
rm(sqlToCsvSqlServerInstanceFactory);
gc();
##
rm(sourceVector);
rm(sqlServiceInstance);
rm(sqlServerInstance);
rm(sqlServerVersionVector);
rm(sqlServerInstanceLinkedList);
rm(sqlServerInstanceUsageList);
rm(sqlServerInstanceDBBackupList);
rm(sqlServerInstanceRunningList);
rm(sqlServerInstanceDBSpecList);
gc();

