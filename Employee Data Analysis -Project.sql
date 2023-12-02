/* 1. List the salary of all the employees.   */
 select Ename ,salary from Employee;
 
 /* 2.Display the names of all employees with any “A” at any place of the name. */
SELECT Ename
FROM Employee 
WHERE Ename LIKE " %A% " ;

/*3. Show all employees who were hired in the first half of the month (Before the 16th of the month). */
SELECT Ename ,MGRSTARTD   
FROM Employee A
inner join department  D
on A.MGRSRNO = D.MGRSRNO 
WHERE Extract (DAY  from MGRSTARTD ) <16 ;

/*4. Display the name of all female employees */
 Select Ename ,sex from Employee where sex = 'F';
 
 /*5. Display the employee who is paid most in the company.*/
select ename ,salary 
from employee 
where salary = (select Max (salary) from Employee);

/*6. Display employee name, address, department no and department name. */
SELECT Ename , address , DNO ,DNAME 
FROM Employee A
inner join department  D
on A.MGRSRNO = D.MGRSRNO ;

/* 7.Display all the employees who are not in ACADEMIC department */ 
SELECT Ename , DNAME 
FROM Employee A
inner join department  D
on A.MGRSRNO = D.MGRSRNO 
WHERE DNAME != 'ACADEMIC';

/*8. Display SATYAS’ project location */
select ename ,plocation 
from employee e
inner join project p
on e.DNO = p.DNUM
WHERE Ename = 'SATYA'

/* 9.Find the total working hours of each female employee */ 
create view fhours AS
SELECT ENAME ,sex ,hours 
    FROM EMPLOYEE e
    INNER JOIN  WORKS_ON d 
    on e.ESRNO = d.ESRNO
WHERE SEX = 'F';

SELECT Ename , SUM(HOURS) 
    FROM FHOURS
    group by Ename;

/* 10. Display the details of the people whose projects are located at SOUTH Africa */
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

