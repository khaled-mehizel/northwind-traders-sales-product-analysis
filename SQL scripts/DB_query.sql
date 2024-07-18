/* Cleaning the data ----------------------------------------------------------------------------------------------------------------------------------------------------
Checking for duplicates ------------------------------------------------------------------------------- */
DELETE t2 FROM gd_hr_data t1,
    gd_hr_data t2 
WHERE
    t1.EmployeeNumber < t2.EmployeeNumber
    AND (t1.age = t2.age
    AND t1.Department = t2.Department
    AND t1.PercentSalaryHike = t2.PercentSalaryHike);
-- There are 0 duplicates in this table, I checked in Excel because this column subset wouldn't be enough anyway-----------

SELECT DISTINCT
    BusinessTravel
FROM
    gd_hr_data;
-- replacing the unnecessary parts of the strings -------------------------------------------------------
UPDATE gd_hr_data 
SET 
    BusinessTravel = REPLACE(BusinessTravel,
        'Travel_Rarely',
        'Rarely');

UPDATE gd_hr_data 
SET 
    BusinessTravel = REPLACE(BusinessTravel,
        'Travel_Frequently',
        'Frequently');
-- checking if our data is still intact ------------------------------------------------------------------
SELECT DISTINCT
    BusinessTravel
FROM
    gd_hr_data;

-- Checking the age column --------------------------------------------------------------------
SELECT DISTINCT
    age
FROM
    gd_hr_data
ORDER BY 1 ASC;
-- no child labor here!

CREATE TABLE demographics AS SELECT EmployeeNumber,
    Age,
    Gender,
    Department,
    NumCompaniesWorked,
    TotalWorkingYears,
    YearsAtCompany,
    attrition AS "terminated"
    FROM
    gd_hr_data;
ALTER TABLE demographics
ADD PRIMARY KEY (EmployeeNumber);
UPDATE demographics
SET Department = REPLACE(Department, "Research & Development", "R&D"),
Department = REPLACE(Department, "Human Resources", "HR")
;


CREATE TABLE salaries AS SELECT EmployeeNumber,
    Department,
    HourlyRate,
    MonthlyRate,
    PercentSalaryHike FROM
    gd_hr_data;
ALTER TABLE salaries
ADD PRIMARY KEY (EmployeeNumber);

CREATE TABLE possible_drivers AS SELECT EmployeeNumber,
    BusinessTravel,
    DistanceFromHome,
    MaritalStatus,
    YearsSinceLastPromotion,
    JobSatisfaction,
    OverTime,
    WorkLifeBalance FROM
    gd_hr_data;
ALTER TABLE possible_drivers
ADD PRIMARY KEY (EmployeeNumber);

    