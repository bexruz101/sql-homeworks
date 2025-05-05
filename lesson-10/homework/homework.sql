WITH AllDays AS (
    SELECT Num FROM Shipments
    UNION ALL
    SELECT 0 FROM (VALUES (1), (2), (3), (4), (5), (6), (7)) AS MissingDays(n)
),
Ordered AS (
    SELECT 
        Num,
        ROW_NUMBER() OVER (ORDER BY Num) AS rn
    FROM AllDays
),
Counted AS (
    SELECT COUNT(*) AS total FROM Ordered
),
MedianVals AS (
    SELECT o.Num
    FROM Ordered o
    CROSS JOIN Counted c
    WHERE 
        (c.total % 2 = 1 AND o.rn = (c.total + 1) / 2)
        OR
        (c.total % 2 = 0 AND o.rn IN (c.total / 2, c.total / 2 + 1))
)
SELECT 
    AVG(1.0 * Num) AS Median
FROM MedianVals;
