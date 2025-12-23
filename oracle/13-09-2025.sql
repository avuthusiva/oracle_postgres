select * from USER_TABLES;

select * from all_users;

create table dept as 
select * from 
external
(
    (
        deptno number,
        dname VARCHAR2(30),
        loc VARCHAR2(30)
    )
    type oracle_loader
    default directory my_dir
    access parameters
    (
        records delimited by '\r\n'
        skip 1
        FIELDS terminated by ','
        OPTIONALLY ENCLOSED by '"'
        missing FIELD values are null
        (
            deptno char,
            dname char,
            loc char
        )
    )LOCATION('DEPT.csv')
    reject limit unlimited
);

select * from dept;

select * from 
EXTERNAL
(
    (
        empno NUMBER,
        ename VARCHAR2(30),
        job VARCHAR2(30),
        mgr NUMBER,
        hiredate date,
        sal NUMBER,
        comm NUMBER,
        deptno NUMBER
    )
    type oracle_loader
    default directory my_dir
    access PARAMETERS
    (
        records delimited by '\r\n'
        skip 1
        FIELDS terminated by ','
        OPTIONALLY ENCLOSED by '"'
        missing FIELD values are null
        (
            empno char,
            ename char,
            job char,
            mgr char,
            hiredate char date_format date mask "YYYY-MM-DD HH24:MI:SS",
            sal char,
            comm char,
            deptno char 
        )
    )LOCATION('EMP.csv')
    reject LIMIT UNLIMITED
);

create table emp as 
select * from 
external
(
    (
        empno number,
        ename VARCHAR2(30),
        job VARCHAR2(30),
        mgr number,
        hiredate date,
        sal number,
        comm number,
        deptno number
    )
    type oracle_loader
    default directory my_dir
    access parameters
    (
        /*records delimited by '\r\n'
        skip 1
        FIELDS terminated by ','
        OPTIONALLY ENCLOSED by '"'
        missing FIELD values are null*/
        RECORDS DELIMITED BY newline
        skip 1
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        (
            empno,
            ename,
            job,
            mgr,
            hiredate   CHAR(21) DATE_FORMAT DATE MASK "YYYY-MM-DD HH24:MI:SS",
            sal,
            comm,
            deptno 
                )
    )LOCATION('EMP.csv')
    reject limit unlimited
);


CREATE TABLE emp_ext (
 EMPNO     NUMBER(4),
 ENAME     VARCHAR2(10),
 JOB       VARCHAR2(9),
 MGR       NUMBER(4),
 HIREDATE  DATE,
 SAL       NUMBER(7,2),
 COMM      NUMBER(7,2),
 DEPTNO    NUMBER(2)
)
ORGANIZATION EXTERNAL
(
  TYPE ORACLE_LOADER
  DEFAULT DIRECTORY my_dir
  ACCESS PARAMETERS
  (
    RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ','
    MISSING FIELD VALUES ARE NULL
    (
      empno,
      ename,
      job,
      mgr,
      hiredate   CHAR(21) DATE_FORMAT DATE MASK "YYYY-MM-DD HH24:MI:SS",
      sal,
      comm,
      deptno 
    )
  )
  LOCATION ('EMP.csv')
)
PARALLEL 1
REJECT LIMIT UNLIMITED;

select * from emp_ext;

drop table emp_ext;

select * from emp;

declare
    v_emp_cur SYS_REFCURSOR;
BEGIN
    open v_emp_cur for select * from emp;
    dbms_sql.RETURN_RESULT(v_emp_cur);
end;

declare
    v_emp_cur   SYS_REFCURSOR;
    v_cnt       SYS_REFCURSOR;
BEGIN
    open v_cnt for select count(*) from emp;
    dbms_sql.RETURN_RESULT(v_cnt);
    --close v_cnt;
    open v_emp_cur for select * from emp;
    dbms_sql.RETURN_RESULT(v_emp_cur);
    --close v_emp_cur;
end;