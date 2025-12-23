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
        records delimited by NEWLINE
        skip 1
        FIELDS terminated by ','
        --OPTIONALLY ENCLOSED by '"'
        missing FIELD values are null
        (
            deptno char,
            dname char,
            loc char
        )
    )LOCATION('DEPT.csv')
);

select * from 
external
(
    (
        empno number,
        ename VARCHAR2(30),
        job VARCHAR2(30),
        mgr int,
        hiredate date,
        sal NUMBER,
        comm NUMBER,
        deptno NUMBER
    )
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY MY_DIR
    ACCESS PARAMETERS
    (
        RECORDS DELIMITED BY NEWLINE
        SKIP 1
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        (
            empno char,
            ename char,
            job char,
            mgr char,
            hiredate char DATE_FORMAT DATE MASK "YYYY-MM-DD HH24:MI:SS",
            sal char,
            comm char,
            deptno char
        )
    )LOCATION('EMP.csv')
);

create table mock_data as
select * from 
EXTERNAL
(
    (
        id number,
        first_name VARCHAR2(50),
        last_name VARCHAR2(50),
        email VARCHAR2(200),
        gender VARCHAR2(20),
        ip_address VARCHAR2(30)
    )
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY MY_DIR
    ACCESS PARAMETERS
    (
        RECORDS DELIMITED BY NEWLINE
        SKIP 1
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        (
            id,
            first_name,
            last_name,
            email,
            gender,
            ip_address
        )
    )LOCATION('MOCK_DATA.csv')
);

select * from MOCK_DATA;

create table customers as 
select * from 
EXTERNAL
(
    (
        customer_id NUMBER,
        gender VARCHAR2(20),
        age NUMBER,
        annual_income NUMBER,
        spend_score NUMBER,
        profession VARCHAR2(30),
        work_experience NUMBER,
        family_size NUMBER
    )
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY MY_DIR
    ACCESS PARAMETERS
    (
        RECORDS DELIMITED BY NEWLINE
        SKIP 1
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        (
            customer_id,
            gender,
            age,
            annual_income,
            spend_score,
            profession,
            work_experience,
            family_size
        )
    )LOCATION('Customers.csv')
);

select * from CUSTOMERS;

select GENDER,count(*) cnt from CUSTOMERS
GROUP BY GENDER;

select profession,count(*) cnt from customers
group by profession;

create table superstore as 
select * from 
EXTERNAL
(
    (
        row_id NUMBER,
        order_id VARCHAR2(20),
        order_date DATE,
        ship_date DATE,
        ship_mode VARCHAR(30),
        customer_id VARCHAR2(20),
        customer_name VARCHAR2(100),
        segment VARCHAR2(20),
        country VARCHAR2(100),
        city VARCHAR2(100),
        state VARCHAR2(100),
        postcode VARCHAR2(10),
        region VARCHAR2(20),
        product_id VARCHAR2(25),
        category VARCHAR2(50),
        sub_category VARCHAR2(50),
        product_name VARCHAR2(500),
        sales NUMBER(10,4),
        quantity NUMBER,
        discount NUMBER(6,2),
        profit NUMBER(10,4)
    )
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY MY_DIR
    ACCESS PARAMETERS
    (
        RECORDS DELIMITED BY NEWLINE
        SKIP 1
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        (
            row_id,
            order_id,
            order_date char DATE_FORMAT DATE MASK "MM/DD/YYYY",
            ship_date char DATE_FORMAT DATE MASK "MM/DD/YYYY",
            ship_mode,
            customer_id,
            customer_name,
            segment,
            country,
            city,
            state,
            postcode,
            region,
            product_id,
            category,
            sub_category,
            product_name,
            sales,
            quantity,
            discount,
            profit
        )
    )LOCATION('Superstore.csv')
    reject limit unlimited
);

select * from superstore order by 1 desc;

drop table usredata;

create table userdata as 
select TO_TIMESTAMP(translate(registration_dttm,'TZ',' '),'YYYY-MM-DD HH24:MI:SS') registration_dttm,
id,first_name,last_name,email,gender,ip_address,cc,country,birth_date,salary,title,comments
from 
EXTERNAL
(
    (
        registration_dttm VARCHAR2(25),
        id NUMBER,
        first_name VARCHAR2(50),
        last_name VARCHAR2(50),
        email VARCHAR2(200),
        gender VARCHAR2(20),
        ip_address VARCHAR2(20),
        cc VARCHAR2(50),
        country VARCHAR2(50),
        birth_date DATE,
        salary NUMBER(10,2),
        title VARCHAR2(100),
        comments VARCHAR2(1000)
    )
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY MY_DIR
    ACCESS PARAMETERS
    (
        RECORDS DELIMITED BY NEWLINE
        SKIP 1 
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        (
            registration_dttm,
            id,
            first_name,
            last_name,
            email,
            gender,
            ip_address,
            cc,
            country,
            birth_date char DATE_FORMAT DATE MASK "MM/DD/YYYY",
            salary,
            title,
            comments
        )
    )LOCATION('userdata1.csv','userdata2.csv','userdata3.csv','userdata4.csv','userdata5.csv')
    reject limit unlimited
);

select gender,count(*) cnt from userdata
group by gender;

desc userdata;

select * from tab;

select * from superstore;

create table movies as 
select movie_id,movie_title,release_year,runtime,TO_NUMBER(TRANSLATE(budget,'$,',' ')) budget,
TO_NUMBER(TRANSLATE(boxoffice,'$,',' ')) boxoffice
from 
EXTERNAL
(
    (
        movie_id NUMBER,
        movie_title VARCHAR2(100),
        release_year NUMBER,
        runtime NUMBER,
        budget VARCHAR2(20),
        boxoffice VARCHAR2(20)
    )
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY MY_DIR
    ACCESS PARAMETERS
    (
        RECORDS DELIMITED BY NEWLINE
        SKIP 1
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
        MISSING FIELD VALUES ARE NULL
        (
            movie_id,
            movie_title,
            release_year,
            runtime,
            budget,
            boxoffice
        )
    )LOCATION('Movies.csv')
);

select * from MOVIES;

desc movies;

create table Chapters as 
select * from 
EXTERNAL
(
    (
        chapter_id NUMBER,
        chapter_name VARCHAR2(100),
        movie_id NUMBER,
        movie_chapter NUMBER
    )
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY MY_DIR
    ACCESS PARAMETERS
    (
        RECORDS DELIMITED BY NEWLINE
        SKIP 1
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        (
            chapter_id,
            chapter_name,
            movie_id,
            movie_chapter
        )
    )LOCATION('Chapters.csv')
    reject limit unlimited
);

select * from CHAPTERS;

create table Characters as 
select * from 
EXTERNAL
(
    (
        chapter_id NUMBER,
        chapter_name VARCHAR2(50),
        species VARCHAR2(50),
        gender VARCHAR2(20),
        house VARCHAR2(50),
        patronus VARCHAR2(50),
        wand_wood VARCHAR2(50),
        wand_core VARCHAR2(50)
    )
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY MY_DIR
    ACCESS PARAMETERS
    (
        RECORDS DELIMITED BY NEWLINE
        SKIP 1
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        (
            chapter_id,
            chapter_name,
            species,
            gender,
            house,
            patronus,
            wand_wood,
            wand_core
        )
    )LOCATION('Characters.csv')
);

select * from CHARACTERS;

create table Dialogue as 
select * from 
EXTERNAL
(
    (
        dialogue_id NUMBER,
        chapter_id NUMBER,
        place_id NUMBER,
        character_id NUMBER,
        dialogue VARCHAR2(1000)
    )
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY MY_DIR
    ACCESS PARAMETERS
    (
        RECORDS DELIMITED BY NEWLINE
        SKIP 1
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
        MISSING FIELD VALUES ARE NULL
        (
            dialogue_id,
            chapter_id,
            place_id,
            character_id,
            dialogue
        )
    )LOCATION('Dialogue.csv')
    reject limit unlimited
) order by  1;

select * from DIALOGUE;

create table places as 
select * from 
EXTERNAL
(
    (
        place_id NUMBER,
        place_name VARCHAR2(100),
        place_category VARCHAR2(50)
    )
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY MY_DIR
    ACCESS PARAMETERS 
    (
        RECORDS DELIMITED BY NEWLINE
        SKIP 1
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        (
            place_id,
            place_name,
            place_category
        )
    )LOCATION('Places.csv')
);

select * from places;

create table spells as
select * from 
EXTERNAL
(
    (
        spell_id NUMBER,
        Incantation VARCHAR2(50),
        spell_name VARCHAR2(100),
        effect VARCHAR2(200),
        light VARCHAR2(50)
    )
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY MY_DIR
    ACCESS PARAMETERS
    (
        RECORDS DELIMITED BY NEWLINE
        SKIP 1
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        (
            spell_id,
            Incantation,
            spell_name,
            effect,
            light
        )
    )LOCATION('Spells.csv')
);

select * from spells;

select * from tab;
