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
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToXlsSqlServer.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);
sqlToXlsSqlServer <- SqlToXlsSqlServer$new(projectPath);
sqlServerVersionVector <- sqlToXlsSqlServer$getVersionVector();
sqlServiceInstance <- sqlToXlsSqlServer$getServiceInstance();
sqlServerInstance <- sqlToXlsSqlServer$getInstance();
rm(sqlToXlsSqlServer);
gc();
# R source files
# R source files Sql Server Instance Abstract List
sourceVector[1] <- "SqlToXlsSqlServerInstanceAbstractList.R";
# # Sql Server Instance Linked List
# sourceVector[2] <- "SqlToXlsSqlServerInstanceLinkedList.R";
# # Sql Server Instance Usage List
# sourceVector[3] <- "SqlToXlsSqlServerInstanceUsageList.R";
# # Sql Server Instance DB Backup List
# sourceVector[4] <- "SqlToXlsSqlServerInstanceDBBackupList.R";
# # Sql Server Instance Running List
# sourceVector[5] <- "SqlToXlsSqlServerInstanceRunningList.R";
# # Sql Server Instance DB Spec List
# sourceVector[6] <- "SqlToXlsSqlServerInstanceDBSpecList.R";
# # load
for (sourceIndex in seq_along(sourceVector)) {
  projectSourceFile <- paste0(projectSourcePath, "/", sourceVector[sourceIndex]);
  write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
  source(projectSourceFile);
}
rm(sourceIndex);
# sourceFile Sql Server Instance Abstract Factory
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToXlsSqlServerInstanceFactory.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);
sqlToXlsSqlServerInstanceFactory <-
  SqlToXlsSqlServerInstanceFactory$new(projectSourcePath, sourceVector);
sqlToXlsSqlServerInstanceFactory$setSqlServerInstance(sqlServerInstance);
sqlToXlsSqlServerInstanceFactory$setSqlServiceInstance(sqlServiceInstance);
# # sourceFile Sql Server Instance Linked List
# sqlServerInstanceLinkedList <-sqlToXlsSqlServerInstanceFactory$getLinkedList();
# ## sourceFile Sql Server Instance Usage List
# sqlServerInstanceUsageList <- sqlToXlsSqlServerInstanceFactory$getUsageList();
# ## sourceFile Sql Server Instance DB Backup List
# sqlServerInstanceDBBackupList <- sqlToXlsSqlServerInstanceFactory$getDBBackupList();
# ## sourceFile Sql Server Instance Running List
# sqlServerInstanceRunningList <- sqlToXlsSqlServerInstanceFactory$getRunningList();
# ## sourceFile Sql Server Instance DB Spec List
# sqlServerInstanceDBSpecList <- sqlToXlsSqlServerInstanceFactory$getDBSpecList();
rm(sqlToXlsSqlServerInstanceFactory);
gc();
# ##
rm(sourceVector);
rm(sqlServiceInstance);
rm(sqlServerInstance);
rm(sqlServerVersionVector);
# rm(sqlServerInstanceLinkedList);
# rm(sqlServerInstanceUsageList);
# rm(sqlServerInstanceDBBackupList);
# rm(sqlServerInstanceRunningList);
# rm(sqlServerInstanceDBSpecList);
# gc();

