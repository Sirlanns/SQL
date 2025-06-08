create database companyHR;
use companyHR;

create table co_employees (
 id int primary key auto_increment,
 en_name varchar(255) not null, 
 gender char(1) not null, 
 contact_number varchar(255),
 age int not null,
 date_create timestamp not null default now()                
 ); 
 
create table mentorships (
mentor_id int not null,
mentee_id int not null,
status  varchar(255) not null,
project varchar(255) not null, 

primary key (mentor_id, mentee_id, project),
constraint fk1 foreign KEY(mentor_id) references co_employees(id) ON DELETE CASCADE ON UPDATE RESTRICT,
constraint fk2 foreign KEY(mentee_id) references co_employees(id) ON DELETE CASCADE ON UPDATE RESTRICT,
constraint mm_constraint unique (mentor_id, mentee_id)
);

rename table co_employees to employees;

alter table employees
	drop column age,
    add column salary float not null after contact_number,
    add column years_in_company int not null after salary;
    
describe employees;

alter table mentorships 
    drop foreign key fk2;
    
alter table mentorships 
    add constraint fk2 foreign key(mentee_id) references employees(id) on delete cascade on update cascade,
    drop index mm_constraint;
    
    insert into employees (en_name, gender, contact_number, salary, years_in_company) values
    ('James Lee', 'M', '516-514-6568', 3500, 11),
    ('Peter Pasternak', 'M', '845-644-7919', 6010, 10),
    ('Clara Couto', 'F', '845-641-5236', 3900, 8),
    ('Walker Welch', 'M', null, 2500, 4),
    ('Li Xiao Ting', 'F', '646-218-7733', 5600, 4),
    ('Joyce Jones', 'F', '523-172-2191', 8000, 3),
    ('Jason Cerrone', 'M', '725-441-7172', 7980, 2),
    ('Prudence Phelps', 'F', '546-312-5112', 11000, 2),
    ('Larry Zucker', 'M', '817-267-9799', 3500, 1),
    ('Serena Parker', 'F', '621-211-7342', 12000, 1);
    
    INSERT INTO mentorships VALUES 
     (1, 2, 'Ongoing', 'SQF Limited'),
     (1, 3, 'Past', 'Wayne Fibre'),
     (2, 3, 'Ongoing', 'SQF Limited'),
     (3, 4, 'Ongoing', 'SQF Limited'),
     (6, 5, 'Past', 'Flynn Tech');
     
     DESCRIBE employees;
     UPDATE employees
     SET contact_number = '516-514-1729'
     WHERE id = 1;
     
     DELETE FROM employees
     WHERE id = 5;

-- insert into mentorships values 
-- (4, 21, 'Ongoing', 'Flynn Tech');

-- update employees
-- set id = 12
-- where id = 1;

UPDATE employees
SET id = 11
WHERE id = 4;

SELECT * FROM employees;
SELECT * FROM mentorships;


######### consulta de dados #########

select en_name, gender from employees;

select en_name AS employee name, gender AS gender from employees;
select en_name AS "employee name", gender AS gender from employees;
select en_name AS 'employee name', gender AS gender from employees;

select en_name AS 'employee name', gender AS gender from employees LIMIT 3;

select gender from employees;
select distinct (gender) from employees;

select * from employees WHERE id != 1;

select * from employees WHERE id BETWEEN 1 AND 3;

select * from employees WHERE en_name LIKE '%er';

select * from employees WHERE en_name LIKE '%er';

select * from employees WHERE en_name LIKE '_e%';

select * from employees WHERE id IN ('6, 7, 9');

select * from employees WHERE id NOT IN (7,8);

select * from employees WHERE (years_in_company > 5 or salary > 5000)  AND gender = 'F';

select * from employees WHERE id IN 
(select mentor_id from mentorships WHERE project = 'SQF Limited');

select * from employees order by gender, en_name;

select * from employees order by gender DESC, en_name;

select concat('Hello', 'World');

select substring('programming', 2);

select substring('programming', 2, 6);

select curdate();

select count(*) from employees;
select count(contact_number) from employees;
select count(gender) from employees;
select count(distinct gender) from employees;

select avg(salary) from employees;
select round(avg(salary), 2) from employees;

select max(salary) from employees;
select min(salary) from employees;

select sum(salary) from employees;

select gender, max(salary) from employees group by gender;
select gender, max(salary) from employees group by gender having max(salary) > 10000;

select employees.id, mentorships.mentor_id, employees.en_name AS 'mentor', mentorships.project AS 'project name'
from
mentorships
join
employees
on
employees.id = mentorships.mentor_id;

select employees.en_name AS 'mentor', mentorships.project AS 'project name'
from
mentorships
join
employess
on 
employees.id = mentorships.mentor_id;


select en_name, salary from employees where gender = 'M'
union 
select en_name, years_in_company from employees where gender = 'F';

select mentor_id from mentorships 
union all
select id from employees where gender = 'F';

select mentor_id from mentorships 
union 
select id from employees where gender = 'F'; 

create view myView as
select employees.id, mentorships.mentor_id, employees.en_name as 'mentor', mentorships.project as 'project name'
from 
mentorships 
join 
employees 
on
employees.id = mentorships.mentor_id;

select * from myView;
select mentor_id, `project`from myView;

alter view  myView as 
select employees.id, mentorships.mentor_id, employees.en_name as 'mentor', mentorships.project as 'project'
from 
mentorships
join
employees
on
employees.id = mentorships.mentor_id;

create table ex_employees(
em_id int primary key, 
en_name varchar(255) not null,
gender char(1) not null,
date_left timestamp default now()
);

DELIMITER $$

create trigger update_ex_employees before delete on employees for each row
begin
insert into ex_employees (em_id, en_name, gender) values (old.id, old.en_name, old.gender);
end $$

DELIMITER ;

delete from employees where id = 10;

select * from employees;
select * from ex_employees;

drop trigger if exists update_ex_employees;
