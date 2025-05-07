CREATE TABLE Employees(
    EmployeeID INT,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Salary INT
);

INSERT INTO Employees(EmployeeID, Name, Department, Salary)
VALUES
(1, 'Alice', 'HR', 5000),
(2, 'Bob', 'IT', 7000),
(3, 'Charlie', 'Sales', 6000),
(4, 'David', 'HR', 5500),
(5, 'Emma', 'IT', 7200);


CREATE TABLE #EmployeeTransfers  (
    EmployeeID INT,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Salary INT
);


insert into #EmployeeTransfers(EmployeeID,Name,Department,Salary)
select EmployeeID,Name,
case 

	when Department = 'HR' then 'IT'
	when Department = 'IT' then 'Sales'
	when Department = 'Sales' then 'HR'
	else Department
end as Department,
Salary
from Employees

select * from #EmployeeTransfers

-----------------Task 2--------------


CREATE TABLE Orders_DB1 (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1(OrderID, CustomerName, Product, Quantity)
VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);


CREATE TABLE Orders_DB2 (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 (OrderID, CustomerName, Product, Quantity)
VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);



declare @MissingOrders table(
	OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50),
    Quantity INT

)


insert into
@MissingOrders
select *
from Orders_DB1 
where OrderID not in
		(
		select OrderID
		from Orders_DB2
		)

select * from @MissingOrders


-----------------Task 3--------------

CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog (EmployeeID, EmployeeName, Department, WorkDate, HoursWorked)
VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);




go
create view vw_MonthlyWorkSummary as
select EmployeeID,EmployeeName,Department,sum(HoursWorked) as TotalHoursWorked,NULL as TotalHoursDepartment,Null as AvgHoursDepartment
from WorkLog
group by EmployeeID,EmployeeName,Department
union all
select NULL as EmployeeID,NULL as EmployeeName,Department,NULL as TotalHoursWorked,SUM(HoursWorked) as TotalHoursDepartment,NULL as AvgHoursDepartment
from WorkLog
group by Department
union all
select NULL as EmployeeID,NULL as EmployeeName,Department,NULL as TotalHoursWorked,NULL as AvgHoursDepartment,AVG(HoursWorked) as AvgHoursDepartment  
from WorkLog
group by Department
go

select * from vw_MonthlyWorkSummary




