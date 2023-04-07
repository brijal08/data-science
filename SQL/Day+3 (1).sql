use hr;

select * from regions;

select * from countries;



select c.country_id, c.country_name, c.region_id,r.region_name
from countries c inner join  regions r
 on c.region_id = r.region_id;



select * from locations;

select l.location_id, l.street_address, l.state_province,
 l.country_id, c.country_name
from locations l inner join countries c
on l.country_id = c.country_id
; 


select l.location_id, l.street_address, l.state_province, l.country_id, 
c.country_name, c.region_id, r.region_name
from locations l inner join countries c
on l.country_id = c.country_id 
inner join regions r 
on c.region_id = r.region_id ;

select count(*) from employees;

select  e.employee_id, e.first_name, e.department_id, d.department_name
from employees e  join departments d
on e.department_id = d.department_id 
order by e.employee_id;

select count(*) from employees;

select  e.employee_id, e.first_name, e.department_id, d.department_name
from employees e  join departments d
on e.department_id = d.department_id 
order by e.employee_id;


select  e.employee_id, e.first_name, e.department_id, d.department_name
from employees e  left outer join departments d
on e.department_id = d.department_id 
order by e.employee_id;



select  e.employee_id, e.first_name, d.department_id, d.department_name
from employees e  right outer join departments d
on e.department_id = d.department_id 
order by e.employee_id;


select  e.employee_id, e.first_name, d.department_id, d.department_name
from departments d left  join employees e 
on e.department_id = d.department_id 
order by e.employee_id;



-- Full outer join
select  e.employee_id, e.first_name, e.department_id, d.department_name
from employees e  left outer join departments d
on e.department_id = d.department_id 
union 
select  e.employee_id, e.first_name, e.department_id, d.department_name
from employees e  right outer join departments d
on e.department_id = d.department_id
order by 1 desc; 

-- self join
select employee_id, first_name, manager_id  from employees
where department_id In (90,60) 
order by 1;

select e.employee_id, e.first_name emp_name,e.department_id, e.manager_id, m.first_name manager_name
from employees e left outer join employees m
on e.manager_id = m.employee_id
where e.department_id between 30 and 60
order by 1;
/*
case
when category = 'Electronics' then
	case 
      when quantity  <= 10 the 'Low stock'
      when quantity between 11 and 30 then 'In stock'
    end 
when category = 'Stationary'
	case 
      when quantity  <= 20 the 'Low stock'
      when quantity between 11 and 30 then 'In stock'
    end 
end
*/

-- Subqueries
select * from employees;
select * from departments; -- Executive


select e.*
from employees e join departments d
on e.department_id = d.department_id
where d.department_name = 'Executive';


select e.* 
from employees e 
where e.department_id = (
select d.department_id from departments d
where d.department_name = 'Executive');


select * from employees 
order by salary 
limit 2;


update employees set salary = 2100
where employee_id = 144;


select * from employees
where salary < (
select avg(salary) from employees); -- 6457.943925

select * from employees
where department_id = 50;

-- correlated subquery
select * from employees o
where salary > (
select avg(salary) from employees i
where i.department_id = o.department_id);

select department_id, avg(salary)
from employees
group by department_id ;


SELECT department_id, AVG(salary)
FROM employees 
GROUP BY department_id
HAVING AVG(salary) <  ( SELECT AVG(salary)
							FROM employees); -- 6457


-- List all department that  have employees

select * from departments d
where d.department_id   in(
select e.department_id from employees e);

select * from departments d
where  exists(
select department_id from employees e
where e.department_id = d.department_id
);


-- List all department that do not have employees

select * from departments d
where d.department_id  not in(
select e.department_id from employees e); 
-- not working because of null value in department_id in employee table
-- Either ignore the null row or use not exists clause

select * from departments d
where  not exists(
select department_id from employees e
where e.department_id = d.department_id
);



select e.employee_id, e.first_name, e.salary, e.department_id  , test.avgsal
from employees e , (select e1.department_id, avg(e1.salary) avgsal
                    from employees e1
                     group by e1.department_id ) test 
where e.department_id = test.department_id ;


-- 

select * from job_history;


-- list all the locations in Asia

select * from departments where location_id in 
(2200,
2000,
2100,
1200,
1300,
2300);

select * from departments where location_id in (
   select location_id from locations 
   where country_id in 
          (select country_id from countries
          where region_id = (
                select region_id from regions
                where region_name = 'Europe')));


select * from job_history;

select employee_id ,job_id,
lag(job_id) over(partition by employee_id),
lead(job_id) over(partition by employee_id)
from job_history
order by employee_id;



