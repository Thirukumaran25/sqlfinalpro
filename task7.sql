create database Leave_management;
use Leave_management;


create table employees (
    id int primary key auto_increment,
    name varchar(255) not null
);

create table leave_types (
    id int primary key auto_increment,
    type_name varchar(255) not null
);

create table leave_requests (
    id int primary key auto_increment,
    emp_id int not null,
    leave_type_id int not null,
    from_date date not null,
    to_date date not null,
    status enum('pending', 'approved', 'rejected') not null default 'pending',
    foreign key (emp_id) references employees(id),
    foreign key (leave_type_id) references leave_types(id),
    constraint check_dates check (from_date <= to_date)
);



insert into employees (name) values
('Alice'),
('Bob');

insert into leave_types (type_name) values
('Vacation'),
('Sick Leave'),
('Personal Leave');

insert into leave_requests (emp_id, leave_type_id, from_date, to_date, status) values
(1, 1, '2025-09-01', '2025-09-05', 'approved'),
(1, 2, '2025-10-15', '2025-10-15', 'pending'),
(2, 1, '2025-09-10', '2025-09-12', 'approved');



select
    e.name,
    lt.type_name,
    sum(datediff(lr.to_date, lr.from_date) + 1) as total_leave_days
from employees e
join leave_requests lr on e.id = lr.emp_id
join leave_types lt on lr.leave_type_id = lt.id
where lr.status = 'approved'
group by e.id, lt.id;



select count(*)
from leave_requests
where emp_id = 1
and status = 'approved'
and '2025-09-07' >= from_date
and '2025-09-03' <= to_date;


