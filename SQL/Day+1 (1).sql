create database ltcnov21;

use ltcnov21;


create table test
(
testid integer,
testname varchar(10)
);

insert into test values(1, 'a');
insert into test values(2, 'b');
insert into test values(3, NULL);


select * from test; -- fetch all the rows from the table

show tables;

describe test;
desc test;

/* Below tables are for 
primary key and 
foreign key
*/

create table course
(
cid integer primary key,
cname varchar(20) NOT NULL
);

insert into course values(10, 'Python');
insert into course values(10, 'SQL'); -- PK error
insert into course values(20, NULL ); -- error
insert into course values(20, 'SQL' ); 
insert into course values(30, 'Java' ); 
insert into course values(40, 'Java' ); 

select * from course;

create table student 
( sid integer primary key,
sname varchar(20) not null,
cid integer ,
foreign key(cid) references course(cid)
);

insert into student values(1, 'Abhinandan',10);
insert into student values(2, 'Ashwin',20);
insert into student values(3, 'Giri',20);
insert into student values(4, 'Hannan',10);
insert into student values(5, 'Haritha',20);
insert into student values(6, 'Hema',20);
insert into student values(7, 'Indu',10);
insert into student values(8, 'Kiran',10);
insert into student values(9, 'Kushal',NULL);
insert into student values(10, 'Dhev',NULL);

select * from student;


select * from course;

select * from student;

select * from student
where cid = 10;

set sql_safe_updates = 0;

update course set cname = 'C++' where cid = 40;

select * from course;

desc student;

alter table student
modify sname varchar(30);


describe student;


select * from course;

delete from course 
where cid = 40;  -- deleteing C++ course

delete from course 
where cid = 10; -- deleteing Python course

rename table test to test1;
show tables;

select * from test1;

truncate table test1;
drop table test1;

update student set city = 'Pune';

select * from student;

alter table student
modify city varchar(30) not null;

describe student;


update student set city = 'Mumbai';
select * from student;
rollback;
select * from student;

update student set city = 'Mumbai';
commit;
select * from student;

alter table student
drop city;







