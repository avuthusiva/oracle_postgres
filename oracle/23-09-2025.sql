create table tags as 
select userid,movieid,tag,TO_DATE('1970-01-01', 'YYYY-MM-DD') + NUMTODSINTERVAL(create_date, 'SECOND') create_date
from 
external 
(
    (
        userid number,
        movieid number,
        tag VARCHAR2(200),
        create_date VARCHAR2(20)
    )
    type oracle_loader
    default directory MY_DIR
    access parameters
    (
        records delimited by newline
        fields terminated by ','
        optionally enclosed by '"'
        missing field values are null
        (
            userid,
            movieid,
            tag,
            create_date
        )
    )LOCATION('tags.csv')
    reject limit UNLIMITED
);

select * from TAGS;

desc tags;

create table ratings as
select userid,movieid,rating,TO_DATE('1970-01-01', 'YYYY-MM-DD') + NUMTODSINTERVAL(create_date, 'SECOND') create_date
from 
external
(
    (
        userid number,
        movieid number,
        rating number(5,2),
        create_date VARCHAR2(20)
    )
    type oracle_loader
    default directory MY_DIR
    access parameters
    (
        records delimited by newline
        fields terminated by ','
        optionally enclosed by '"'
        missing field values are null
        (
            userid,
            movieid,
            rating,
            create_date
        )
    )LOCATION('ratings.csv')
    reject limit UNLIMITED
);

select * from RATINGS;
desc ratings;

create table movies as
select * from 
external
(
    (
        movieid number,
        title VARCHAR2(200),
        genres VARCHAR2(200)
    )
    type oracle_loader
    default directory MY_DIR
    access parameters
    (
        records delimited by newline
        fields terminated by ','
        optionally enclosed by '"'
        missing field values are null
        (
            movieid,
            title,
            genres
        )
    )LOCATION('movies.csv')
    reject limit UNLIMITED
);

select * from dept d,lateral (
select deptno,sum(sal) sum_sal,round(avg(sal),2) avg_sal,max(sal) max_sal,min(sal) min_sal from emp
group by deptno) e
where d.deptno = e.deptno;

create table links as
select * from 
external
(
    (
        movieid number,
        imdbId NUMBER,
        tmdbId NUMBER
    )
    type oracle_loader
    DEFAULT DIRECTORY MY_DIR
    ACCESS PARAMETERS
    (
        records delimited by newline
        fields terminated by ','
        optionally enclosed by '"'
        missing field values are null
        (
            movieid,
            imdbId,
            tmdbId
        )        
    )LOCATION('links.csv')
    reject limit unlimited
);

select * from links;