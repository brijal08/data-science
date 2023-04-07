-- Data Defination Language - database: create, show, drop, use; table: create, show, describe, rename, truncate, drop ; column - alter: change, moodify, add, drop

create database company;
show databases;
drop database company;

use company;
create table customers (
customerid int,
first_name varchar(20),
last_name varchar(20),
contry varchar(20)
);

show tables;

describe customers;

alter table customers change last_name second_name varchar(20);
describe customers;

alter table customers change second_name last_name varchar(25);
describe customers;

alter table customers modify first_name varchar(25);
alter table customers modify first_name varchar(25) not null;

alter table customers add column total_exp varchar(10);
alter table customers add column salary int;

alter table customers add date_of_birth date after last_name;

alter table customers drop column salary;


rename table customers to customers_info;
show tables;

truncate table customers_info;
describe customers_info;

drop table customers_info;
show tables;