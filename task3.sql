create database order_management;
use order_management;


create table users (
    id int primary key auto_increment,
    name varchar(255) not null,
    email varchar(255) unique not null
);

create table products (
    id int primary key auto_increment,
    name varchar(255) not null,
    price decimal(10, 2) not null,
    stock int not null default 0
);

create table orders (
    id int primary key auto_increment,
    user_id int not null,
    status enum('pending', 'processing', 'shipped', 'delivered', 'cancelled') not null default 'pending',
    created_at timestamp default current_timestamp,
    foreign key (user_id) references users(id)
);

create table order_items (
    id int primary key auto_increment,
    order_id int not null,
    product_id int not null,
    quantity int not null,
    price decimal(10, 2) not null, -- Price at the time of order
    foreign key (order_id) references orders(id),
    foreign key (product_id) references products(id)
);


insert into users (name, email) values
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com');

insert into products (name, price, stock) values
('Phone', 599.99, 50),
('Headphones', 99.50, 100),
('Charger', 25.00, 200);


insert into orders (user_id, status) values
(1, 'delivered'),
(1, 'shipped'),
(2, 'pending');


insert into order_items (order_id, product_id, quantity, price) values
(1, 1, 1, 599.99), 
(1, 2, 2, 99.50),
(2, 3, 1, 25.00),  
(3, 1, 1, 599.99); 


start transaction;

insert into orders (user_id, status) values (1, 'pending');
set @order_id = last_insert_id();

insert into order_items (order_id, product_id, quantity, price) values (@order_id, 2, 3, 99.50);

update products
set stock = stock - 3
where id = 2;

commit;


select
    o.id as order_id,
    o.created_at,
    o.status,
    count(oi.id) as total_items,
    sum(oi.quantity * oi.price) as total_order_value
from orders o
join order_items oi on o.id = oi.order_id
where o.user_id = 1
group by o.id
order by o.created_at desc;


update orders
set status = 'processing'
where id = 3;

select
    p.name as product_name,
    oi.quantity,
    oi.price
from order_items oi
join products p on oi.product_id = p.id
where oi.order_id = 1;