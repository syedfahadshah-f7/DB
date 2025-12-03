create table Product(
    product_id int primary key,
    product_name varchar(30),
    inventory int default 1
);

create table Orders(
    order_id int primary key,
    product_id int ,
    quantity int ,
    constraint fk1 foreign key (product_id) references Product(product_id)
);

set transaction name 'add_product';
insert into PRODUCT values (1,'Face Wash',4);
savepoint sp1;

insert into orders values (62,1,5);

update Product set INVENTORY = INVENTORY - 5 where PRODUCT_ID =1;

set serveroutput on;

DECLARE
inventory_exc EXCEPTION;
inventory_val NUMBER;
BEGIN
    select inventory into inventory_val from PRODUCT where product_id = 1;
    IF inventory_val < 0 THEN
        Raise inventory_exc;
    END IF;
    
    COMMIT;
EXCEPTION
    when inventory_exc THEN
        ROLLBACK TO SAVEPOINT sp1;
        DBMS_OUTPUT.PUT_LINE('Insufficient Quantity in Inventory');
    WHEN others then
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transaction Failed');
END;
/

select * from ORDERS;
select * from product;
drop table Product;

drop table orders;
drop table Product;
