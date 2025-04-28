SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
RIGHT JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
FULL OUTER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

SELECT d.DepartmentName, SUM(e.Salary) AS TotalSalaryExpense
FROM Employees e
LEFT JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

SELECT d.DepartmentName, p.ProjectName
FROM Departments d
CROSS JOIN Projects p;

SELECT e.EmployeeID, e.Name, d.DepartmentName, p.ProjectName
FROM Employees e
LEFT JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
LEFT JOIN Projects p
    ON e.EmployeeID = p.EmployeeID;
