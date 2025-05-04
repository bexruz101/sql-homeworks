WITH EmployeeDepth AS (
    SELECT 
        EmployeeID,
        ManagerID,
        JobTitle,
        0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    SELECT 
        e.EmployeeID,
        e.ManagerID,
        e.JobTitle,
        ed.Depth + 1
    FROM Employees e
    INNER JOIN EmployeeDepth ed
        ON e.ManagerID = ed.EmployeeID
)
SELECT * FROM EmployeeDepth
ORDER BY EmployeeID;


DECLARE @N INT = 10;

WITH Numbers AS (
    SELECT 1 AS Num, 1 AS Factorial
    UNION ALL
    SELECT Num + 1, Factorial * (Num + 1)
    FROM Numbers
    WHERE Num < @N
)
SELECT * FROM Numbers
OPTION (MAXRECURSION 100);

DECLARE @N INT = 10;

WITH Fibonacci AS (
    SELECT 1 AS n, 1 AS Fibonacci_Number, 0 AS prev
    UNION ALL
    SELECT n + 1, Fibonacci_Number + prev, Fibonacci_Number
    FROM Fibonacci
    WHERE n < @N
)
SELECT n, Fibonacci_Number
FROM Fibonacci
OPTION (MAXRECURSION 100);
