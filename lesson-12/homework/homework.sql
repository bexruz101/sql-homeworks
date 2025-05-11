-- SQL query to retrieve database, schema, table, column, and column data type information
SELECT 
    DB_NAME() AS DatabaseName,
    SCHEMA_NAME(tbl.schema_id) AS SchemaName,
    tbl.name AS TableName,
    col.name AS ColumnName,
    typ.name AS ColumnType
FROM 
    sys.tables AS tbl
INNER JOIN 
    sys.columns AS col ON tbl.object_id = col.object_id
INNER JOIN 
    sys.types AS typ ON col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
WHERE 
    tbl.is_ms_shipped = 0  
ORDER BY 
    DatabaseName, SchemaName, TableName, col.column_id;

-- Stored procedure to retrieve stored procedure and function information with parameters
CREATE PROCEDURE GetAllProceduresAndFunctions
    @DatabaseName NVARCHAR(128) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        DB_NAME() AS DatabaseName,
        SCHEMA_NAME(p.schema_id) AS SchemaName,
        p.name AS ProcedureName,
        CASE WHEN o.type_desc = 'SQL_SCALAR_FUNCTION' THEN 'FUNCTION'
             WHEN o.type_desc = 'SQL_STORED_PROCEDURE' THEN 'PROCEDURE'
             ELSE 'UNKNOWN' END AS Type,
        ISNULL(pm.name, '') AS ParameterName,
        ISNULL(tp.name, '') AS ParameterType,
        ISNULL(pm.max_length, 0) AS MaxLength
    FROM 
        sys.objects AS o
    INNER JOIN 
        sys.parameters AS pm ON o.object_id = pm.object_id
    INNER JOIN 
        sys.types AS tp ON pm.system_type_id = tp.system_type_id AND pm.user_type_id = tp.user_type_id
    LEFT JOIN 
        sys.procedures AS p ON o.object_id = p.object_id
    WHERE 
        (o.type_desc = 'SQL_STORED_PROCEDURE' OR o.type_desc = 'SQL_SCALAR_FUNCTION')
        AND (@DatabaseName IS NULL OR DB_NAME() = @DatabaseName)
    ORDER BY 
        DatabaseName, SchemaName, ProcedureName, pm.parameter_id;
END;
