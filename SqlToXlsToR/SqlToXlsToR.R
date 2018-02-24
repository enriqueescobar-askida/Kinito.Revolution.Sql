# sourcePath
projectSourcePath <- paste0(projectPath, "/Src");
write(paste0(c("sourcePath ...\t", projectSourcePath), sep = "", collapse = ""), stdout());
# sourceFile
projectSourceFile <- paste0(projectSourcePath, "/", "SqlToCsvSqlServer.R");
write(paste0(c("sourceFile ...\t", projectSourceFile), sep = "", collapse = ""), stdout());
source(projectSourceFile);

csv <- "E:/Disk_X/Kinito.Revolution.Sql/SqlToXlsToR/../Csv/SqlServer-Version_DESKTOP-OM0V6GG.csv"
#newdataset <- read.csv(file.choose(), header = FALSE, sep = "\t")

sqlToCsvSqlServer <- SqlToCsvSqlServer$new(projectPath)
sqlToCsvSqlServer$HeadVersion
sqlToCsvSqlServer$HeadInstance
sqlToCsvSqlServer$Path
sqlToCsvSqlServer$Ext
sqlToCsvSqlServer$Version
sqlToCsvSqlServer$HasVersion
rm(sqlToCsvSqlServer)
gc()
# sqlToCsvSqlServer$add("something")
# sqlToCsvSqlServer$add("another thing")
# sqlToCsvSqlServer$add(17)
# sqlToCsvSqlServer$remove()
# sqlToCsvSqlServer$queue
# sqlToCsvSqlServer$length()
