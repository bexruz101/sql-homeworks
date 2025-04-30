WITH Numbered AS (
    SELECT 
        [Step Number],
        Status,
        ROW_NUMBER() OVER (ORDER BY [Step Number]) -
        ROW_NUMBER() OVER (PARTITION BY Status ORDER BY [Step Number]) AS grp
    FROM Groupings
),
Grouped AS (
    SELECT 
        MIN([Step Number]) AS [Min Step Number],
        MAX([Step Number]) AS [Max Step Number],
        Status,
        COUNT(*) AS [Consecutive Count]
    FROM Numbered
    GROUP BY Status, grp
)
SELECT *
FROM Grouped
ORDER BY [Min Step Number];


WITH AllYears AS (
    SELECT YEAR FROM (
        SELECT TOP (YEAR(GETDATE()) - 1975 + 1)
            1975 + ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS YEAR
        FROM master..spt_values
    ) AS years
),
HiredYears AS (
    SELECT DISTINCT YEAR(HIRE_DATE) AS YEAR
    FROM EMPLOYEES_N
),
MissingYears AS (
    SELECT YEAR
    FROM AllYears
    WHERE YEAR NOT IN (SELECT YEAR FROM HiredYears)
),
Grouped AS (
    SELECT 
        YEAR,
        YEAR - ROW_NUMBER() OVER (ORDER BY YEAR) AS grp
    FROM MissingYears
),
Final AS (
    SELECT 
        MIN(YEAR) AS StartYear,
        MAX(YEAR) AS EndYear
    FROM Grouped
    GROUP BY grp
)
SELECT 
    CAST(StartYear AS VARCHAR) + ' - ' + CAST(EndYear AS VARCHAR) AS Years
FROM Final
ORDER BY StartYear;
