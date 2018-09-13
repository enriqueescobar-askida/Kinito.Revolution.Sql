# Sql to Xls to `R`

This is the part when the information source comes from an Excel output expoerted from `SQL Server`.

# `SQL Service` instance

[Xls/SqlServer-ServiceInstance_DEV.xls](Xls/SqlServer-ServiceInstance_DEV.xls)

| DEV |
|-----|

# `SQL Server` version

[Xls/SqlServer-Version_DEV.xls](Xls/SqlServer-Version_DEV.xls)

```
SQLServerVersion
"Microsoft SQL Server 2012 - 11.0.5343.0 (X64) 
	May  4 2015 19:11:32 
	Copyright (c) Microsoft Corporation
	Standard Edition (64-bit) on Windows NT 6.1 <X64> (Build 7601: Service Pack 1) (Hypervisor)
"
```

# `SQL Server` instance

[Xls/SqlServer-Instance_DEV_DEV01-HS-DEV.xls](Xls/SqlServer-Instance_DEV_DEV01-HS-DEV.xls)

| SQLServerInstance |
|-------------------|
| DEV01-HS\DEV      |

```
DEV01-HS\DEV -> DEV01-HS-DEV
```

# `SQL Server` instance usage file

[Xls/SqlServer-Instance_DEV_DEV01-HS-DEV_UsageList.xls](Xls/SqlServer-Instance_DEV_DEV01-HS-DEV_UsageList.xls)


| DBIdentifier | DBName      | DBBufferPages | DBBufferMB |
|--------------|-------------|---------------|------------|
| 9            | HYLTE       | 2             | 0          |
| 32767        | Resource DB | 29            | 0          |
| 3            | model       | 1             | 0          |
| 12           | HYSEC_PDF   | 1             | 0          |
| 6            | HYSEC_DELTA | 1             | 0          |
| 7            | POSTECANADA | 1             | 0          |
| 1            | master      | 14            | 0          |
| 10           | HYSEC       | 95169         | 743        |
| 4            | msdb        | 5             | 0          |
| 13           | HYSEC_MR    | 1             | 0          |
| 5            | Dynamics    | 2             | 0          |
| 2            | tempdb      | 500           | 3          |
| 11           | ASPState    | 1             | 0          |
| 8            | MR2012      | 2             | 0          |

## graphs

| Barplot | Piechart |
|---------|----------|
||||


![IMG-UsageList-Barplot](Xls/SqlServer-Instance_DEV_DEV01-HS-DEV_UsageList_Barplot.png "UsageList Barplot")


![IMG-UsageList-Piechart](Xls/SqlServer-Instance_DEV_DEV01-HS-DEV_UsageList_Piechart.png "UsageList Piechart")


## `SQL Server` instance usage filter

[Xls/SqlServer-Instance_DEV_DEV01-HS-DEV_UsageList.txt](Xls/SqlServer-Instance_DEV_DEV01-HS-DEV_UsageList.txt)

| HYSEC |
|-------|

# `SQL Server` instance linked list

[Xls/SqlServer-Instance_DEV_DEV01-HS-DEV_LinkedList.xls](Xls/SqlServer-Instance_DEV_DEV01-HS-DEV_LinkedList.xls)

| ServerName   | LinkedServerID | LinkedServer | Product    | Provider | DataSource   | ModificationDate        | IsLinked |
|--------------|----------------|--------------|------------|----------|--------------|-------------------------|----------|
| DEV01-HS\DEV | 3              | 10.20.15.20  | SQL Server | SQLNCLI  | 10.20.15.20  | 2016-01-05 15:53:31.020 | True     |
| DEV01-HS\DEV | 0              | DEV01-HS\DEV | SQL Server | SQLNCLI  | DEV01-HS\DEV | 2013-06-03 15:33:01.290 | False    |
| DEV01-HS\DEV | 2              | SQL01-HS     | SQL Server | SQLNCLI  | SQL01-HS     | 2015-02-24 10:15:03.403 | True     |
| DEV01-HS\DEV | 1              | SQL02-HS     | SQL Server | SQLNCLI  | SQL02-HS     | 2013-11-07 15:50:22.360 | True     |

# `SQL Server` instance backup list

[Xls/SqlServer-Instance_DEV_DEV01-HS-DEV_BackupList.xls](Xls/SqlServer-Instance_DEV_DEV01-HS-DEV_BackupList.xls)

| ServerName   | ServiceName | DBName      | Backup_finish_date      | Physical_Device_name                                 |
|--------------|-------------|-------------|-------------------------|------------------------------------------------------|
| DEV01-HS\DEV | DEV         | Dynamics    | 2013-08-07 15:59:39.000 | F:\Backups\FULL_(local)_Dynamics_20130807_155935.sqb |
| DEV01-HS\DEV | DEV         | Dynamics    | 2013-08-07 15:59:39.000 | F:\Backups\FULL_(local)_Dynamics_20130807_155935.sqb |
| DEV01-HS\DEV | DEV         | MR2012      | 2016-02-19 23:50:08.000 | F:\HSBackups\FromSQL01\MR2012.bak                    |
| DEV01-HS\DEV | DEV         | HYSEC_MR    | 2016-02-26 20:55:22.000 | F:\HSBackups\HYSEC_MR.bak                            |
| DEV01-HS\DEV | DEV         | MR2012      | 2016-04-08 23:28:46.000 | F:\HSBackups\FromSQL01\MR2012.bak                    |
| DEV01-HS\DEV | DEV         | POSTECANADA | 2016-08-05 23:20:24.000 | F:\HSBackups\FromSQL01\POSTECANADA.bak               |
| DEV01-HS\DEV | DEV         | HYSEC_DELTA | 2016-08-05 23:21:19.000 | F:\HSBackups\FromSQL01\HYSEC_DELTA.bak               |
| DEV01-HS\DEV | DEV         | HYLTE       | 2016-09-19 22:00:34.000 | F:\HSBackups\FromSQL01\HYLTE.bak                     |
| DEV01-HS\DEV | DEV         | HYLTE       | 2016-10-18 22:00:26.000 | F:\HSBackups\FromSQL01\HYLTE.bak                     |
| DEV01-HS\DEV | DEV         | HYSEC       | 2016-10-18 23:26:27.000 | F:\HSBackups\FromSQL01\HYSEC.bak                     |
| DEV01-HS\DEV | DEV         | POSTECANADA | 2016-10-18 23:28:04.000 | F:\HSBackups\FromSQL01\POSTECANADA.bak               |
| DEV01-HS\DEV | DEV         | HYSEC_DELTA | 2016-10-18 23:29:19.000 | F:\HSBackups\FromSQL01\HYSEC_DELTA.bak               |
| DEV01-HS\DEV | DEV         | ASPState    |                         |                                                      |
| DEV01-HS\DEV | DEV         | HYSEC_PDF   |                         |                                                      |
| DEV01-HS\DEV | DEV         | master      |                         |                                                      |
| DEV01-HS\DEV | DEV         | model       |                         |                                                      |
| DEV01-HS\DEV | DEV         | msdb        |                         |                                                      |
| DEV01-HS\DEV | DEV         | tempdb      |                         |                                                      |


# `SQL Server` instance running list

[Xls/SqlServer-Instance_DEV_DEV01-HS-DEV_RunningList.xls](Xls/SqlServer-Instance_DEV_DEV01-HS-DEV_RunningList.xls)

| ServerName   | ServiceName | ServerStarted           | DaysRunning |
|--------------|-------------|-------------------------|-------------|
| DEV01-HS\DEV | DEV         | 2003-04-08 09:13:36.390 | 4979.224688 |
| DEV01-HS\DEV | DEV         | 2016-10-31 08:29:24.907 | 24.2553819  |
| DEV01-HS\DEV | DEV         | 2003-04-08 09:13:36.390 | 4979.224688 |
| DEV01-HS\DEV | DEV         | 2012-02-10 21:02:17.770 | 1748.732546 |
| DEV01-HS\DEV | DEV         | 2016-10-28 03:00:17.453 | 27.4839351  |
| DEV01-HS\DEV | DEV         | 2016-10-28 03:00:40.177 | 27.4836689  |
| DEV01-HS\DEV | DEV         | 2016-10-28 03:03:44.090 | 27.4815393  |
| DEV01-HS\DEV | DEV         | 2016-10-28 03:11:26.550 | 27.4761921  |
| DEV01-HS\DEV | DEV         | 2016-10-28 03:00:05.843 | 27.484074   |
| DEV01-HS\DEV | DEV         | 2016-10-28 03:11:55.367 | 27.4758564  |
| DEV01-HS\DEV | DEV         | 2014-03-19 16:16:24.767 | 980.9310763 |
| DEV01-HS\DEV | DEV         | 2014-03-24 09:41:15.680 | 976.2054861 |
| DEV01-HS\DEV | DEV         | 2016-02-26 20:03:52.593 | 271.7731134 |

# `SQL Server` instance spec list

[Xls/SqlServer-Instance_DEV_DEV01-HS-DEV_SpecList.xls](Xls/SqlServer-Instance_DEV_DEV01-HS-DEV_SpecList.xls)

| ServerName   | ServiceName | DBIdentifier | DBName      | OriginalDBName   | RecoveryModel | CompatiblityLevel | DBSize   | DBGrowth | IsPercentGrowth | CreatedDate             | CurrentState | AutoShrink | SnapshotState | IsAutoUpdate | IsArithAbort | PageVerifyOption    | Collation                    | FilePath                                       | IdSourceDB |
|--------------|-------------|--------------|-------------|------------------|---------------|-------------------|----------|----------|-----------------|-------------------------|--------------|------------|---------------|--------------|--------------|---------------------|------------------------------|------------------------------------------------|------------|
| DEV01-HS\DEV | DEV         | 11           | ASPState    | ASPState         | FULL          | 110               | 392      | 128      | False           | 2014-03-19 16:16:24.767 | ONLINE       | False      | OFF           | True         | False        | CHECKSUM            | SQL_Latin1_General_CP1_CI_AS | F:\DEVData\ASPState.mdf                        |            |
| DEV01-HS\DEV | DEV         | 5            | Dynamics    | DYNAMICS2_Data   | FULL          | 110               | 77624    | 10       | True            | 2016-10-28 03:00:17.453 | ONLINE       | False      | OFF           | True         | False        | TORN_PAGE_DETECTION | SQL_Latin1_General_CP1_CI_AS | F:\DEVData\Dynamics_dat.mdf                    |            |
| DEV01-HS\DEV | DEV         | 9            | HYLTE       | GPSHYLTEDat.mdf  | FULL          | 110               | 30456    | 20       | True            | 2016-10-28 03:00:05.843 | ONLINE       | False      | OFF           | True         | False        | TORN_PAGE_DETECTION | SQL_Latin1_General_CP1_CI_AS | F:\DEVData\HYLTE_dat.mdf                       |            |
| DEV01-HS\DEV | DEV         | 10           | HYSEC       | GPSHYSECDat.mdf  | FULL          | 110               | 81173696 | 64000    | False           | 2016-10-28 03:11:55.367 | ONLINE       | False      | OFF           | True         | False        | TORN_PAGE_DETECTION | SQL_Latin1_General_CP1_CI_AS | F:\DEVData\HYSEC_dat.mdf                       |            |
| DEV01-HS\DEV | DEV         | 6            | HYSEC_DELTA | HYSEC_DELTA_Data | FULL          | 90                | 822192   | 10       | True            | 2016-10-28 03:00:40.177 | ONLINE       | False      | OFF           | True         | False        | TORN_PAGE_DETECTION | SQL_Latin1_General_CP1_CI_AS | F:\DEVData\HYSEC_DELTA_Data.MDF                |            |
| DEV01-HS\DEV | DEV         | 13           | HYSEC_MR    | HYSEC_MR         | FULL          | 110               | 1230464  | 128      | False           | 2016-02-26 20:03:52.593 | ONLINE       | False      | OFF           | True         | False        | CHECKSUM            | SQL_Latin1_General_CP1_CI_AS | F:\DEVData\HYSEC_MR.mdf                        |            |
| DEV01-HS\DEV | DEV         | 12           | HYSEC_PDF   | HYSEC_PDF        | FULL          | 110               | 3354624  | 128      | False           | 2014-03-24 09:41:15.680 | ONLINE       | False      | OFF           | True         | False        | CHECKSUM            | SQL_Latin1_General_CP1_CI_AS | F:\DEVData\HYSEC_PDF.mdf                       |            |
| DEV01-HS\DEV | DEV         | 1            | master      | master           | SIMPLE        | 110               | 512      | 10       | True            | 2003-04-08 09:13:36.390 | ONLINE       | False      | ON            | True         | False        | CHECKSUM            | SQL_Latin1_General_CP1_CI_AS | F:\DEVData\MSSQL11.DEV\MSSQL\DATA\master.mdf   |            |
| DEV01-HS\DEV | DEV         | 3            | model       | modeldev         | FULL          | 110               | 392      | 128      | False           | 2003-04-08 09:13:36.390 | ONLINE       | False      | OFF           | True         | False        | CHECKSUM            | SQL_Latin1_General_CP1_CI_AS | F:\DEVData\MSSQL11.DEV\MSSQL\DATA\model.mdf    |            |
| DEV01-HS\DEV | DEV         | 8            | MR2012      | MR2012           | FULL          | 110               | 104336   | 128      | False           | 2016-10-28 03:11:26.550 | ONLINE       | False      | OFF           | True         | True         | CHECKSUM            | SQL_Latin1_General_CP1_CI_AS | F:\DEVData\MR2012_Primary.mdf                  |            |
| DEV01-HS\DEV | DEV         | 8            | MR2012      | FILES_2C7A6696   | FULL          | 110               | 128      | 128      | False           | 2016-10-28 03:11:26.550 | ONLINE       | False      | OFF           | True         | True         | CHECKSUM            | SQL_Latin1_General_CP1_CI_AS | F:\DEVData\MR2012_FILES_2C7A6696.mdf           |            |
| DEV01-HS\DEV | DEV         | 4            | msdb        | MSDBData         | SIMPLE        | 110               | 2856     | 10       | True            | 2012-02-10 21:02:17.770 | ONLINE       | False      | ON            | True         | False        | CHECKSUM            | SQL_Latin1_General_CP1_CI_AS | F:\DEVData\MSSQL11.DEV\MSSQL\DATA\MSDBData.mdf |            |
| DEV01-HS\DEV | DEV         | 7            | POSTECANADA | POSTECANADA_Data | FULL          | 90                | 2142472  | 10       | True            | 2016-10-28 03:03:44.090 | ONLINE       | False      | OFF           | True         | False        | TORN_PAGE_DETECTION | SQL_Latin1_General_CP1_CI_AS | F:\DEVData\POSTECANADA_Data.MDF                |            |
| DEV01-HS\DEV | DEV         | 2            | tempdb      | tempdev          | SIMPLE        | 110               | 1024     | 10       | True            | 2016-10-31 08:29:24.907 | ONLINE       | False      | OFF           | True         | False        | CHECKSUM            | SQL_Latin1_General_CP1_CI_AS | F:\DEVData\MSSQL11.DEV\MSSQL\DATA\tempdb.mdf   |            |

### MS SQL Server `object types`

![IMG-BIWebPortal-450](Doc/MS-SQLServer_sys.object.types.png "BIWebPortal 450")

