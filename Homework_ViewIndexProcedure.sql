create database demo;

use demo;

create table products (
	id int primary key,
    productCode varchar(255),
    productName varchar(255),
    productPrice double,
    productAmount double,
    productDescription varchar(255),
    productStatus bit);
    
insert into products
value (1, '1', 'a', 10, 10, 'abc', 1),
	(2, '2', 'b', 20, 10, 'abc', 1),
    (3, '3', 'c', 30, 10, 'abc', 1),
    (4, '4', 'd', 40, 10, 'abc', 1),
    (5, '5', 'e', 50, 10, 'abc', 1);
    
alter table products
add index productCode_index (productCode);

alter table products
add index productNamePrice_index (productName, productPrice);

explain select productName, productPrice 
from products
where productName = 'a';

create view product_view as
select productCode, productName, productPrice, productStatus
from products;

select * from product_view;

update product_view
set productName = 'a' 
where productCode = '2';

drop view product_view;

delimiter //
CREATE PROCEDURE getInfo()
       BEGIN
         select * from products;
       END//
delimiter ;

call getInfo();

delimiter //
create procedure addItem()
begin
	insert into products(productName)
    value ('new item');
end//
delimiter ;

call addItem();

delimiter //
create procedure deleteItem(in delete_id int)
begin
	delete from products
    where id = delete_id;
end//
delimiter ;

call deleteItem(0);

delimiter //
create procedure changeName(in change_id int, in change_name varchar(255))
begin
	update products
    set productName = change_name
    where id = change_id;
end//
delimiter ;

call changeName(1,'San Pham 1');