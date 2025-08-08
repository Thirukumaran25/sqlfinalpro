create database project_db;
use project_db;



create table projects (
    id int primary key auto_increment,
    name varchar(255) not null
);

create table users (
    id int primary key auto_increment,
    name varchar(255) not null
);

create table tasks (
    id int primary key auto_increment,
    project_id int not null,
    name varchar(255) not null,
    status enum('todo', 'in_progress', 'done') not null default 'todo',
    foreign key (project_id) references projects(id)
);

create table task_assignments (
    task_id int not null,
    user_id int not null,
    primary key (task_id, user_id),
    foreign key (task_id) references tasks(id),
    foreign key (user_id) references users(id)
);


insert into projects (name) values
('Website Redesign'),
('Marketing Campaign');

insert into users (name) values
('Alice'),
('Bob');

insert into tasks (project_id, name, status) values
(1, 'Design wireframes', 'in_progress'),
(1, 'Develop front-end', 'todo'),
(2, 'Create ad copy', 'done'),
(2, 'Plan social media', 'in_progress');

insert into task_assignments (task_id, user_id) values
(1, 1), 
(1, 2), 
(2, 1),
(3, 2);  


select
    t.name as task_name,
    p.name as project_name,
    t.status
from task_assignments ta
join tasks t on ta.task_id = t.id
join projects p on t.project_id = p.id
join users u on ta.user_id = u.id
where u.name = 'Alice';


select
    t.status,
    count(t.id) as task_count
from tasks t
join projects p on t.project_id = p.id
where p.name = 'Website Redesign'
group by t.status;



select
    t.name as task_name,
    t.status,
    group_concat(u.name) as assigned_users
from tasks t
join projects p on t.project_id = p.id
join task_assignments ta on t.id = ta.task_id
join users u on ta.user_id = u.id
where p.name = 'Website Redesign'
group by t.id;


