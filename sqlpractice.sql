/* INSERT INTO EmployeeDemographics VALUES
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')
*/

Insert Into EmployeeSalary Values
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

/*
SELECT FirstName, LastName, Age,
CASE
	When Age > 30 THEN 'Old'
	When Age BETWEEN 27 and 30 THEN 'Young'
	ELSE 'Baby'
END
FROM [SQL Tutorial]..EmployeeDemographics
Where Age is NOT NULL
Order by Age
*/

/*
SELECT FirstName, LastName, JobTitle, Salary,
	CASE 
		WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
		WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
		WHEN JobTitle = 'HR' THEN Salary + (Salary * .000001)
		ELSE Salary + (Salary * .03)
	END
	FROM [SQL Tutorial]..EmployeeDemographics
	JOIN [SQL Tutorial]..EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	*/
/*
	SELECT JobTitle, COUNT(JobTitle)
	FROM [SQL Tutorial]..EmployeeDemographics
	JOIN [SQL Tutorial]..EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	GROUP BY Jobtitle
	HAVING COUNT(JobTitle) > 1
	

	SELECT JobTitle, AVG(Salary)
	FROM [SQL Tutorial]..EmployeeDemographics
	JOIN [SQL Tutorial]..EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
	GROUP BY Jobtitle
	HAVING AVG(Salary) > 45000
	ORDER BY AVG(Salary)
	

-- Update practice

Select *
FROM [SQL Tutorial]..EmployeeDemographics
UPDATE [SQL Tutorial]..EmployeeDemographics
-- Set EmployeeID = 1012
Set Age = 31, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax '



--Aliasing Practice
 
Select FirstName + ' ' + LastName AS FullName
FROM [SQL Tutorial]..EmployeeDemographics



Select AVG(Age) AS AvgAge
FROM [SQL Tutorial]..EmployeeDemographics



Select Demo.EmployeeId, Sal.Salary
FROM [SQL Tutorial]..EmployeeDemographics AS Demo
JOIN [SQL Tutorial]..EmployeeSalary As Sal
	On Demo.EmployeeID = Sal.EmployeeID

SELECT Demo.EmployeeID, Demo.FirstName, Demo.LastName,
	Sal.JobTitle, Ware.Age
FROM [SQL Tutorial]..EmployeeDemographics Demo
LEFT JOIN [SQL Tutorial]..EmployeeSalary Sal
	ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN [SQL Tutorial]..WareHouseEmployeeDemographics Ware
	ON Demo.EmployeeID = Ware.EmployeeID

-- Partition By

SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM [SQL Tutorial]..EmployeeDemographics dem
JOIN [SQL Tutorial]..EmployeeSalary sal
	ON dem.EmployeeID = sal.EmployeeID



-- CTE

WITH CTE_Employee as
(SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender,
AVG (Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM [SQL Tutorial]..EmployeeDemographics emp
JOIN [SQL Tutorial]..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID 
WHERE Salary > '45000'
)
Select *
FROM CTE_Employee

*/

-- Temp Tables

CREATE TABLE #temp_Employee(
EmployeeID int,
JobTitle varchar(100),
Salary int
)

Select *
From #temp_Employee

INSERT INTO #temp_Employee VALUES (
'1001', 'HR', '45000'
)
--Accidently created a duplicate - delete duplicate row
/* Set Rowcount 1
Delete FROM #temp_Employee
Set ROWCOUNT 0
*/

INSERT INTO #temp_Employee
SELECT *
FROM [SQL Tutorial]..EmployeeSalary

-- Create 2nd table

DROP TABLE IF EXISTS #Temp_Employee2
CREATE TABLE #Temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

INSERT INTO #Temp_Employee2
 SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(salary)
 FROM [SQL Tutorial]..EmployeeDemographics emp
 JOIN [SQL Tutorial]..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
Group by JobTitle

SELECT *
FROM #Temp_Employee2

/* If you run again, it will error so you should
 add DROP TABLE IF EXISTS #Temp_Employee2,
 before CREATE TABLE #Temp_Employee2*/

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

-- Trim, LTRIM, RTRIM
--Trim gets rid of blank spaces before or after 
-- LTRIM only before, RTRIM only after (Left/Right)

Select EmployeeID, TRIM(EmployeeID) AS IDTRIM
From EmployeeErrors

-- Use Replace

Select LastName, REPLACE(LastName, '- Fired', '') AS LastNameFixed
FROM EmployeeErrors

-- Use Substring

--Select SUBSTRING(FirstName, 3,3)
--From EmployeeErrors

-- Fuzzy match - Gender,LastName,Age,DOB

Select SUBSTRING(err.FirstName,1,3), SUBSTRING(dem.FirstName,1,3)
From EmployeeErrors err
JOIN [SQL Tutorial]..EmployeeDemographics dem
ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3)

--Using UPPER or LOWER

Select FirstName, LOWER(FirstName)
FROM EmployeeErrors

Select FirstName, UPPER(FirstName)
FROM EmployeeErrors


