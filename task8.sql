create database Sales_CRM;
use Sales_CRM;


create table users (
    id int primary key auto_increment,
    name varchar(255) not null
);

create table leads (
    id int primary key auto_increment,
    name varchar(255) not null,
    source varchar(255) not null
);

create table deal_stages (
    id int primary key auto_increment,
    stage_name varchar(255) not null unique,
    stage_order int not null unique
);

create table deals (
    id int primary key auto_increment,
    lead_id int not null,
    user_id int not null,
    stage_id int not null,
    amount decimal(10, 2) not null,
    created_at timestamp default current_timestamp,
    foreign key (lead_id) references leads(id),
    foreign key (user_id) references users(id),
    foreign key (stage_id) references deal_stages(id)
);


insert into users (name) values
('Alice'),
('Bob');

insert into leads (name, source) values
('Tech Solutions Inc.', 'Website'),
('Global Widgets LLC', 'Referral'),
('Innovate Co.', 'Cold Call');

insert into deal_stages (stage_name, stage_order) values
('New', 1),
('Contacted', 2),
('Proposal Sent', 3),
('Negotiation', 4),
('Closed Won', 5),
('Closed Lost', 6);


insert into deals (lead_id, user_id, stage_id, amount) values
(1, 1, 1, 5000.00),
(2, 1, 3, 15000.00), 
(3, 2, 2, 7500.00); 



select
    d.id,
    l.name as lead_name,
    u.name as user_name,
    ds.stage_name,
    d.amount,
    d.created_at
from deals d
join leads l on d.lead_id = l.id
join users u on d.user_id = u.id
join deal_stages ds on d.stage_id = ds.id
where ds.stage_name = 'Proposal Sent'
and d.created_at >= now() - interval 30 day;


with user_deals as (
    select
        d.amount,
        ds.stage_name
    from deals d
    join deal_stages ds on d.stage_id = ds.id
    where d.user_id = 1
)
select
    stage_name,
    sum(amount) as total_amount
from user_deals
group by stage_name
order by total_amount desc;

