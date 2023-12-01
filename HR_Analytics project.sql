/* I'm delighted to share with you the conclusion of my third project as a Data Analyst at #MeriSKILL. 
This exciting project focused on HR data visualization with Excel, MySQL, Power BI, Python. */

USE portfolio

SELECT *
  FROM [portfolio].[dbo].[HR-Employee-Attrition]

 --- Attrition % rate %16
With attri as(
	SELECT COUNT(Attrition) as attr_count
	From [HR-Employee-Attrition]
	Where Attrition = '1'
    )
SELECT (Attr_count*100)/ (SELECT COUNT(Attrition) FROM [HR-Employee-Attrition]) as Attrition_raye 
FROM attri
  

-----What's the average ages of employees 36

SELECT ROUND(AVG(age),1) as Average_age
FROM [HR-Employee-Attrition]

---what's the average income 

SELECT ROUND(AVG(MonthlyIncome),2) as AVG_Income
FROM [HR-Employee-Attrition]

-- most of the employees are of the age between 31 to 40 of age

With cte as (SELECT age,
 CASE when age between 18 and 25 Then 'under age to 25'
	  when age between 26 and 35 then '26 to 35'
	  when age between 36 and 45 then '36 to 45'
	  when age between 46 and 55 then '46 to 55'
	  ELSE '56+' END AS Age_range
FROM [HR-Employee-Attrition])

SELECT Age_range,
	COUNT(Age_range) as age_group
FROM cte
GROUP BY Age_range


---what's the average age and Avg income of employees per department

SELECT Department, 
ROUND(AVG(age),1) as Average_age,
ROUND(AVG(MonthlyIncome),2) as AVG_Income
FROM [HR-Employee-Attrition]
Group by Department

--- Monthly income above average per department

SELECT Department,MonthlyIncome,age
FROM [HR-Employee-Attrition]
WHERE MonthlyIncome > (SELECT AVG(MonthlyIncome) from [HR-Employee-Attrition])
Group by Department,MonthlyIncome,age

--- What the daily_rate compare with education field

SELECT
EducationField,
Count(*) as number_Employees,
AVG(DailyRate) As AVG_Daily_Rate,
ROUND(AVG(MonthlyIncome),2) as AVG_Income
From [HR-Employee-Attrition]
GROUP BY EducationField

--- What average monthly income per gender, this queries show that Gender 
--- females have more average salary then males 

SELECT
Gender,
Count(*) as number_Employees,
AVG(DailyRate) As AVG_Daily_Rate,
ROUND(AVG(MonthlyIncome),2) as AVG_Income,
SUM(MonthlyIncome)*100 / (SELECT SUM(MonthlyIncome) from [HR-Employee-Attrition]) as income_ratio
From [HR-Employee-Attrition]
GROUP BY Gender


---Whta's the AVG_Salary_hike
SELECT
Gender, AVG(PercentSalaryHike) as AVG_Percentage_Salary
FROM [HR-Employee-Attrition]
Group by Gender

---Whta's the AVG_Salary_hike department

SELECT Department,
 AVG(PercentSalaryHike) as AVG_Percentage_Salary
FROM [HR-Employee-Attrition]
Group by Department

----A ttrition Count per gender
SELECT Gender, Attrition,
	COUNT(*) as total_count
FROM [HR-Employee-Attrition]
WHERE Attrition = 1
GROUP BY gender, Attrition

----A ttrition Count per Marital status, the query show the attrition of more single people of 8% then maried 5%, and divorced 2% 
SELECT MaritalStatus, Attrition,
	COUNT(1) as total_count,
	COUNT(MaritalStatus)*100/(select count(MaritalStatus) from [HR-Employee-Attrition]) as MaritalStatus_ratio
FROM [HR-Employee-Attrition]
WHERE Attrition = 1
GROUP BY MaritalStatus, Attrition
---What's Gender % ratio of and  monthly income

SELECT gender,
COUNT(gender)*100/(select count(gender) from [HR-Employee-Attrition]) as Gender_ratio,
SUM(MonthlyIncome)*100/(select sum(MonthlyIncome) from [HR-Employee-Attrition]) as Parcentage_imcome
FROM [HR-Employee-Attrition]
Group by gender

---What's Department % ratio and  monthly income

SELECT Department,
COUNT(Department)*100/(select count(Department) from [HR-Employee-Attrition]) as Department_ratio,
SUM(MonthlyIncome)*100/(select sum(MonthlyIncome) from [HR-Employee-Attrition]) as Parcentage_imcome
FROM [HR-Employee-Attrition]
Group by Department

---What's Marital_status % ratio ofand  monthly income

SELECT MaritalStatus,
COUNT(MaritalStatus)*100/(select count(MaritalStatus) from [HR-Employee-Attrition]) as MaritalStatus_ratio,
SUM(MonthlyIncome)*100/(select sum(MonthlyIncome) from [HR-Employee-Attrition]) as Parcentage_imcome
FROM [HR-Employee-Attrition]
Group by MaritalStatus

---What's the the 1 Education in the company

SELECT top 3  EducationField, 
		COUNT(EducationField) as Top_education,
		COUNT(EducationField)*100/(select count(EducationField) from [HR-Employee-Attrition]) as Education_Ratio
FROM[HR-Employee-Attrition]
GROUP BY EducationField
Order by Top_education DESC

--- What's the the 3 JobRole in the company 

SELECT TOP 3 JobRole, 
		COUNT(JobRole) as Top_JobRole
FROM[HR-Employee-Attrition]
GROUP BY JobRole
Order by ToP_JobRole DESC


---What department that having more employees

SELECT TOP 1 Department, 
		COUNT(Department) as ToP_Department
FROM[HR-Employee-Attrition]
GROUP BY Department
Order by ToP_Department DESC

---What department that having more employees 

SELECT TOP 1 Department, 
		COUNT(Department) as ToP_Department
FROM[HR-Employee-Attrition]
WHERE Attrition ='0'
GROUP BY Department
Order by ToP_Department DESC

--- Attrition Ratio
SELECT Attrition,
COUNT(Attrition)*100/(select count(Attrition) from [HR-Employee-Attrition]) as Attrition_ratio
FROM [HR-Employee-Attrition]
Group by Attrition

--- Ovatime Ratio
SELECT overtime,
COUNT(overtime)*100/(select count(overtime) from [HR-Employee-Attrition]) as overtime_ratio
FROM [HR-Employee-Attrition]
Group by overtime

--- What department of employees that working more overtime
SELECT Department,
COUNT(overtime)*100/(select count(overtime) from [HR-Employee-Attrition]) as overtime_ratio
FROM [HR-Employee-Attrition]
Where OverTime ='1'
Group by Department
ORDER BY overtime_ratio DESC



----Number of employees per working Distince 69% parcentage of worker lives with 10 km from work 
--- and 13% lives of 21km away from work

With cte as ( SELECT DistanceFromHome,
	case 
		when DistanceFromHome between 0 and 10 then 'Group A 0-10KM'
		when DistanceFromHome between 11 and 20 then 'Group B 11-20KM'
		else 'Group C 21KM+'End  AS Distance_Groups
	From [HR-Employee-Attrition] )

SELECT Distance_Groups, count(DistanceFromHome) as Kms_count,
COUNT(DistanceFromHome)*100/ (SELECT COUNT(DistanceFromHome) from cte) as Parcentage_Home_distance
From cte
Group by Distance_Groups
ORDER BY Parcentage_Home_distance DESC

---Top department  with high attrition count

SELECT Department, 
	COUNT(Department) as Total_Attrition
FROM [HR-Employee-Attrition]
WHERE Attrition = '1'
GROUP BY Department
ORDER BY Total_Attrition DESC

--- Top JobRole  with high attrition count
         
SELECT JobRole,
	COUNT(JobRole) as Total_Attrition
FROM [HR-Employee-Attrition]
GROUP BY JobRole
ORDER BY Total_Attrition DESC

--- Top BusinessTravel high attrition count

SELECT BusinessTravel,
		COUNT(BusinessTravel) as Total_Attrition
FROM [HR-Employee-Attrition]
GROUP BY BusinessTravel
ORDER BY Total_Attrition DESC


----Job Satisfaction
SELECT  JobSatisfaction,
		COUNT(JobSatisfaction) as Satisfaction
FROM [HR-Employee-Attrition]
GROUP BY JobSatisfaction

---31% of employees are very satisfied and 19% are very disatisfied

 with job_rate as ( SELECT *,
		case 
		WHEN JobSatisfaction =1 THEN 'Very disatisfied'
		WHEN JobSatisfaction =2 THEN 'Disatisfied'
		WHEN JobSatisfaction =3 THEN 'Neutral'
		ELSE 'Satisfied'
		END AS Job_rating
FROM [HR-Employee-Attrition])

SELECT Job_rating,
COUNT(Job_rating)*100 / (SELECT COUNT(Job_rating) from job_rate) as Job_satisfaction
from job_rate
Group by Job_rating

----
 with job_rate as ( SELECT *,
		case 
		WHEN JobSatisfaction =1 THEN 'Very disatisfied'
		WHEN JobSatisfaction =2 THEN 'Disatisfied'
		WHEN JobSatisfaction =3 THEN 'Neutral'
		ELSE 'Satisfied'
		END AS Job_rating
FROM [HR-Employee-Attrition])

SELECT Job_rating ,Gender,
COUNT(Job_rating)*100 / (SELECT COUNT(Job_rating) from job_rate) as Job_satisfaction
from job_rate
WHERE Job_rating = 'Satisfied'
Group by Job_rating ,Gender
