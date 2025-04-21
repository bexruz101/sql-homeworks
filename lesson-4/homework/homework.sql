-- Task 1: Create and filter TestMultipleZero table
CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

-- Show rows where not all columns are zero
SELECT *
FROM [dbo].[TestMultipleZero]
WHERE NOT (A = 0 AND B = 0 AND C = 0 AND D = 0);


-- Task 2: Create TestMax table and find max value from multiple columns
CREATE TABLE TestMax
(
    Year1 INT,
    Max1 INT,
    Max2 INT,
    Max3 INT
);
GO

INSERT INTO TestMax 
VALUES
    (2001,10,101,87),
    (2002,103,19,88),
    (2003,21,23,89),
    (2004,27,28,91);

-- Get max value from multiple columns per row
SELECT Year1,
       (SELECT MAX(v) FROM (VALUES (Max1), (Max2), (Max3)) AS ValueTable(v)) AS MaxValue
FROM TestMax;


-- Task 3: Create EmpBirth table and find DOBs between May 7 and May 15
CREATE TABLE EmpBirth
(
    EmpId INT IDENTITY(1,1),
    EmpName VARCHAR(50),
    BirthDate DATETIME
);

INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan', '1983-04-12'
UNION ALL
SELECT 'Zuzu', '1986-11-28'
UNION ALL
SELECT 'Parveen', '1977-05-07'
UNION ALL
SELECT 'Mahesh', '1983-01-13'
UNION ALL
SELECT 'Ramesh', '1983-05-09';

-- Select employees born between May 7 and May 15
SELECT EmpName, BirthDate
FROM EmpBirth
WHERE MONTH(BirthDate) = 5
  AND DAY(BirthDate) BETWEEN 7 AND 15;


-- Task 4: Order letters with specific rules
CREATE TABLE letters
(letter CHAR(1));

INSERT INTO letters
VALUES ('a'), ('a'), ('a'), 
       ('b'), ('c'), ('d'), ('e'), ('f');

-- Order with 'b' first
SELECT letter AS [OrderWithBFirst]
FROM letters
ORDER BY CASE WHEN letter = 'b' THEN 0 ELSE 1 END, letter;

-- Order with 'b' last
SELECT letter AS [OrderWithBLast]
FROM letters
ORDER BY CASE WHEN letter = 'b' THEN 1 ELSE 0 END, letter;

-- Optional: Order with 'b' as 3rd
SELECT letter AS [OrderWithBAtThird]
FROM (
    SELECT letter,
           ROW_NUMBER() OVER (ORDER BY CASE WHEN letter = 'b' THEN 999 ELSE ASCII(letter) END) AS rn
    FROM letters
) AS temp
ORDER BY CASE 
            WHEN letter = 'b' THEN 3 
            WHEN rn >= 3 THEN rn + 1 
            ELSE rn 
         END;
