
DECLARE 
    @tableHTML NVARCHAR(MAX),
    @profile_name SYSNAME = 'SenderProfile2',
    @recipients NVARCHAR(200) = 'bexruzyusupov46@gmail.com';


SET @tableHTML = 
N'<style>
    table { border-collapse: collapse; width: 100%; }
    th, td { border: 1px solid #ddd; padding: 8px; }
    th { background-color: #f2f2f2; text-align: left; }
</style>
<h3>SQL Server Index Metadata Report</h3>
<table>
    <tr>
        <th>Table Name</th>
        <th>Index Name</th>
        <th>Index Type</th>
        <th>Column Type</th>
    </tr>';

SELECT @tableHTML = @tableHTML + 
    N'<tr>
        <td>' + QUOTENAME(s.name + '.' + t.name) + N'</td>
        <td>' + QUOTENAME(i.name) + N'</td>
        <td>' + i.type_desc + N'</td>
        <td>' + 
            CASE 
                WHEN ic.is_included_column = 1 THEN 'Included Column'
                ELSE 'Key Column'
            END + N'</td>
    </tr>'
FROM 
    sys.indexes i
JOIN 
    sys.tables t ON i.object_id = t.object_id
JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
JOIN 
    sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN 
    sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
WHERE 
    i.is_hypothetical = 0
    AND i.name IS NOT NULL;

SET @tableHTML = @tableHTML + N'</table>';

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = @profile_name,
    @recipients = @recipients,
    @subject = 'SQL Server Index Metadata Report',
    @body = @tableHTML,
    @body_format = 'HTML';
