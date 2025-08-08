create database timesheet_db;
use timesheet_db;



create table employees (
    id int primary key auto_increment,
    name varchar(255) not null,
    dept varchar(255) not null
);

create table projects (
    id int primary key auto_increment,
    name varchar(255) not null
);

create table timesheets (
    id int primary key auto_increment,
    emp_id int not null,
    project_id int not null,
    hours decimal(5, 2) not null,
    date date not null,
    foreign key (emp_id) references employees(id),
    foreign key (project_id) references projects(id)
);



insert into employees (name, dept) values
('John Doe', 'Engineering'),
('Jane Smith', 'Marketing');

insert into projects (name) values
('Website Redesign'),
('Mobile App Development');

insert into timesheets (emp_id, project_id, hours, date) values
(1, 1, 8.0, '2025-08-01'),
(1, 1, 7.5, '2025-08-02'),
(1, 2, 4.0, '2025-08-03'),
(2, 1, 6.0, '2025-08-01'),
(2, 1, 5.5, '2025-08-02');


select
    e.name as employee_name,
    p.name as project_name,
    sum(t.hours) as total_hours_worked
from timesheets t
join employees e on t.emp_id = e.id
join projects p on t.project_id = p.id
group by e.id, p.id;


select
    e.name as employee_name,
    sum(t.hours) as total_weekly_hours
from timesheets t
join employees e on t.emp_id = e.id
where e.name = 'John Doe' and t.date between '2025-07-28' and '2025-08-03'
group by e.id;


select
    e.dept as department,
    sum(t.hours) as total_monthly_hours
from timesheets t
join employees e on t.emp_id = e.id
where t.date between '2025-08-01' and '2025-08-31'
group by e.dept;


select
    e.name as employee_name,
    t.date,
    t.hours
from timesheets t
join employees e on t.emp_id = e.id
join projects p on t.project_id = p.id
where p.name = 'Website Redesign'
order by t.date desc;


