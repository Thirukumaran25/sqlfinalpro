create database shoping_cart;
use shoping_cart;


create table users (
    id int primary key auto_increment,
    name varchar(255) not null,
    email varchar(255) unique not null
);

create table products (
    id int primary key auto_increment,
    name varchar(255) not null,
    price decimal(10, 2) not null,
    description text
);

create table carts (
    id int primary key auto_increment,
    user_id int unique,
    foreign key (user_id) references users(id)
);

create table cart_items (
    cart_id int,
    product_id int,
    quantity int not null default 1,
    primary key (cart_id, product_id),
    foreign key (cart_id) references carts(id),
    foreign key (product_id) references products(id)
);


insert into users (name, email) values
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com');

insert into products (name, price, description) values
('Laptop', 1200.00, 'Powerful laptop for work and gaming.'),
('Mouse', 25.50, 'Ergonomic wireless mouse.'),
('Keyboard', 75.00, 'Mechanical keyboard with backlighting.');

insert into carts (user_id) values (1), (2); 

insert into cart_items (cart_id, product_id, quantity) values (1, 1, 1);

update cart_items
set quantity = 2
where cart_id = 1 and product_id = 1;


delete from cart_items
where cart_id = 1 and product_id = 1;

select
    p.name as product_name,
    p.price,
    ci.quantity
from carts c
join cart_items ci on c.id = ci.cart_id
join products p on ci.product_id = p.id
where c.user_id = 1;


select
    sum(p.price * ci.quantity) as total_cart_value
from carts c
join cart_items ci on c.id = ci.cart_id
join products p on ci.product_id = p.id
where c.user_id = 1;
