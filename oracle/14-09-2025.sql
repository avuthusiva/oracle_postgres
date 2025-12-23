select * from emp;

declare
    type v_ref_type is ref cursor;
    v_emp_cur v_ref_type;
BEGIN
    open v_emp_cur for select * from emp;
    dbms_sql.return_result(v_emp_cur);  
end;

select e.empno,e.ename,m.empno mempno,m.ename mename from emp e,emp m
where e.mgr = m.empno;

with cte(empno,ename,lvl) as 
(
    select empno,ename,1 lvl from emp
    where mgr is null
    union all
    select e.empno,e.ename|| '->' || c.ename,lvl + 1 from emp e join cte c
    on (e.mgr = c.empno) 
)
select * from cte;