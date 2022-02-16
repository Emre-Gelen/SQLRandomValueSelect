CREATE PROCEDURE [dbo].[GetRandomValueByColumnName]
		@ColumnName			nvarchar(MAX)
AS
BEGIN
	
	SET NOCOUNT ON;

	declare @AllValuesTable table(ColumnValue nvarchar(MAX)) --Declared a table to collect data from all tables by column name.
		
	DECLARE @Query NVARCHAR(MAX)
	DECLARE SelectResult CURSOR
	FOR             
	Select 'Select '+ tl.ColumnName +' from '+ tl.TableName from (SELECT c.name  AS ColumnName
			,t.name AS TableName
	FROM        sys.columns c
		JOIN        sys.tables  t   ON c.object_id = t.object_id
		WHERE       c.name LIKE '%'+@ColumnName+'%') as Tl  --Get all table name and create query with these table names and column name then set into SelectResult.

	--Run queries by one by and insert query results to @AllValuesTable.
	OPEN SelectResult
	FETCH NEXT FROM SelectResult INTO @Query
	WHILE @@FETCH_STATUS = 0
		BEGIN
		INSERT INTO @AllValuesTable(ColumnValue) exec (@Query)
		FETCH NEXT FROM SelectResult INTO @Query
		END
	CLOSE SelectResult
	DEALLOCATE SelectResult



	SELECT TOP 1 ColumnValue FROM @AllValuesTable  
	ORDER BY NEWID()  --Get random value.
END