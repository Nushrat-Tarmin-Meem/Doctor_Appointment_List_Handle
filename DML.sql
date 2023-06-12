insert into doctor values(1,'Dr.Hina','Cardiologist','01782366744','Dhaka',1000);
insert into doctor values(2,'Dr.Himel','Surgeon','01782366731','Pune',5000);
insert into doctor values(3,'Dr.Auishi','Cardiologist','01782366244','Khulna',1000);
insert into doctor values(4,'Dr.Manya','Neurologist','01782366744','Dhaka',8000);
insert into doctor values(5,'Dr.Tisa','Psychiatrist','01732366744','Dhaka',1500);
insert into doctor values(6,'Dr.Sishir','Radiologist','01782366722','Rangpur',1000);
insert into doctor values(7,'Dr.Ritu','Cardiologist','01782146744','Dhaka',2000);
insert into doctor values(8,'Dr.Titu','Urologist','01382366744','Rangamati',500);
insert into doctor values(9,'Dr.Hiya','Neurologist','01782322744','Dhaka',7000);
insert into doctor values(10,'Dr.Mila','Pediatrician','01782366744','Dhaka',800);


insert into patient values(1,'Mr.Rahim',   2,  58,  1.53,  62.5);
insert into patient values(2,'Mr.Farooq',  2,  43,  1.57,  65.5);
insert into patient values(3,'Mrs.Rahima', 3,  38,  1.52,  60.5);
insert into patient values(4,'Mr.Ram',     1,  39,  1.57,  67.5);
insert into patient values(5,'Mr.Fahim',   4,  51,  1.53,  61.5);
insert into patient values(6,'Ms.Riya',    2,  50,  1.63,  63.5);
insert into patient values(7,'Ms.Rattri',  5,  54,  1.53,  77.5);
insert into patient values(8,'Mr.Kafi',    8,  56,  1.61,  62.0);
insert into patient values(9,'Mr.Rahat',   7,  43,  1.43,  61.0);
insert into patient values(10,'Ms.Keya',   7,  19,  1.93,  52.5);


insert into health_issue values(5,'Brain Tumor', date '2022-06-13', date '2023-01-13');
insert into health_issue values(1,'Coronary Heart Disease', date '2021-06-13', date '2021-08-13');
insert into health_issue values(6,'Brain Tumor', date '2022-08-13', date '2023-01-13');
insert into health_issue values(2,'Coronary Heart Disease', date '2020-06-13', date '2023-01-13');
insert into health_issue values(7,'Extra Hyper', date '2022-04-18', date '2023-01-18');
insert into health_issue values(9,'Brain Tumor', date '2022-06-13', date '2023-01-13');
insert into health_issue values(3,'Heart Attack', date '2022-09-13', date '2023-02-13');
insert into health_issue values(4,'Aortic Disease', date '2022-06-13', date '2023-01-13');
insert into health_issue values(10,'Brain Tumor', date '2022-06-13', date '2023-01-13');
insert into health_issue values(8,'CKD', date '2022-06-13', date '2023-01-13');


insert into medicine values(1,'Beta-Blockers',10000,8000);
insert into medicine values(5,'Afinitor',8000,8000);
insert into medicine values(10,'Avastin',10000,10000);
insert into medicine values(9,'Carmustine',12000,10000);
insert into medicine values(8,'Zyloprim',8000,8000);
insert into medicine values(2,'Beta-Blockers',10000,8000);
insert into medicine values(3,'Beta-Blockers',15000,14500);
insert into medicine values(4,'Beta-Blockers',10000,9500);
insert into medicine values(7,'Tiptin 500mg',7000,7000);
insert into medicine values(6,'Alymsys',10000,8800);

select * from doctor;
select * from patient;
select * from health_issue;
select * from medicine;


select * from doctor where fees>1000;

select doctor_name from doctor where doctor_id=(select doctor_id from patient where patient_id=(select patient_id from medicine where medicine_name='Alymsys'));

update health_issue set disease='Coronary Kidney Disease' where disease='CKD';

insert into medicine values(1,'xsdf',4000,23000);
select * from medicine;
delete from medicine where paid_payment>test_package_amount;
select * from medicine;

select medicine_name from medicine where medicine_name like 'B%' union select medicine_name from medicine where medicine_name like '%s';

select medicine_name from medicine where medicine_name like 'B%' intersect select medicine_name from medicine where medicine_name like '%s';

select count(*) as total_no_of_doctors from doctor;

select count(medicine_name) as no_of_medicines from medicine;

select count(distinct medicine_name) as no_of_medicines from medicine;

select sum(paid_payment) as income_from_test_package from medicine;

select avg(fees) as average_fees_of_doctor from doctor;

select doctor_name,fees from doctor where fees=(select max(fees) from doctor);

select doctor_name,fees from doctor where fees=(select min(fees) from doctor);

select doctor_name,fees from doctor where fees=(select min(fees) from doctor where fees!=(select min(fees) from doctor));

select category,avg(fees) from doctor group by category having avg(fees)>1000;

select category,avg(fees) from doctor group by category having avg(fees)>=1500;

select address,avg(fees) from doctor group by address;

select * from patient where doctor_id in (select doctor_id from doctor where category='Cardiologist') and patient_id in (select patient_id from medicine where medicine_name like 'B%');

select * from doctor where fees>some(5000);

select * from doctor where fees>all(3000);

select patient_name from patient where doctor_id in (select doctor_id from doctor where category like 'Cardiologist') and patient_id in (select patient_id from health_issue where disease='Brain Tumor');

select * from doctor natural join patient where doctor_id=2;

select doctor_name,patient_name from doctor join patient using(doctor_id);

select * from doctor join patient using(doctor_id);

select doctor_name,patient_name from doctor left outer join patient using(doctor_id);

select doctor_name,patient_name from doctor right outer join patient using(doctor_id);





