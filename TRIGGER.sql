create table medical_checkup(
    patient_id number(10),
    blood_group char(3),
    systolic_blood_pressure varchar(10),
    diastolic_blood_pressure varchar(10),
    heart_rate number,
    foreign key(patient_id) references patient(patient_id)
);

insert into medical_checkup(patient_id,blood_group,systolic_blood_pressure,diastolic_blood_pressure,heart_rate) values(2,'A+','110','70',80);
insert into medical_checkup(patient_id,blood_group,systolic_blood_pressure,diastolic_blood_pressure,heart_rate) values(3,'AB+','120','70',100);
insert into medical_checkup(patient_id,blood_group,systolic_blood_pressure,diastolic_blood_pressure,heart_rate) values(5,'B+','80','90',60);
insert into medical_checkup(patient_id,blood_group,systolic_blood_pressure,diastolic_blood_pressure,heart_rate) values(1,'A+','110','70',80);
insert into medical_checkup(patient_id,blood_group,systolic_blood_pressure,diastolic_blood_pressure,heart_rate) values(7,'O+','60','70',90);
insert into medical_checkup(patient_id,blood_group,systolic_blood_pressure,diastolic_blood_pressure,heart_rate) values(9,'AB-','90','80',120);
insert into medical_checkup(patient_id,blood_group,systolic_blood_pressure,diastolic_blood_pressure,heart_rate) values(4,'A+','110','80',112);
insert into medical_checkup(patient_id,blood_group,systolic_blood_pressure,diastolic_blood_pressure,heart_rate) values(8,'O-','120','76',85);
insert into medical_checkup(patient_id,blood_group,systolic_blood_pressure,diastolic_blood_pressure,heart_rate) values(10,'A+','70','92',80);
insert into medical_checkup(patient_id,blood_group,systolic_blood_pressure,diastolic_blood_pressure,heart_rate) values(6,'A+','120','75',90);


---insert trigger
SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER trigger_i
before insert ON medical_checkup 
REFERENCING OLD AS o NEW AS n
FOR EACH ROW
Enable
BEGIN
insert into patient(patient_id) values(:n.patient_id);
END;
/
insert into medical_checkup(patient_id,blood_group,systolic_blood_pressure,diastolic_blood_pressure,heart_rate) values(15,'A+','120','75',90);
select * from patient;
update patient set patient_name='Mr.Roy',doctor_id=1,age=67,height_meter=1.56,weight_kg=67.9 where patient_id=15;
select * from patient;
select * from medical_checkup;


---delete trigger
SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER trigger_d
before delete ON patient
REFERENCING OLD AS o NEW AS n
FOR EACH ROW
ENABLE
BEGIN
delete from medical_checkup where patient_id=:o.patient_id;
END;
/
delete from patient where patient_id=15;
select * from patient;
select * from medical_checkup;

drop trigger trigger_i;
drop trigger trigger_d;

drop table medical_checkup;