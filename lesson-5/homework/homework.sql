CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');

SELECT *,
    RANK() OVER (ORDER BY Salary DESC) AS SalaryRank,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseSalaryRank,
    DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptTop2Rank,
    RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS DeptMinRank,
    SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningDeptTotal,
    SUM(Salary) OVER (PARTITION BY Department) AS TotalDeptSalary,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgDeptSalary,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg,
    AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg3,
    RANK() OVER (ORDER BY HireDate DESC) AS HireRank,
    AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningAvg,
    MAX(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS MaxSlidingWindow,
    100.0 * Salary / SUM(Salary) OVER (PARTITION BY Department) AS PercentOfDept
FROM Employees;
