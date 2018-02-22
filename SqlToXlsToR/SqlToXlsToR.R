# sourcePath
projectSourcePath <- paste0(projectPath, "/Src");
write(paste0(c("sourcePath ...\t", projectSourcePath), sep = "", collapse = ""), stdout());
# sourceFile
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServer.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(SqlToCsvSqlServerPath);

sqlToCsvSqlServer <- SqlToCsvSqlServer$new("Ann", "black")
sqlToCsvSqlServer$hair
sqlToCsvSqlServer$hundred
sqlToCsvSqlServer$name
sqlToCsvSqlServer$x2
rm(sqlToCsvSqlServer)
gc()
# sqlToCsvSqlServer$add("something")
# sqlToCsvSqlServer$add("another thing")
# sqlToCsvSqlServer$add(17)
# sqlToCsvSqlServer$remove()
# sqlToCsvSqlServer$queue
# sqlToCsvSqlServer$length()
