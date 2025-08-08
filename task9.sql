create database Appointment_db;
use Appointment_db;

create table users (
    id int primary key auto_increment,
    name varchar(255) not null
);

create table services (
    id int primary key auto_increment,
    name varchar(255) not null
);

create table appointments (
    id int primary key auto_increment,
    user_id int not null,
    service_id int not null,
    appointment_time datetime not null,
    foreign key (user_id) references users(id),
    foreign key (service_id) references services(id),
    constraint unique_service_time unique (service_id, appointment_time)
);


insert into users (name) values
('Alice'),
('Bob');

insert into services (name) values
('Haircut'),
('Massage'),
('Consultation');


insert into appointments (user_id, service_id, appointment_time) values
(1, 1, '2025-08-10 10:00:00'),
(2, 1, '2025-08-10 11:00:00'),
(1, 2, '2025-08-11 14:30:00');


select count(*)
from appointments
where service_id = 1
and appointment_time between '2025-08-10 10:30:00' - interval 60 minute and '2025-08-10 10:30:00' + interval 60 minute;


select
    a.appointment_time,
    u.name as user_name,
    s.name as service_name
from appointments a
join users u on a.user_id = u.id
join services s on a.service_id = s.id
where s.name = 'Haircut'
and date(a.appointment_time) = '2025-08-10';



select
    s.name as service_name,
    a.appointment_time
from appointments a
join services s on a.service_id = s.id
join users u on a.user_id = u.id
where u.name = 'Alice'
and a.appointment_time > now()
order by a.appointment_time asc;



