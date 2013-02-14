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
