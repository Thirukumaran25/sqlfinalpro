create database Inventory_track;
use Inventory_track;



create table suppliers (
    id int primary key auto_increment,
    name varchar(255) not null,
    contact_email varchar(255)
);

create table products (
    id int primary key auto_increment,
    name varchar(255) not null,
    stock int not null default 0,
    reorder_level int not null default 10,
    supplier_id int,
    foreign key (supplier_id) references suppliers(id)
);

create table inventory_logs (
    id int primary key auto_increment,
    product_id int not null,
    supplier_id int,
    action enum('received', 'shipped', 'adjustment') not null,
    quantity int not null,
    timestamp timestamp default current_timestamp,
    foreign key (product_id) references products(id),
    foreign key (supplier_id) references suppliers(id)
);


delimiter //


create trigger trg_update_product_stock
after insert on inventory_logs
for each row
begin
    if new.action = 'received' then
        update products
        set stock = stock + new.quantity
        where id = new.product_id;
    elseif new.action = 'shipped' then
        update products
        set stock = stock - new.quantity
        where id = new.product_id;
    elseif new.action = 'adjustment' then
        update products
        set stock = stock + new.quantity
        where id = new.product_id;
    end if;
end//

delimiter ;


insert into suppliers (name, contact_email) values
('Tech Wholesalers', 'contact@techwholesalers.com'),
('Gadget Distributors', 'sales@gadgetdist.com');

insert into products (name, stock, reorder_level, supplier_id) values
('Laptop', 5, 10, 1),
('Wireless Mouse', 20, 15, 1),
('Mechanical Keyboard', 8, 5, 2);


select
    name,
    stock,
    reorder_level,
    case
        when stock <= reorder_level then 'Reorder'
        when stock > reorder_level and stock <= reorder_level * 1.5 then 'Low Stock'
        else 'In Stock'
    end as stock_status
from products;


select
    p.name as product_name,
    p.stock,
    p.reorder_level,
    s.name as supplier_name,
    case
        when p.stock <= p.reorder_level then 'Reorder'
        when p.stock > p.reorder_level and p.stock <= p.reorder_level * 1.5 then 'Low Stock'
        else 'In Stock'
    end as stock_status
from products p
join suppliers s on p.supplier_id = s.id;



insert into inventory_logs (product_id, supplier_id, action, quantity) values
(1, 1, 'shipped', 5);


insert into inventory_logs (product_id, supplier_id, action, quantity) values
(1, 1, 'received', 10);

