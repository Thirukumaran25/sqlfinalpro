create database product_review;
use product_review;


create table users (
    id int primary key auto_increment,
    name varchar(255) not null
);

create table products (
    id int primary key auto_increment,
    name varchar(255) not null
);

create table reviews (
    id int primary key auto_increment,
    user_id int not null,
    product_id int not null,
    rating tinyint not null check (rating >= 1 and rating <= 5),
    review text,
    created_at timestamp default current_timestamp,
    foreign key (user_id) references users(id),
    foreign key (product_id) references products(id),
    constraint unique_review unique (user_id, product_id)
);


insert into users (name) values
('Alice'),
('Bob'),
('Charlie');

insert into products (name) values
('Smartphone'),
('Headphones'),
('Smartwatch');

insert into reviews (user_id, product_id, rating, review) values
(1, 1, 5, 'Great phone, excellent camera!'),
(2, 1, 4, 'Fast and good display, but a bit pricey.'),
(3, 1, 5, 'Best phone I have ever used.'),
(1, 2, 3, 'Decent sound quality for the price.'),
(2, 3, 5, 'Love the features and battery life!');



select
    p.name as product_name,
    count(r.id) as total_reviews,
    avg(r.rating) as average_rating
from products p
left join reviews r on p.id = r.product_id
group by p.id;


select
    p.name as product_name,
    avg(r.rating) as average_rating,
    count(r.id) as total_reviews
from products p
join reviews r on p.id = r.product_id
group by p.id
having count(r.id) >= 2 and avg(r.rating) >= 4
order by average_rating desc, total_reviews desc
limit 5;



insert into reviews (user_id, product_id, rating, review) values (1, 3, 4, 'Good smartwatch.');


insert into reviews (user_id, product_id, rating, review) values (1, 3, 5, 'An even better smartwatch!');

