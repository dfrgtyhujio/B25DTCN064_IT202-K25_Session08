create database BookStoreDB;
use BookStoreDB;

create table Category(
	category_id int primary key auto_increment,
    category_name varchar(100) not null,
    description varchar(255)
);

create table Book(
	book_id int primary key auto_increment,
    title varchar(150) not null,
    status int default(1),
    publish_date date,
    price decimal(10,2),
    category_id int not null,
    foreign key (category_id) references  Category (category_id)
);

create table BookOrder(
	order_id int primary key auto_increment,
    customer_name varchar(100) not null,
    book_id int not null,
    foreign key (book_id) references  Book (book_id),
    order_date date default (current_date),
    delivery_date date
);

alter table Book
add column author_name varchar(100) not null
after category_id;

alter table BookOrder
modify column customer_name varchar(200);

alter table BookOrder
add constraint delivery_date check(delivery_date >= order_date);

insert into Category(category_name, description) values
	('IT & Tech', 'Sách lập trình'),
    ('Business', 'Sách kinh doanh'),
    ('Novel', 'Tiểu thuyết');

insert into Book(title, status, publish_date, price, category_id, author_name) values
	('Clean Code', 1, '2020-05-10', 500000, 1, 'Robert C.Martin'),
    ('Đắc Nhân Tâm', 0, '2018-08-20', 150000, 2, 'Dale Carnegie'),
    ('JavaScript Nâng cao', 1, '2023-01-15', 350000, 1, 'Kyle Simpson'),
    ('Nhà Giả Kim', 0, '2015-11-25', 120000, 3, 'Paulo Coelho');
    
insert into BookOrder(order_id, customer_name, book_id, order_date, delivery_date) values
	(101, 'Nguyen Hai Nam', 1, '2025-01-10', '2025-01-15'),
    (102, 'Tran Bao Ngoc', 3, '2025-02-05', '2025-02-10'),
    (103, 'Le Hoang Yen', 4, '2025-03-12', null);
    
update Book set price = price + 50000 where category_id = 1;

update BookOrder set delivery_date = '2025-12-31' where delivery_date is null;

delete from BookOrder where order_date < '2025-02-01';

select title, author_name,
	case
		when status = 1 then 'còn hàng'
        else 'hết hàng'
	end as status_name
from Book;

select b.title, b.price, c.category_name from Book as b
inner join Category as c on b.category_id = c.category_id;

select * from Book 
order by price desc limit 2;

select c.category_name, c.category_id, count(b.title) as count_book from Book as b
inner join Category as c on b.category_id = c.category_id
group by c.category_id
having count(b.title) >= 2;

select * from Book as b1
where b1.price > (
	select avg(b2.price) from Book as b2
)
