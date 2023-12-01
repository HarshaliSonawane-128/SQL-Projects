REM   Script: Employee Data Analysis
REM   Employee Data Analysis 

CREATE TABLE EMPLOYEE 
( 
ENAME VARCHAR2(20) NOT NULL, 
ESRNO VARCHAR2(7) PRIMARY KEY CHECK(LENGTH(ESRNO)=6), 
BDATE DATE, 
ADDRESS VARCHAR2(20), 
SEX CHAR(3) DEFAULT('M'), 
SALARY NUMBER(7) CHECK(SALARY BETWEEN 20000 AND 40000), 
MGRSRNO VARCHAR2(6), 
DNO NUMBER(3) 
);

INSERT INTO EMPLOYEE (ENAME,ESRNO,BDATE,ADDRESS,SEX,SALARY,MGRSRNO,DNO) VALUES ('AJIT NAYAK',133100,to_date('1955-04-25','YYYY-MM-DD'),'73 BOSTON', 'M',35000,'',1);

INSERT INTO EMPLOYEE (ENAME,ESRNO,BDATE,ADDRESS,SEX,SALARY,MGRSRNO,DNO) VALUES ('SATYA',495823,to_date('1966-07-17','YYYY-MM-DD'),'26 FINE OAK', 'M',32770,133100,4);

INSERT INTO EMPLOYEE (ENAME,ESRNO,BDATE,ADDRESS,SEX,SALARY,MGRSRNO,DNO) VALUES ('AJIT BEHERA',315152,to_date('1971-07-09','YYYY-MM-DD'),'10 KALINGA', 'M',32802,133100,3);

INSERT INTO EMPLOYEE (ENAME,ESRNO,BDATE,ADDRESS,SEX,SALARY,MGRSRNO,DNO) VALUES ('UMASHANKAR',216852,to_date('1967-07-17','YYYY-MM-DD'),'26 FINE OAK', 'M',32770,133100,2);

INSERT INTO EMPLOYEE (ENAME,ESRNO,BDATE,ADDRESS,SEX,SALARY,MGRSRNO,DNO) VALUES ('BHAGWAT',215152,to_date('1971-03-23','YYYY-MM-DD'),'55 FLORIDA', 'M',32802,216852,2);

INSERT INTO EMPLOYEE (ENAME,ESRNO,BDATE,ADDRESS,SEX,SALARY,MGRSRNO,DNO) VALUES ('MEENAKSHI',334548,to_date('1979-04-25','YYYY-MM-DD'),'73 BRIKLY', 'F',25125,315152,3);

INSERT INTO EMPLOYEE (ENAME,ESRNO,BDATE,ADDRESS,SEX,SALARY,MGRSRNO,DNO) VALUES ('JASWASI', 215485,to_date('1979-08-12','YYYY-MM-DD'), '17 BOSTON', 'M', 20500, 495823, 4);

INSERT INTO EMPLOYEE (ENAME,ESRNO,BDATE,ADDRESS,SEX,SALARY,MGRSRNO,DNO) VALUES ('NIHAR NAYAK', 334524 ,to_date('1966-12-17','YYYY-MM-DD'), '73 DALLAS', 'M', 29105, 315152, 3);

INSERT INTO EMPLOYEE (ENAME,ESRNO,BDATE,ADDRESS,SEX,SALARY,MGRSRNO,DNO) VALUES ('DEBASMITA', 295485,to_date('1970-04-16','YYYY-MM-DD'), '1 QUEENS LAND', 'F', 20500, 216852, 2);

CREATE TABLE DEPARTMENT 
(DNAME VARCHAR(12) CHECK(DNAME IN ('RESEARCH', 'ADMIN', 'PROJECT', 'ACADEMIC')), 
DNUMBER NUMBER(2) PRIMARY KEY CHECK(DNUMBER BETWEEN 1 AND 4), 
MGRSRNO VARCHAR(6), 
MGRSTARTD DATE);

INSERT INTO DEPARTMENT (DNAME,DNUMBER,MGRSRNO,MGRSTARTD) VALUES ('RESEARCH', 4, 495823, to_date('1999-04-20','YYYY-MM-DD'));

INSERT INTO DEPARTMENT (DNAME,DNUMBER,MGRSRNO,MGRSTARTD) VALUES ('ADMIN', 1, 133100, to_date('1988-01-06','YYYY-MM-DD'));

INSERT INTO DEPARTMENT (DNAME,DNUMBER,MGRSRNO,MGRSTARTD) VALUES ('PROJECT', 2, 216852, to_date('1999-07-17','YYYY-MM-DD'));

INSERT INTO DEPARTMENT (DNAME,DNUMBER,MGRSRNO,MGRSTARTD) VALUES ('ACADEMIC', 3, 315152,to_date('1989-12-20','YYYY-MM-DD'));

CREATE TABLE DEPT_LOCATIONS 
(DNUMBER NUMBER(2) CHECK(DNUMBER BETWEEN 1 AND 4), 
DLOCATION VARCHAR(12) CHECK(DLOCATION IN ('SINGAPORE', 'INDIA', 'QUUENSLAND', 'LONDON')));

INSERT INTO DEPT_LOCATIONS (DNUMBER,DLOCATION) VALUES (2, 'SINGAPORE');

INSERT INTO DEPT_LOCATIONS (DNUMBER,DLOCATION) VALUES (1, 'INDIA' );

INSERT INTO DEPT_LOCATIONS (DNUMBER,DLOCATION) VALUES (4, 'QUUENSLAND' );

INSERT INTO DEPT_LOCATIONS (DNUMBER,DLOCATION) VALUES (3, 'LONDON');

CREATE TABLE PROJECT 
(PNAME VARCHAR(18) CHECK(PNAME IN ('NETWORKING', 'BIO INFORMATICS', 'LINUX')), 
PNUMBER NUMBER(3) PRIMARY KEY, 
PLOCATION VARCHAR(15) CHECK(PLOCATION IN ('KOREA', 'SOUTH AFRICA', 'INDIA')), 
DNUM NUMBER(2));

INSERT INTO PROJECT (PNAME,PNUMBER,PLOCATION,DNUM) VALUES ('NETWORKING', 11 ,'KOREA', 4);

INSERT INTO PROJECT (PNAME,PNUMBER,PLOCATION,DNUM) VALUES ('BIO INFORMATICS', 19, 'SOUTH AFRICA', 3);

INSERT INTO PROJECT (PNAME,PNUMBER,PLOCATION,DNUM) VALUES ('LINUX', 17, 'INDIA', 2 );

CREATE TABLE WORKS_ON 
(ESRNO VARCHAR(6), 
PNO NUMBER(3) CHECK(PNO>0), 
HOURS DECIMAL(5,2) CHECK(HOURS>0));

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (315152, 19, 1.25) ;

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (334548, 19, 3.28) ;

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (215485, 17, 1.25) ;

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (295485, 17, 5.35) ;

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (334548, 19, 2.54) ;

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (295485, 17, 7.2) ;

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (216852, 17, 2.41);

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (334524, 19, 3.24) ;

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (295485, 17, 1.36) ;

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (495823, 11, 2.36) ;

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (215152, 17, 1.25) ;

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (495823,11, 3.14) ;

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (315152,19, 2.05) ;

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (334548, 19, 2.5) ;

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (495823, 11, 5.27);

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (215152, 17, 2.32) ;

INSERT INTO WORKS_ON (ESRNO,PNO,HOURS) VALUES (495823, 11, 4.15) ;

ALTER TABLE EMPLOYEE 
ADD CONSTRAINT FK_MGRSRNO 
FOREIGN KEY(MGRSRNO) 
REFERENCES EMPLOYEE(ESRNO)  
ON DELETE CASCADE;

ALTER TABLE EMPLOYEE 
ADD CONSTRAINT FK_DNO 
FOREIGN KEY(DNO) 
REFERENCES DEPARTMENT(DNUMBER) 
ON DELETE CASCADE;

ALTER TABLE DEPARTMENT 
ADD CONSTRAINT FK_MGRSRNO_DEPT 
FOREIGN KEY(MGRSRNO) 
REFERENCES EMPLOYEE(ESRNO) 
ON DELETE CASCADE;

ALTER TABLE DEPT_LOCATIONS 
ADD CONSTRAINT FK_DNUMBER_DEPT_LOCATIONS 
FOREIGN KEY(DNUMBER) 
REFERENCES DEPARTMENT(DNUMBER) 
ON DELETE CASCADE;

ALTER TABLE PROJECT 
ADD CONSTRAINT FK_DNUM_PROJECT 
FOREIGN KEY(DNUM) 
REFERENCES DEPARTMENT(DNUMBER) 
ON DELETE CASCADE;

ALTER TABLE WORKS_ON 
ADD CONSTRAINT FK_ESRNO_WORKS_ON 
FOREIGN KEY(ESRNO) 
REFERENCES EMPLOYEE(ESRNO) 
ON DELETE CASCADE;

ALTER TABLE WORKS_ON 
ADD CONSTRAINT FK_PNO_WORKS_ON 
FOREIGN KEY(PNO) 
REFERENCES PROJECT(PNUMBER) 
ON DELETE CASCADE;

select * from Employee :;

select * from Employee ;

select * from Employee ;

select * from Employee ;

select * from department ;

select * from Employee ;

select * from department ;

select * from Employee ;

select * from DEPARTMENT ;

select * from Employee ;

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;';

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

 select Ename , salary from employee ;

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

 select Ename , salary from employee ;

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

 select Ename , salary from employee ;

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

select Ename , salary from employee ;

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

select Ename , salary from employee ;

select ename  
from employee  
where ename like '%A%';

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

select Ename , salary from employee ;

select ename  
from employee  
where ename like '%A%';

SELECT Ename ,MGRSTARTD   FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE Extract (DAY  from MGRSTARTD )<16 ;

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

select Ename , salary from employee ;

select ename  
from employee  
where ename like '%A%';

SELECT Ename ,MGRSTARTD   FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE Extract (DAY  from MGRSTARTD )<16 ;

Select Ename ,sex from Employee where sex = 'F';

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

select Ename , salary from employee ;

select ename  
from employee  
where ename like '%A%';

SELECT Ename ,MGRSTARTD   FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE Extract (DAY  from MGRSTARTD )<16 ;

Select Ename ,sex from Employee where sex = 'F';

select ename ,salary  
from employee  
where salary = (select Max (salary) from Employee);

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

select Ename , salary from employee ;

select ename  
from employee  
where ename like '%A%';

SELECT Ename ,MGRSTARTD   FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE Extract (DAY  from MGRSTARTD )<16 ;

Select Ename ,sex from Employee where sex = 'F';

select ename ,salary  
from employee  
where salary = (select Max (salary) from Employee);

SELECT Ename , address , DNO ,DNAME FROM Employee A 
inner join department  D 
on e.MGRSRNO = D.MGRSRNO ;

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

select Ename , salary from employee ;

select ename  
from employee  
where ename like '%A%';

SELECT Ename ,MGRSTARTD   FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE Extract (DAY  from MGRSTARTD )<16 ;

Select Ename ,sex from Employee where sex = 'F';

select ename ,salary  
from employee  
where salary = (select Max (salary) from Employee);

SELECT Ename , address , DNO ,DNAME  
FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO ;

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

select Ename , salary from employee ;

select ename  
from employee  
where ename like '%A%';

SELECT Ename ,MGRSTARTD   FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE Extract (DAY  from MGRSTARTD )<16 ;

Select Ename ,sex from Employee where sex = 'F';

select ename ,salary  
from employee  
where salary = (select Max (salary) from Employee);

SELECT Ename , address , DNO ,DNAME  
FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO ;

SELECT Ename , DNAME  
FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE DNAME != 'ACADEMIC';

select Ename , salary from employee ;

select ename  
from employee  
where ename like '%A%';

SELECT Ename ,MGRSTARTD   FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE Extract (DAY  from MGRSTARTD )<16 ;

Select Ename ,sex from Employee where sex = 'F';

select ename ,salary  
from employee  
where salary = (select Max (salary) from Employee);

SELECT Ename , address , DNO ,DNAME  
FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO ;

SELECT Ename , DNAME  
FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE DNAME != 'ACADEMIC';

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

select Ename , salary from employee ;

select ename  
from employee  
where ename like '%A%';

SELECT Ename ,MGRSTARTD   FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE Extract (DAY  from MGRSTARTD )<16 ;

Select Ename ,sex from Employee where sex = 'F';

select ename ,salary  
from employee  
where salary = (select Max (salary) from Employee);

SELECT Ename , address , DNO ,DNAME  
FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO ;

SELECT Ename , DNAME  
FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE DNAME != 'ACADEMIC';

select ename ,plocation  
from employee e 
inner join project p 
on e.DNO = p.DNUM 
WHERE Ename = 'SATYA' ;

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

select Ename , salary from employee ;

select ename  
from employee  
where ename like '%A%';

SELECT Ename ,MGRSTARTD   FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE Extract (DAY  from MGRSTARTD )<16 ;

Select Ename ,sex from Employee where sex = 'F';

select ename ,salary  
from employee  
where salary = (select Max (salary) from Employee);

SELECT Ename , address , DNO ,DNAME  
FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO ;

SELECT Ename , DNAME  
FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE DNAME != 'ACADEMIC';

select ename ,plocation  
from employee e 
inner join project p 
on e.DNO = p.DNUM 
WHERE Ename = 'SATYA' ;

SELECT ENAME ,sex ,hours  
    FROM EMPLOYEE e 
    INNER JOIN  WORKS_ON d  
    on e.ESRNO = d.ESRNO 
WHERE SEX = 'F';

SELECT Ename , SUM(HOURS)  
    FROM FHOURS 
    group by Ename;

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

select Ename , salary from employee ;

select ename  
from employee  
where ename like '%A%';

SELECT Ename ,MGRSTARTD   FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE Extract (DAY  from MGRSTARTD )<16 ;

Select Ename ,sex from Employee where sex = 'F';

select ename ,salary  
from employee  
where salary = (select Max (salary) from Employee);

SELECT Ename , address , DNO ,DNAME  
FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO ;

SELECT Ename , DNAME  
FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE DNAME != 'ACADEMIC';

select ename ,plocation  
from employee e 
inner join project p 
on e.DNO = p.DNUM 
WHERE Ename = 'SATYA' ;

create view fhours AS 
SELECT ENAME ,sex ,hours  
    FROM EMPLOYEE e 
    INNER JOIN  WORKS_ON d  
    on e.ESRNO = d.ESRNO 
WHERE SEX = 'F';

SELECT Ename , SUM(HOURS)  
    FROM FHOURS 
    group by Ename;

select * from Employee ;

select * from DEPARTMENT ;

select * from DEPT_LOCATION ;

SELECT * FROM PROJECTS_ON ;

SELECT * FROM WORKS_ON ;

select Ename , salary from employee ;

select ename  
from employee  
where ename like '%A%';

SELECT Ename ,MGRSTARTD   FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE Extract (DAY  from MGRSTARTD )<16 ;

Select Ename ,sex from Employee where sex = 'F';

select ename ,salary  
from employee  
where salary = (select Max (salary) from Employee);

SELECT Ename , address , DNO ,DNAME  
FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO ;

SELECT Ename , DNAME  
FROM Employee A 
inner join department  D 
on A.MGRSRNO = D.MGRSRNO  
WHERE DNAME != 'ACADEMIC';

select ename ,plocation  
from employee e 
inner join project p 
on e.DNO = p.DNUM 
WHERE Ename = 'SATYA' ;

create view fhours AS 
SELECT ENAME ,sex ,hours  
    FROM EMPLOYEE e 
    INNER JOIN  WORKS_ON d  
    on e.ESRNO = d.ESRNO 
WHERE SEX = 'F';

SELECT Ename , SUM(HOURS)  
    FROM FHOURS 
    group by Ename;

SELECT E.ENAME, E.ESRNO,E.BDATE,E.ADDRESS,E.SEX,E.SALARY,E.MGRSRNO,E.DNO, 
    D.DNAME, D.MGRSTARTD, 
    L.DLOCATION, 
    P.PNAME, P.PNUMBER, P.PLOCATION, sum (w.hours) as TOTAL_W_Hours 
FROM EMPLOYEE E 
    JOIN DEPARTMENT D ON E.DNO = D.DNUMBER 
    JOIN DEPT_LOCATIONS L ON D.DNUMBER = L.DNUMBER 
    JOIN PROJECT P ON L.DNUMBER = P.DNUM 
    LEFT JOIN WORKS_ON W ON P.PNUMBER = W.PNO AND E.ESRNO = W.ESRNO 
WHERE P.PLOCATION = 'SOUTH AFRICA' 
GROUP BY  E.ENAME, E.ESRNO, E.BDATE, E.ADDRESS, E.SEX, E.SALARY, E.MGRSRNO, 
    E.DNO, D.DNAME, D.MGRSTARTD, L.DLOCATION, P.PNAME, P.PNUMBER, P.PLOCATION ;

