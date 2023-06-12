---PL/SQL variable declaration and printing value
set serveroutput on
declare
    id doctor.doctor_id%type;
    name doctor.doctor_name%type;
    location doctor.address%type;
    payment doctor.fees%type;
    begin
    select doctor_id,doctor_name,address,fees into id,name,location,payment from doctor where doctor_id=2;
    dbms_output.put_line('Doctor_Info   Id:' || id || '   Name:'|| name || '   Location:' || location|| '   Payment:'|| payment );
    end;
    /


---Insertion and setting of default value
set serveroutput on
declare
    id doctor.doctor_id%type:=11;
    category doctor.category%type:='Cardiologist';
    name doctor.doctor_name%type:='Dr.Diana';
    phone doctor.phone_no%type:='01893266744';
    location doctor.address%type:='Mumbai';
    payment doctor.fees%type:=9000;
    begin
    insert into doctor values(id,name,category,phone,location,payment);
    end;
    /

---Cursor use and Row Count
set serveroutput on
declare
    cursor doctor_cursor is select * from doctor;
    doctor_row doctor%rowtype;
    begin
    open doctor_cursor;
    fetch doctor_cursor into doctor_row.doctor_id, doctor_row.doctor_name, doctor_row.category, doctor_row.phone_no,doctor_row.address, doctor_row.fees;
    while doctor_cursor%found loop
    dbms_output.put_line('ID:'||doctor_row.doctor_id||'  Name:'|| doctor_row.doctor_name||'  Category:'|| doctor_row.category||'  Phone:'|| doctor_row.phone_no||'  Address:'||doctor_row.address|| '  Fees:'||doctor_row.fees);
    dbms_output.put_line('Row Number: '||doctor_cursor%rowcount);
    fetch doctor_cursor into doctor_row.doctor_id, doctor_row.doctor_name, doctor_row.category, doctor_row.phone_no,doctor_row.address, doctor_row.fees;
    end loop;
    close doctor_cursor;
    end;
    /

alter table medicine add due_payment number(20);
select * from medicine;

---use of cursor and loop
 set serveroutput on
 declare
        cursor medicine_cursor is select * from medicine;
        medicine_row medicine%rowtype;
        begin
        open medicine_cursor;
        fetch medicine_cursor into medicine_row.patient_id, medicine_row.medicine_name, medicine_row.test_package_amount, medicine_row.paid_payment, medicine_row.due_payment;
        while medicine_cursor%found loop
        medicine_row.due_payment := medicine_row.test_package_amount-medicine_row.paid_payment;
        dbms_output.put_line('Patient_Id:'|| medicine_row.patient_id||'  Medicine_Name:' || medicine_row.medicine_name ||'  Test_Pack_Amount:'|| medicine_row.test_package_amount ||'  Paid:'|| medicine_row.paid_payment ||'  Due:'|| medicine_row.due_payment);
        dbms_output.put_line('Row Number: '||medicine_cursor%rowcount);        
        fetch medicine_cursor into medicine_row.patient_id, medicine_row.medicine_name, medicine_row.test_package_amount, medicine_row.paid_payment, medicine_row.due_payment;
        end loop;
        close medicine_cursor;
        end;
        /

select * from medicine;

set serveroutput on
 declare
        cursor medicine_cursor is select * from medicine;
        medicine_row medicine%rowtype;
        begin
        open medicine_cursor;
        fetch medicine_cursor into medicine_row.patient_id, medicine_row.medicine_name, medicine_row.test_package_amount, medicine_row.paid_payment, medicine_row.due_payment;
        while medicine_cursor%found loop
        update medicine set medicine.due_payment = medicine.test_package_amount-medicine.paid_payment;   
        fetch medicine_cursor into medicine_row.patient_id, medicine_row.medicine_name, medicine_row.test_package_amount, medicine_row.paid_payment, medicine_row.due_payment;
        end loop;
        close medicine_cursor;
        end;
        /
        select * from medicine;



alter table patient add bmi number(5,2);
select * from patient;

set serveroutput on
 declare
        cursor patient_cursor is select * from patient;
        patient_row patient%rowtype;
        begin
        open patient_cursor;
        fetch patient_cursor into patient_row.patient_id, patient_row.patient_name, patient_row.doctor_id, patient_row.age, patient_row.height_meter, patient_row.weight_kg ,patient_row.bmi;
        while patient_cursor%found loop
        update patient set patient.bmi = patient.weight_kg/(patient.height_meter*patient.height_meter);   
        fetch patient_cursor into patient_row.patient_id, patient_row.patient_name, patient_row.doctor_id, patient_row.age, patient_row.height_meter, patient_row.weight_kg ,patient_row.bmi;
        end loop;
        close patient_cursor;
        end;
        /
        select * from patient;

select patient_name,bmi as Perfect_BMI_Rate from patient where bmi>=18.0 and bmi<=24.0;


set serveroutput on
declare
    cursor doctor_cursor is select * from doctor;
    doctor_row doctor%rowtype;
    begin
    open doctor_cursor;
    fetch doctor_cursor into doctor_row.doctor_id, doctor_row.doctor_name, doctor_row.category, doctor_row.phone_no,doctor_row.address, doctor_row.fees;
    while doctor_cursor%found loop
    if doctor_row.doctor_id=(select doctor_id from patient where patient_id in (select patient_id from medicine where due_payment>1000))
    then
	dbms_output.put_line('Name:'|| doctor_row.doctor_name);
    end if;
    fetch doctor_cursor into doctor_row.doctor_id, doctor_row.doctor_name, doctor_row.category, doctor_row.phone_no,doctor_row.address, doctor_row.fees;
    end loop;
    close doctor_cursor;
    end;
    /


select * from medicine;
---select doctor_name from doctor where doctor_id in(select doctor_id from patient where patient_id in (select patient_id from medicine where due_payment>1000));

---lab_test
set serveroutput on
 declare
        id doctor.doctor_id%type;
        name doctor.doctor_name%type;
        cursor medicine_cursor is select * from medicine;
        medicine_row medicine%rowtype;
        begin
        open medicine_cursor;
        fetch medicine_cursor into medicine_row.patient_id, medicine_row.medicine_name, medicine_row.test_package_amount, medicine_row.paid_payment, medicine_row.due_payment;
        while medicine_cursor%found loop
        if  medicine_row.due_payment>1500
        then
        --dbms_output.put_line('Patient_ID:'|| medicine_row.patient_id);        
        select doctor_id into id from patient where patient_id=medicine_row.patient_id;
        --dbms_output.put_line('Doctor_ID:'|| id);
        select doctor_name into name from doctor where doctor_id=id;
        dbms_output.put_line('Doctor_Name:'|| name);          
        end if;
        fetch medicine_cursor into medicine_row.patient_id, medicine_row.medicine_name, medicine_row.test_package_amount, medicine_row.paid_payment, medicine_row.due_payment;
        end loop;
        close medicine_cursor;
        end;
        /


---array and loop
set serveroutput on
declare
   counter number := 1;
   d_name doctor.doctor_name%type;
   type namearray is varray(11) of doctor.doctor_name%type;
   a_name namearray:=namearray('D1', 'D2', 'D3', 'D4', 'D5', 'D6','D7','D8','D9', 'D10','D11'); 
begin
   counter := 1;
   for x in 1..11  
   loop
      select doctor_name into d_name from doctor where doctor_id=x;
      a_name(counter) := d_name;
      counter := counter + 1;
   end loop;
   counter := 1;
   while counter <= a_name.count
   loop
      dbms_output.put_line('Name:' || a_name(counter)); 
      counter := counter + 1;
   end loop;
end;
/




---if elsif
set serveroutput on
declare
   counter number := 1;
   d_name doctor.doctor_name%type;
   d_category doctor.category%type;
begin
   counter := 1;
   for x in 1..11  
   loop
      select doctor_name into d_name from doctor where doctor_id=x;
      select category into d_category from doctor where doctor_id=x;
      if d_category='Cardiologist'
       then
	dbms_output.put_line(d_name||' is a '||'Cardiologist');
      elsif d_category='Neurologist'
	then
	dbms_output.put_line(d_name||' is a '||'Neurologist');
	else
        dbms_output.put_line(d_name||' is a '||'Specialist');
	end if;
	counter := counter + 1;
   end loop;
end;
/



---function
set serveroutput on
create function fun(id in varchar) return varchar AS
value doctor.doctor_name%type;
begin
  select doctor_name into value from doctor where doctor_id = id; 
   return value;
end;
/

set serveroutput on
declare 
name varchar(20);
begin
name:=fun(5);
dbms_output.put_line('D_Name of id 5: ' || name);
end;
/
drop function fun;
