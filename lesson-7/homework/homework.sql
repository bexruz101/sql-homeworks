SELECT 
    c.CustomerID,
    c.CustomerName,
    o.OrderID,
    o.OrderDate
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID;

SELECT 
    c.CustomerID,
    c.CustomerName
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID
WHERE 
    o.OrderID IS NULL;

SELECT 
    o.OrderID,
    p.ProductName,
    od.Quantity
FROM 
    Orders o
INNER JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN 
    Products p ON od.ProductID = p.ProductID;

SELECT 
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS OrderCount
FROM 
    Customers c
INNER JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID, c.CustomerName
HAVING 
    COUNT(o.OrderID) > 1;

WITH RankedProducts AS (
    SELECT 
        od.OrderID,
        od.ProductID,
        p.ProductName,
        od.Price,
        ROW_NUMBER() OVER (PARTITION BY od.OrderID ORDER BY od.Price DESC) AS rn
    FROM 
        OrderDetails od
    INNER JOIN 
        Products p ON od.ProductID = p.ProductID
)
SELECT 
    OrderID,
    ProductID,
    ProductName,
    Price
FROM 
    RankedProducts
WHERE 
    rn = 1;

WITH LatestOrders AS (
    SELECT 
        CustomerID,
        OrderID,
        OrderDate,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate DESC) AS rn
    FROM 
        Orders
)
SELECT 
    CustomerID,
    OrderID,
    OrderDate
FROM 
    LatestOrders
WHERE 
    rn = 1;

SELECT 
    c.CustomerID,
    c.CustomerName
FROM 
    Customers c
INNER JOIN 
    Orders o ON c.CustomerID = o.CustomerID
INNER JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN 
    Products p ON od.ProductID = p.ProductID
GROUP BY 
    c.CustomerID, c.CustomerName
HAVING 
    COUNT(DISTINCT CASE WHEN p.Category <> 'Electronics' THEN p.ProductID END) = 0;

SELECT DISTINCT
    c.CustomerID,
    c.CustomerName
FROM 
    Customers c
INNER JOIN 
    Orders o ON c.CustomerID = o.CustomerID
INNER JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
INNER JOIN 
    Products p ON od.ProductID = p.ProductID
WHERE 
    p.Category = 'Stationery';

SELECT 
    c.CustomerID,
    c.CustomerName,
    SUM(od.Quantity * od.Price) AS TotalSpent
FROM 
    Customers c
INNER JOIN 
    Orders o ON c.CustomerID = o.CustomerID
INNER JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
GROUP BY 
    c.CustomerID, c.CustomerName;

