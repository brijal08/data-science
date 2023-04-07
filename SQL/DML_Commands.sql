-- Data Manipulation Language (DML) - insert, update, delete, select

use company;
show tables;

create table customers (
customerid int,
first_name varchar(20),
last_name varchar(20),
contry varchar(20)
);

insert into customers (customerid,first_name,last_name,contry)
value
(1,'Brijal','Panchal','Canada'),
(2,'Neha','Panchal','India');

select * from customers;

insert into customers values
(3,'Kaushal','Panchal','Canada');

select * from customers;

update customers 
set first_name= 'Payal', last_name= 'Rohatgi' 
where customerid=1;

select * from customers;

delete from customers where first_name = 'Payal';

select * from customers;

-- TCL commands - commit, rollback

set autocommit=0;
insert into customers values
(4,'Payal','Panchal','Canada');
select * from customers;

rollback;
select * from customers;

commit;
select * from customers;