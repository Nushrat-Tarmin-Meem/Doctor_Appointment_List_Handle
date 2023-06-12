set linesize 300

drop table medicine;
drop table health_issue;
drop table patient;
drop table doctor;

create table doctor(
doctor_id number(10),
doctor_name varchar(20) NOT NULL,
category varchar(20) NOT NULL,
phone_no varchar(15),
address varchar(20),
fees number(10),
primary key(doctor_id)
);

create table patient(
patient_id number(10),
patient_name varchar(20),
doctor_id number(10),
age number(3) CHECK(age>=18),
height_meter number(3,2),
weight_kg number(5,2),
primary key(patient_id),
foreign key(doctor_id) references doctor
);

create table health_issue(
patient_id number(10),
disease varchar(30),
last_vt date,
next_vt date,
foreign key(patient_id) references patient
);

create table medicine(
patient_id number(10),
medicine_name varchar(30),
test_package_amount number(10),
paid_payment number(10),
foreign key(patient_id) references patient
);

alter table patient add bmi_rate number(5);
alter table patient modify bmi_rate number(4,2);
alter table patient rename column bmi_rate to bmi;
alter table patient drop column bmi;