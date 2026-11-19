create database heathcare_project;
select * from healthcare_dataset;
create table healthcare_raw
like healthcare_dataset;
select * from healthcare_raw;
insert healthcare_raw
select * 
from healthcare_dataset;

select *,
row_number() over(partition by Name, Age, Gender, Blood_Type, Medical_Condition, Date_of_Admission, Doctor, Hospital, Insurance_Provider, Billing_Amount, Room_Number, Admission_Type, Discharge_Date, Medication, Test_Results) as row_num
from healthcare_raw;

with duplicate_cte as 
(
select *,
row_number() over(partition by Name, Age, Gender, Blood_Type, Medical_Condition, Date_of_Admission, Doctor, Hospital, Insurance_Provider, Billing_Amount, Room_Number, Admission_Type, Discharge_Date, Medication, Test_Results) as row_num
from healthcare_raw
)
select * from duplicate_cte where row_num > 1;

select * from healthcare_raw
where Name = 'ABIgaIL YOung';


with duplicate_cte as 
(
select *,
row_number() over(partition by Name, Age, Gender, Blood_Type, Medical_Condition, Date_of_Admission, Doctor, Hospital, Insurance_Provider, Billing_Amount, Room_Number, Admission_Type, Discharge_Date, Medication, Test_Results) as row_num
from healthcare_raw
)
delete from duplicate_cte where row_num > 1;

CREATE TABLE `healthcare_raw2` (
  `Name` text,
  `Age` int DEFAULT NULL,
  `Gender` text,
  `Blood_Type` text,
  `Medical_Condition` text,
  `Date_of_Admission` text,
  `Doctor` text,
  `Hospital` text,
  `Insurance_Provider` text,
  `Billing_Amount` double DEFAULT NULL,
  `Room_Number` int DEFAULT NULL,
  `Admission_Type` text,
  `Discharge_Date` text,
  `Medication` text,
  `Test_Results` text,
   `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from healthcare_raw2 where row_num > 1;

insert into healthcare_raw2
select *,
row_number() over(partition by Name, Age, Gender, Blood_Type, Medical_Condition, Date_of_Admission, Doctor, Hospital, Insurance_Provider, Billing_Amount, Room_Number, Admission_Type, Discharge_Date, Medication, Test_Results) as row_num
from healthcare_raw;

delete from healthcare_raw2 where row_num > 1;
select * from healthcare_raw2 ;

select Name, (Trim(name))
from healthcare_raw2;

update	healthcare_raw2
set name = concat(
Upper(Left(Substring_Index(Name, ' ', 1), 1)),
Lower(substring(substring_index(Name, ' ', 1), 2)), 
' ',
Upper(Left(substring_index(Name, ' ', -1), 1)),
Lower(substring(substring_index(Name, ' ', -1), 2))
);

select distinct(Medical_Condition) from healthcare_raw2 order by 1;

select distinct(Doctor) from healthcare_raw2 order by 1;

select Doctor, (Trim(Doctor)) from healthcare_raw2;

select distinct(Hospital) from healthcare_raw2;

update healthcare_raw2
set Hospital = trim(trailing ',' from trim(Hospital));

update healthcare_raw2
Set Hospital = trim(substring(Hospital, 5))
where Hospital like 'and %' and Hospital NOT LIKE 'and Sons %';

update healthcare_raw2
set Hospital = trim(left(Hospital, Length(Hospital) - 4))
where Hospital Like '% and';

update healthcare_raw2
set hospital = trim(Trailing ',' from trim(Hospital));

Update healthcare_raw2
set Hospital = concat(substring(Hospital, 5), ' Ltd')
Where Hospital like 'Ltd %';

Update healthcare_raw2
set Hospital = concat(substring(Hospital, 5), ' PLC')
Where Hospital like 'PLC %';

Update healthcare_raw2
set Hospital = concat(substring(Hospital, 5), ' LLC')
Where Hospital like 'LLC %';

Update healthcare_raw2
set Hospital = concat(substring(Hospital, 5), ' Inc')
Where Hospital like 'Inc %';

Update healthcare_raw2
set Hospital = concat(substring(Hospital, 7), ' Group')
Where Hospital like 'Group %';

Update healthcare_raw2
set Hospital = concat(substring(Hospital, 10), ' and Sons')
Where Hospital like 'Sons and %';

Update healthcare_raw2
set Hospital = concat(substring(Hospital, 10), ' and Sons')
Where Hospital like 'and Sons %';

Update healthcare_raw2
set Hospital = concat(trim(substring(Hospital, 6, Length(Hospital)-9)), ' and Sons')
Where Hospital like 'Sons % and';

Update healthcare_raw2
set Hospital = concat(Left(Hospital, Length(Hospital) - 5), ' and Sons')
where Hospital like '% Sons' and Hospital not like '% and Sons';

UPDATE healthcare_raw2
SET Hospital = CONCAT(
    SUBSTRING_INDEX(REPLACE(REPLACE(Hospital, ',', ''), ' and ', ' '), ' ', 1),
    ', ',
    SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(REPLACE(Hospital, ',', ''), ' and ', ' '), ' ', 2), ' ', -1),
    ' and ',
    SUBSTRING_INDEX(REPLACE(REPLACE(Hospital, ',', ''), ' and ', ' '), ' ', -1)
)
WHERE Hospital NOT LIKE '% and Sons'
  AND Hospital NOT LIKE '%-%'
  AND (Hospital LIKE '%,%' OR Hospital LIKE '% and %')
  AND LENGTH(TRIM(REPLACE(REPLACE(Hospital, ',', ''), ' and ', ' '))) 
      - LENGTH(REPLACE(TRIM(REPLACE(REPLACE(Hospital, ',', ''), ' and ', ' ')), ' ', '')) = 2;


select distinct Hospital from healthcare_raw2 order by 1;

select distinct(Insurance_Provider) from healthcare_raw2 order by 1;

Update healthcare_raw2
set Insurance_Provider = 'United Healthcare'
Where Trim(Insurance_Provider) = 'UnitedHealthcare';

select distinct(Billing_Amount) from healthcare_raw2;

select distinct(Admission_Type) from healthcare_raw2;

select distinct(Discharge_Date) from healthcare_raw2;

select distinct(Medication) from healthcare_raw2;

select distinct(Test_Results) from healthcare_raw2;

alter table healthcare_raw2
Modify column Date_of_Admission Date;

Set SQL_SAFE_UPDATES = 0;

Alter Table healthcare_raw2
Modify Column Date_of_Admission DATE;

UPDATE healthcare_raw2
SET Date_of_Admission = STR_TO_DATE(TRIM(Date_of_Admission), '%d-%m-%Y');

select * from healthcare_raw2;

Set SQL_SAFE_UPDATES = 0;

Alter Table healthcare_raw2
Modify Column Discharge_Date DATE;

UPDATE healthcare_raw2
SET Discharge_Date = STR_TO_DATE(TRIM(Discharge_Date), '%d-%m-%Y');

select * from healthcare_raw2;