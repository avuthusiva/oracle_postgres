select * from SUPERSTORE;

select * from superstore where order_date between add_months(sysdate,-100) and sysdate;

create table countries(country varchar(50), city varchar(50));

insert into countries values ('HYD','Siva,Reddy');
insert into countries values ('PUNE','Meera,Potdar'); 

commit;

select * from countries;

with cte as
(
    select country,city,regexp_count(city,',') + 1 cnt from countries
)
select country,regexp_substr(city,'[^,]+',1,l) from cte c,
lateral(select level l from dual connect by level <= c.cnt) m;

select sysdate,add_months(sysdate,-6) from dual;

select trunc(sysdate,'MONTH') from dual;

create table brands (category varchar(50), brand_name varchar(50));

insert into brands values ('chocolates', '5-star');
insert into brands values (NULL, 'dairy milk');
insert into brands values (NULL, 'perk');
insert into brands values (NULL, 'eclair');
insert into brands values ('Biscuits', 'Britania');
insert into brands values (NULL, 'good day');
insert into brands values (NULL, 'boost');
commit;

select * from BRANDS;

with cte as 
(
    select category,brand_name,row_number() over(order by null) rn from brands
)
select first_value(category) over(partition by cnt order by category) category,
       brand_name from (
select category,brand_name,count(category) over(order by rn) cnt from cte);

drop table emp_tbl;

CREATE TABLE emp_tbl (id timestamp, empid int);

INSERT INTO emp_tbl VALUES (to_date('2024-01-13 09:25:00','YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO emp_tbl VALUES (to_date('2024-01-13 19:35:00','YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO emp_tbl VALUES (to_date('2024-01-16 09:10:00','YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO emp_tbl VALUES (to_date('2024-01-16 18:10:00','YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO emp_tbl VALUES (to_date('2024-02-11 09:07:00','YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO emp_tbl VALUES (to_date('2024-02-11 19:20:00','YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO emp_tbl VALUES (to_date('2024-02-17 08:40:00','YYYY-MM-DD HH24:MI:SS'), 17);
INSERT INTO emp_tbl VALUES (to_date('2024-02-17 18:04:00','YYYY-MM-DD HH24:MI:SS'), 17);
INSERT INTO emp_tbl VALUES (to_date('2024-03-23 09:20:00','YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO emp_tbl VALUES (to_date('2024-03-23 18:30:00','YYYY-MM-DD HH24:MI:SS'), 10);
commit;

select * from emp_tbl order by 2,1;

select empid,sum(round((extract(hour from t) + extract(minute from t) /60),2)) s from (
select empid,(id-l) t from (
select empid,id,lag(id,1) over(partition by trunc(id) order by id) l from emp_tbl)
where l is not null)
group by empid;

create table tbl_maxval (col1 varchar(50), col2 number, col3 number);

insert into tbl_maxval values ('a',10,20);
insert into tbl_maxval values ('b',50,30);
commit;

select * from TBL_MAXVAL;
select col1,col2,col3, greatest(col2,col3) max_val from tbl_maxval;

