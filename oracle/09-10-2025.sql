create table dept as
select * from 
external
(
    (
        deptno number,
        dname varchar2(14),
        loc varchar2(13)
    )
    type oracle_loader
    default directory my_dir
    access parameters
    (
        records delimited by newline
        skip 1
        fields terminated by ','
        missing field values are null
        (
            deptno,
            dname,
            loc
        )
    )LOCATION('DEPT.csv')
    reject limit unlimited
);

select * from dept;

create table emp as
select * from 
external
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
    access parameters
    (
        records delimited by newline
        skip 1
        fields terminated by ','
        missing field values are null
        (
            empno,
            ename,
            job,
            mgr,
            hiredate char date_format date mask 'YYYY-MM-DD HH24:MI:SS',
            sal,
            comm,
            deptno
        )
    )LOCATION('EMP.csv')
    reject limit unlimited
);

select * from emp;

create table customers as
select * from 
external 
(
    (
        customer_id NUMBER,
        gender varchar(20),
        age number,
        annual_income number,
        spending_score number,
        profession varchar(50),
        experience number,
        family_size number
    )
    type oracle_loader
    default directory my_dir
    access parameters
    (
        records delimited by newline
        skip 1
        fields terminated by ','
        missing field values are null
        (
            customer_id,
            gender,
            age,
            annual_income,
            spending_score,
            profession,
            experience,
            family_size
    ))LOCATION('Customers.csv')
    reject limit unlimited
);

select * from customers;

create table mock_data as
select * from 
external
(
    (
        id NUMBER,
        first_name VARCHAR2(50),
        last_name VARCHAR2(50),
        email VARCHAR2(100),
        gender VARCHAR2(10),
        ip_address VARCHAR2(20)
    )
    type oracle_loader
    default directory my_dir
    access parameters
    (
        records delimited by newline
        skip 1
        fields terminated by ','
        missing field values are null
        (
            id,
            first_name,
            last_name,
            email,
            gender,
            ip_address
    ))
    LOCATION('MOCK_DATA.csv')
    reject limit unlimited
);

select count(*) from mock_data;

