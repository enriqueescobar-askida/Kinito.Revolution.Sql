# sourcePath
projectSourcePath <- paste0(projectPath, "/Src");
write(paste0(c("sourcePath ...\t", projectSourcePath), sep = "", collapse = ""), stdout());
# sql server info
sqlServiceInstance <- "";
sqlServerInstance <- "";
sqlServerVersionVector <- vector(mode = "character");
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
# sourceFile Sql Server Instance
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServerInstanceAbstractList.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);
## sourceFile Sql Server Instance Linked List
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServerInstanceLinkedList.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);
sqlToCsvSqlServerInstanceLinkedList <-
  SqlToCsvSqlServerInstanceLinkedList$new(projectPath, sqlServiceInstance, sqlServerInstance);
sqlToCsvSqlServerInstanceLinkedList$fileToTibble();
sqlServerInstanceLinkedList <- sqlToCsvSqlServerInstanceLinkedList$getTibble();
rm(sqlToCsvSqlServerInstanceLinkedList);
gc();
## sourceFile Sql Server Instance Usage List
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServerInstanceUsageList.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);
sqlToCsvSqlServerInstanceUsageList <-
  SqlToCsvSqlServerInstanceUsageList$new(projectPath, sqlServiceInstance, sqlServerInstance);
sqlToCsvSqlServerInstanceUsageList$fileToTibble();
sqlServerInstanceUsageList <- sqlToCsvSqlServerInstanceUsageList$getTibble();
rm(sqlToCsvSqlServerInstanceUsageList);
gc();
## sourceFile Sql Server Instance DB Backup List
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServerInstanceDBBackupList.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);
sqlToCsvSqlServerInstanceDBBackupList <-
  SqlToCsvSqlServerInstanceDBBackupList$new(projectPath, sqlServiceInstance, sqlServerInstance);
sqlToCsvSqlServerInstanceDBBackupList$fileToTibble();
sqlServerInstanceDBBackupList <- sqlToCsvSqlServerInstanceDBBackupList$getTibble();
rm(sqlToCsvSqlServerInstanceDBBackupList);
gc();
## sourceFile Sql Server Instance Running List
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServerInstanceRunningList.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);
sqlToCsvSqlServerInstanceRunningList <-
  SqlToCsvSqlServerInstanceRunningList$new(projectPath, sqlServiceInstance, sqlServerInstance);
sqlToCsvSqlServerInstanceRunningList$fileToTibble();
sqlServerInstanceRunningList <- sqlToCsvSqlServerInstanceRunningList$getTibble();
rm(sqlToCsvSqlServerInstanceRunningList);
gc();
## sourceFile Sql Server Instance DB Spec List
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServerInstanceDBSpecList.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);
sqlToCsvSqlServerInstanceDBSpecList <-
  SqlToCsvSqlServerInstanceDBSpecList$new(projectPath, sqlServiceInstance, sqlServerInstance);
sqlToCsvSqlServerInstanceDBSpecList$fileToTibble();
sqlServerInstanceDBSpecList <- sqlToCsvSqlServerInstanceDBSpecList$getTibble();
rm(sqlToCsvSqlServerInstanceDBSpecList);
gc();
##
rm(sqlServiceInstance);
rm(sqlServerInstance);
rm(sqlServerVersionVector);
rm(sqlServerInstanceLinkedList);
rm(sqlServerInstanceUsageList);
rm(sqlServerInstanceDBBackupList);
rm(sqlServerInstanceRunningList);
rm(sqlServerInstanceDBSpecList);
gc();

