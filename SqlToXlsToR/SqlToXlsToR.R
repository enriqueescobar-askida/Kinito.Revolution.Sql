# sourcePath
projectSourcePath <- paste0(projectPath, "/Src");
write(paste0(c("sourcePath ...\t", projectSourcePath), sep = "", collapse = ""), stdout());
# sourceFile
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServer.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);

sqlToCsvSqlServer <- SqlToCsvSqlServer$new(projectPath)
sqlToCsvSqlServer$HeadVersion
sqlToCsvSqlServer$HeadInstance
sqlToCsvSqlServer$Path
sqlToCsvSqlServer$Ext
sqlToCsvSqlServer$VersionVector
sqlToCsvSqlServer$HasVersion
sqlToCsvSqlServer$ServiceInstance
sqlToCsvSqlServer$HasService
sqlToCsvSqlServer$Instance
rm(sqlToCsvSqlServer)
gc()
