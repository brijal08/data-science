
use ltcnov21;

show tables;

create table dept 
( deptid integer primary key,
deptname varchar(20) unique
);

insert into dept values(10, 'HR');
insert into dept values(10, 'HR'); -- PK error
insert into dept values(20, 'HR'); -- UNique value error
insert into dept values(20, 'Sales');
insert into dept values(30, NULL);
insert into dept values(40, NULL);

select * from dept
order by deptid;

create table emp(
eid integer primary key,
ename varchar(10),
city varchar(15) default 'Bangalore',
age integer,
check (age>=20 and age<=50)
);

insert into emp(eid, ename, age) values ( 1, 'a',25);
insert into emp(eid, ename, age) values ( 2, 'b',35);
insert into emp(eid, ename, city, age) values ( 3, 'c','Chennai',35);
select * from emp;

use hr;

show tables;


select * from employees;

-- select specific columns
select employee_id, first_name, salary, department_id , job_id
from employees;

select * from employees where employee_id=105;
select * from employees where first_name = 'NEENA';
select * from employees where job_id = 'AD_VP';
select * from employees where department_id = 90;

select * from employees where department_id = 90 or  department_id =60;
select * from employees where department_id in( 90 ,60);
select * from employees where department_id not in( 90 ,60);

-- conditional or relational operators
select * from employees where salary = 4800;
select * from employees where salary <> 4800;
select * from employees where salary != 4800;
select * from employees where salary > 4800;
select * from employees where salary >= 4800;
select * from employees where salary < 4800;
select * from employees where salary <= 4800;
select * from employees where salary >=4000 and salary <=5000;
select * from employees where salary between 4000 and 5000;
select * from employees;

select * from employees where first_name like 'N%';
select * from employees where first_name like '%a_';
select * from employees where first_name like '%a%';

select * from employees where job_id like '%VP%';
select * from employees where job_id not like '%VP%';

select * from employees where job_id like 'ST%';

select * from employees where manager_id is NULL;
select * from employees where manager_id is not NULL;

select * from employees where commission_pct is  null or 
 commission_pct =0.10;

select * from employees where first_name like '_________';
select first_name, length(first_name) from employees;
select * from employees where length(first_name) =9;

select first_name employee_first_name, last_name, concat(first_name,' ' , last_name)  employee_name
from employees;
select employee_id, first_name, salary from employees;
select employee_id, first_name, salary, salary *1.1 bonus from employees;

-- Any operation with a NULL values is NULL
select employee_id, first_name, salary,commission_pct, 
salary +(salary *commission_pct) Pay from employees;

-- Replace NULL values with 0

select commission_pct, ifnull(commission_pct,0) from employees;

select employee_id, first_name, salary,commission_pct, 
salary +(salary *ifnull(commission_pct,0)) Pay from employees;

-- sort the data
select * from employees
order by first_name , last_name, hire_date ;

-- IF and Case statments
select employee_id, first_name, salary, if(salary>=10000, 'High','Low')
from employees;

select employee_id, first_name, salary,
case
when salary <=5000 then salary*.1
when salary between 5000 and 8000 then salary*.09
when salary between 8000 and 12000 then salary*.08
else salary*.06
end Bonus
from employees;

-- Get unique values from the column 
select distinct department_id from employees;

select * from employees
limit 3;

select * from employees
order by salary
limit 1;


select * from employees
order by salary desc
limit 1 offset 3;


-- Aggregate function

select min(salary), max(salary), avg(salary), sum(salary), count(salary)
from employees;

select * from employees;

select department_id, avg(salary) 
from employees
group by department_id;


select department_id, count(*) from 
employees
group by department_id;


select department_id, avg(salary) 
from employees
where department_id is not null
group by department_id;



-- List departments where average salary is <8000

select department_id, avg(salary) 
from employees
where department_id is not null
group by department_id
having avg(salary) <8000
order by avg(salary) desc
limit 1;

-- List the departments who have more than 20 employees
select department_id , count(*)
from employees
group by department_id
having count(*)>20;

-- List employees whose salary is > average salary 
select * from employees
where salary>avg(salary);



show tables;

select * from job_history;


select employee_id, job_id  from employees
union all
select employee_id, job_id  from job_history;

create table t1
( id integer,
name varchar(5),
city varchar(20) default 'Bangalore');

insert into t1(id,name) values ( 1,'a'), (2,'b'),(4,'d'),(6,'f'),(7,'g');

select * from t1;


drop table t2;
create table t2
( rollno integer,
name varchar(5),
salary integer default 1000);

insert into t2(rollno,name) values ( 1,'a'), (3,'c'),(5,'e'),(7,'g');

select * from t1;

select id,name, city, 0 from t1
union 
select rollno, name, 'None', salary   from t2;








