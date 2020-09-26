/*
1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
catalogs и products в таблицу logs помещается время и дата создания записи, 
название таблицы, идентификатор первичного ключа и содержимое поля name.
*/

/*
создание таблиц для тестирования
*/

use shop;


#создание таблицы юзеров
drop table if exists users;
create table users(
	id serial primary key
	,`name` varchar(255) #Имя юзера
	,birthday_at date #День рождения юзера
	,created_at datetime default current_timestamp#Дата создания записи (регистрация покупателя)
	,updated_at datetime default current_timestamp on update current_timestamp
);

insert into users (`name`, birthday_at)
values	('Геннадий','1990-10-05')
		,('Наталья','1984-11-12')
		,('Александр','1985-05-20')
		,('Сергей','1988-02-14')
		,('Иван','1998-01-12')
		,('Дмитрий','1972-03-29')
		,('Мария','2006-08-29');

#создание таблицы каталога
drop table if exists catalogs;
create table catalogs(
	id serial primary key
	,`name` varchar(255) #Название раздела
	,unique unique_namecatalogs(`name`(10)) #запрещает вставлять повторяющиеся значения
	,created_at datetime default current_timestamp
);

insert into catalogs (`name`)
values ('Процессоры')
		,('Мат. платы')
		,('Видеокарты')
		,('Корпуса')
		,('Блоки питания');
		
#таблица с товарными позициями
drop table if exists products;
create table products(
	id serial primary key
	,`name` varchar(255) #Название товара
	,description text #Описание
	,price decimal (11,2) #цена товара
	,catalog_id int unsigned
	,created_at datetime default current_timestamp #Дата создания записи 
	,updated_at datetime default current_timestamp on update current_timestamp
	,key index_of_catalog_id using btree (catalog_id)
);

INSERT INTO products
  (`name`, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);


#----------создание таблицы logs
drop table if exists logs_;
create table logs_(
	id_other bigint
	,`name` varchar(255) 
	,`table_name` varchar(255)
	,created_at datetime #Дата создания записи 
)engine = Archive;

#триггер на вставку для таблицы catalogs
drop trigger if exists catalog_id_insert;
delimiter //
create trigger catalog_id_insert after insert on catalogs
for each row
begin
	insert into logs_ (id_other,`name`,`table_name`,created_at)
	values(new.id, new.name, 'catalogs',new.created_at);
	
end//
delimiter //

#триггер на вставку для таблицы users
drop trigger if exists users_id_insert;
delimiter //
create trigger users_id_insert after insert on users
for each row
begin
	insert into logs_ (id_other,`name`,`table_name`,created_at)
	values(new.id, new.name, 'users',new.created_at);
	
end//
delimiter //

#триггер на вставку для таблицы products
drop trigger if exists products_id_insert;
delimiter //
create trigger products_id_insert after insert on products
for each row
begin
	insert into logs_ (id_other,`name`,`table_name`,created_at)
	values(new.id, new.name, 'products',new.created_at);
	
end//
delimiter //


#проверка на вставку catalogs
insert into catalogs (`name`)
values ('Кулеры');

#проверка на вставку users
insert into users (`name`, birthday_at)
values	('Василий','1996-12-08')

#проверка на вставку products
insert into products (`name`, description, price, catalog_id)
values	('AMD Ryzen 7 3800X', 'Процессор для настольных персональных компьютеров, 
		основанных на платформе AMD.', 23000.00, 1)



#Просмотр результата
select * from catalogs order by created_at desc;
select * from users order by created_at desc;
select * from products order by created_at desc;
select * from logs_;

		
	