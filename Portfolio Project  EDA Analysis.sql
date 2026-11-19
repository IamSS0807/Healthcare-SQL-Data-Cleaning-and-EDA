-- Exploratory Data Analysis
select * from healthcare_raw2;

select max(Age), min(Age)
from healthcare_raw2;

select max(Date_of_Admission), min(Date_of_Admission)
from healthcare_raw2;

select * from healthcare_raw2
order by Billing_Amount;

select Name, Sum(Billing_Amount) 
from healthcare_raw2
group by Name
Order by 2 Desc;

select min(Date_of_Admission), Max(Date_of_Admission)
from healthcare_raw2;

select min(Discharge_Date), Max(Discharge_Date)
from healthcare_raw2;

select Doctor, Sum(Billing_Amount) 
from healthcare_raw2
group by Doctor
Order by 2 Desc;

select Blood_Type, Sum(Billing_Amount) 
from healthcare_raw2
group by Blood_Type
Order by 2 Desc;

select Blood_Type, Sum(Billing_Amount) 
from healthcare_raw2
group by Blood_Type
Order by 2 Desc;

Select Year(Date_of_Admission), sum(Billing_Amount)
from healthcare_raw2
group by Year(Date_of_Admission)
Order by 1 Desc;

SELECT Year(Discharge_Date), SUM(Billing_Amount)
FROM healthcare_raw2
GROUP BY Year(Discharge_Date)
ORDER BY 1 DESC;

select Medical_Condition, Sum(Billing_Amount) 
from healthcare_raw2
group by Medical_Condition
Order by 2 Desc;

select Insurance_Provider, Sum(Billing_Amount)
from healthcare_raw2
group by Insurance_Provider
Order by 2 Desc;

select Room_Number, Sum(Billing_Amount) from healthcare_raw2
group by Room_Number Order by 2 Desc;

select substring(Date_of_Admission, 1,7) as Month, sum(Billing_Amount)
from healthcare_raw2
group by substring(Date_of_Admission, 1,7)
order by 1 asc;

with Billing_Total as (
select substring(Date_of_Admission, 1,7) as Month, sum(Billing_Amount) as total_Billing_Amount
from healthcare_raw2
group by substring(Date_of_Admission, 1,7)
order by 1 asc
)
select Month, total_Billing_Amount, Sum(total_Billing_Amount) over(Order by Month) as Billing
from Billing_Total;

select substring(Discharge_Date, 1,7) as Month, sum(Billing_Amount)
from healthcare_raw2
group by substring(Discharge_Date, 1,7)
order by 1 asc;

with Billing_Amount2 as (
select substring(Discharge_Date, 1,7) as Month, sum(Billing_Amount) as total_Billing_Amount2
from healthcare_raw2
group by substring(Discharge_Date, 1,7)
order by 1 asc
)
select Month, total_Billing_Amount2, Sum(total_Billing_Amount2) over(Order by Month) as Billing
from Billing_Amount2;


select Name, Year(Date_of_Admission), sum(Billing_Amount)
from healthcare_raw2
group by Name, Year(Date_of_Admission)
Order by 2 asc;

WITH Admitting_Date (Name, Admission_Year, Billing_Amount) AS 
(
    SELECT 
        Name, 
        YEAR(Date_of_Admission), 
        SUM(Billing_Amount)
    FROM healthcare_raw2
    GROUP BY Name, YEAR(Date_of_Admission)
)
SELECT 
    *, 
    DENSE_RANK() OVER (
        PARTITION BY Admission_Year 
        ORDER BY Billing_Amount DESC
    ) AS Billing_Rank
FROM Admitting_Date;



select Name, Year(Discharge_Date), sum(Billing_Amount)
from healthcare_raw2
group by Name, Year(Discharge_Date)
Order by 2 asc;

WITH Discharging_Date AS (
    SELECT 
        Name, 
        YEAR(Discharge_Date) AS Discharge_Year, 
        SUM(Billing_Amount) AS Total_Billing
    FROM healthcare_raw2 
    GROUP BY Name, YEAR(Discharge_Date)
)
SELECT 
    *, 
    DENSE_RANK() OVER (
        PARTITION BY Discharge_Year 
        ORDER BY Total_Billing DESC
    ) AS Billing_Rank
FROM Discharging_Date;

SELECT distinct(Medical_Condition), SUM(Billing_Amount) AS Total_Billing, YEAR(Date_of_Admission) AS Admission_Year, YEAR(Discharge_Date) AS Discharge_Year
FROM healthcare_raw2
GROUP BY Medical_Condition, YEAR(Date_of_Admission), YEAR(Discharge_Date)
ORDER BY 2 DESC;

SELECT YEAR(Date_of_Admission) AS Year, Medical_Condition, SUM(Billing_Amount) AS Total_Cost
FROM healthcare_raw2
GROUP BY YEAR(Date_of_Admission), Medical_Condition
ORDER BY Medical_Condition ASC, Year asc;

WITH MedicalConditioning AS (
    SELECT 
        YEAR(Date_of_Admission) AS Admission_Year, 
        Medical_Condition, 
        SUM(Billing_Amount) AS Total_Cost
    FROM healthcare_raw2
    GROUP BY 
        YEAR(Date_of_Admission), 
        Medical_Condition
)
SELECT 
    *, 
    DENSE_RANK() OVER (
        PARTITION BY Admission_Year
        ORDER BY Total_Cost DESC
    ) AS Medical_Condition_Rank
FROM MedicalConditioning;

select distinct(Test_Results) from healthcare_raw2;

select distinct(Test_Results) from healthcare_raw2;

SELECT Test_Results, Medical_Condition, SUM(Billing_Amount) AS Total_Cost
FROM healthcare_raw2
GROUP BY Test_Results, Medical_Condition
ORDER BY Test_Results ASC, Medical_Condition asc;

WITH TestingResults AS (
    SELECT 
        Test_Results, 
        Medical_Condition, 
        SUM(Billing_Amount) AS Total_Cost
    FROM healthcare_raw2
    GROUP BY 
        Test_Results, 
        Medical_Condition
)
SELECT 
    *, 
    DENSE_RANK() OVER (
        PARTITION BY Test_Results 
        ORDER BY Total_Cost DESC
    ) AS Test_Results_Ranking
FROM TestingResults;
