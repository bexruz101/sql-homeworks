DECLARE @Year INT = 2025;
DECLARE @Month INT = 5;

-- Create a temporary table to hold the calendar data
CREATE TABLE #Calendar (
    WeekNumber INT,
    Sunday DATE,
    Monday DATE,
    Tuesday DATE,
    Wednesday DATE,
    Thursday DATE,
    Friday DATE,
    Saturday DATE
);

-- Generate calendar data for the specified month and year
WITH CalendarCTE AS (
    SELECT DATEADD(DAY, number - 1, DATEFROMPARTS(@Year, @Month, 1)) AS CalendarDate
    FROM master..spt_values
    WHERE type = 'P'
    AND DATEADD(DAY, number - 1, DATEFROMPARTS(@Year, @Month, 1)) < DATEADD(MONTH, 1, DATEFROMPARTS(@Year, @Month, 1))
)

INSERT INTO #Calendar (WeekNumber, Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday)
SELECT
    DATEPART(WEEK, CalendarDate) AS WeekNumber,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 1 THEN CalendarDate END) AS Sunday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 2 THEN CalendarDate END) AS Monday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 3 THEN CalendarDate END) AS Tuesday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 4 THEN CalendarDate END) AS Wednesday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 5 THEN CalendarDate END) AS Thursday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 6 THEN CalendarDate END) AS Friday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 7 THEN CalendarDate END) AS Saturday
FROM CalendarCTE
GROUP BY DATEPART(WEEK, CalendarDate);

-- Query to select and display the calendar data
SELECT WeekNumber, Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
FROM #Calendar
ORDER BY WeekNumber;

-- Drop the temporary table once done
DROP TABLE #Calendar;
