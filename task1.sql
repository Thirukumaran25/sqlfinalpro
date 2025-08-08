create database ecom_products;
use ecom_products;


create table categories(
    categorie_id int primary key auto_increment,
    categorie_name varchar(50)
);

create table brands(
    brand_id int primary key auto_increment,
    brand_name varchar(50)
);

create table products(
    product_id int primary key auto_increment,
    product_name varchar(50),
    product_description varchar(50),
    price decimal(6,2),
    stock int,
    image_url varchar(100),
    category_id int,
    brand_id int,
    foreign key (category_id) references categories(categorie_id),
    foreign key (brand_id) references brands(brand_id)
);


insert into categories(categorie_name)
values ('Electronics'),('Fashion'),('Food');

insert into brands(brand_name)
values ('Samsung'),('Zara'),('Dominos');

insert into products(product_name, product_description, price, stock, image_url, category_id, brand_id)
values ('galaxy S24','latest 8gb ram mobile',50000,5,'https://image.com',1,1),
    ('pep jean','newly designed', 1500,8,'https://image.com',2,2),
    ('chees pizza','comes with topins',200,25,'https://image.com',3,3),
    ('Apple 15','latest 6gb ram mobile',45000,3,'https://image.com',1,1),
    ('Nylon cap','newly designed', 150,10,'https://image.com',2,2);
    
    



create index idx_products_price on products(price);
create index idx_products_name on products(product_name);


select
    p.product_name,
    p.price,
    p.product_description,
    b.brand_name,
    c.categorie_name
from products p
join categories c on p.category_id = c.categorie_id
join brands b on p.brand_id = b.brand_id
where c.categorie_name = 'Electronics';


select
    p.product_name,
    p.price,
    p.product_description,
    b.brand_name,
    c.categorie_name
from products p
join brands b on p.brand_id = b.brand_id
join categories c on p.category_id = c.categorie_id
where b.brand_name = 'Samsung';



select
    p.product_name,
    p.price,
    p.product_description,
    b.brand_name,
    c.categorie_name
from products p
join brands b on p.brand_id = b.brand_id
join categories c on p.category_id = c.categorie_id
where p.price between 100 and 200;


