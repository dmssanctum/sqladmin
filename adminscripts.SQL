dbcc checkalloc

dbcc checkcatalog

dbcc checktable

--all 3 wrapped into 1
dbcc checkdb
--options: repair_rebuild - best method
--repair_all_data_loss - better to restore than do this
--repair_fast - deprecated

--Gets databasesize
USE [database]
GO
EXEC sp_SpaceUsed

--shows space used by logs
dbcc SqlPef(LogSpace)

dbcc ShrinkFile
(logname,size)

USE [Database]
GO
select a.index_id,b.name as index_name,avg_fragmentation_in_percent,[Schema]=s.name,c.name as table_name
from sys.dm_db_index_physical_stats (db_id(),null,null,null,null) as a
  join sys.indexes as b on a.object_id = b.object_id and a.index_id = b.index_id
  join sys.tables c on a.object_id = c.object_id
  join sys.schemas s on s.schema_id = c.schema_id
where avg_fragmentation_in_percent <> 0
order by avg_fragmentation_in_percent desc
GO

ALTER INDEX [indexname] ON [tablename] REBUILD/REORGANIZE

SELECT
   [Name] = Name
  ,[AutoCreateStatistics] = CASE Is_Auto_Create_Stats_On WHEN 1 THEN 'ON' ELSE 'OFF' END
  ,[AutoUpdateStatistics] = CASE Is_Auto_Update_Stats_On WHEN 1 THEN 'ON' ELSE 'OFF' END
FROM sys.databases
WHERE database_Id > 4

--Updates stats where necessary
USE [Database]
GO

--updates specifically
UPDATE Statistics [Table] [index/columnsetname]
EXEC sp_updatestats

USE [msdb]
GO
EXEC msdb.dbo.sp_add_alert @name=N'Severity 16 Error Alerts'
,@message_id=0
,@severity=16
,@enabled=1
,@delay_between_responses=10
,@include_event_description_in=5
,@category_name=N'[Uncategorized]'
,@job_id=N'00000000-0000-0000-0000-000000000000'
GO
EXEC msdb.dbo.sp_add_notification
@alert_name=N'Severity 16 Error Alerts'
,@operator_name=N'yournamehere'
,@notification_method=1
GO
