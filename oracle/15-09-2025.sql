use role accountadmin;
use warehouse my_warehouse;
use schema my_db.my_schema;
select * from emp;
with cte as
(
    select empno,ename,1 lvl from emp
    where mgr is null
    union all
    select e.empno,c.ename || '->' || e.ename,lvl + 1 from emp e join cte c
    on (e.mgr = c.empno)
)
select * from cte;