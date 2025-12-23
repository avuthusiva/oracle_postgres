select * from emp;

select * from emp
start with mgr is null
connect by prior mgr = empno;

select * from emp
start with mgr is null
connect by prior empno = mgr;

select empno,ename || ' Reports to ' || prior ename mgr_name from emp
start with mgr is null
connect by prior empno =mgr;

select LPAD(ename,length(ename) + (level *2) -2 ) from emp
start with mgr is NULL
CONNECT by PRIOR empno = mgr;

select empno,ename,mgr,prior ename mgr_name from emp
start with mgr is NULL
connect by prior empno = mgr;

select empno,ename,mgr,prior ename mgr_name,level l from emp
start with mgr is NULL
connect by prior empno = mgr;

select empno,ename,mgr,prior ename mgr_name,level l,SYS_CONNECT_BY_PATH(ename,'/') path_ename from emp
start with mgr is NULL
connect by prior empno = mgr;