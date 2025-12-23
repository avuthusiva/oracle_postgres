create table pan_validation_0 as 
select * from 
EXTERNAL
(
    (
    Pan_Numbers VARCHAR2(20)
)
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY MY_DIR
    ACCESS PARAMETERS
    (
     RECORDS DELIMITED BY '\r\n'   
     SKIP 1
     FIELDS TERMINATED BY ','
     OPTIONALLY ENCLOSED BY '"'
     MISSING FIELD VALUES ARE NULL
     (
        Pan_Numbers CHAR
     )
    )LOCATION('PAN_Number_validation.csv')
    REJECT LIMIT UNLIMITED
);

create table PAN_VALIDATION_1 as
select * from ( 
select DISTINCT upper(trim(PAN_NUMBERS)) PAN_NUMBERS from PAN_VALIDATION_0 where PAN_NUMBERS is not null)
where length(PAN_NUMBERS) = 10;

select PAN_NUMBERS from PAN_VALIDATION_1;

create table PAN_VALIDATION as (
select first_str || mid_str || last_str pan_number from (   
select regexp_substr(first_str,'[A-Z]+',1) first_str,
       regexp_substr(mid_str,'[0-9]+',1) mid_str,
       regexp_substr(last_str,'[A-Z]',1) last_str from (
select substr(Pan_Numbers,1,5) first_str,substr(Pan_Numbers,6,4) mid_str,substr(Pan_Numbers,-1,1) last_str 
from PAN_VALIDATION_1))
where length(first_str || mid_str || last_str) = 10);

select upper(PAN_NUMBERS),length(PAN_NUMBERS) from 
PAN_VALIDATION p1 full join PAN_VALIDATION_0 p2 on (p1.PAN_NUMBER = upper(p2.PAN_NUMBERS))
where PAN_NUMBER is null
and length(PAN_NUMBERS) = 10;

select * from users;

desc users;