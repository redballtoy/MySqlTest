/*
1. Составьте список пользователей users, которые осуществили хотя бы один заказ 
(orders) в интернет-магазине.
*/

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


drop table if exists orders;
create table  orders(
	id serial primary key
	,user_id int unsigned
	,created_at datetime default current_timestamp #Дата создания записи 
	,updated_at datetime default current_timestamp on update current_timestamp
	,key index_of_user_id using btree (user_id)
);

insert into orders
values(default,2,default,default)
		,(default,4,default,default)
		,(default,7,default,default)
		,(default,2,default,default);
		
select * from users;
select * from orders;
select u.id as user_id, name as name_user
from users u
where exists (select id from orders o where u.id=o.user_id);




/*
2. Выведите список товаров products и разделов catalogs, который соответствует товару.
*/

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

#создание таблицы каталога
drop table if exists catalogs;
create table catalogs(
	id serial primary key
	,`name` varchar(255) #Название раздела
	,unique unique_namecatalogs(`name`(10)) #запрещает вставлять повторяющиеся значения
);

insert into catalogs 
values (default, 'Процессоры')
		,(default, 'Мат. платы')
		,(default, 'Видеокарты')
		,(default, 'Корпуса')
		,(default, 'Блоки питания');
		
select p.id as product_id, 
	p.`name` as products_name, 
	c.`name` as catalog_name
from products p
join catalogs c on p.catalog_id=c.id




/*
3. (по желанию) Есть таблица рейсов flights (id, from, to) и таблица городов cities 
(label, name). Поля from, to и label содержат английские названия городов, 
поле name — русское. Выведите список рейсов (flights) с русскими названиями городов.
*/
drop table if exists flights;
create table flights(
	id serial primary key
	,from_ varchar(255) 
	,to_ varchar(255)
);

insert into flights
values (default,'moscow','omsk')
		,(default,'novgorod','kazan')
		,(default,'irkutsk','moscow')
		,(default,'omsk','irkutsk')
		,(default,'moscow','kazan');

select * from flights;

drop table if exists cities;
create table cities(
	labels varchar(255) primary key
	,name_ varchar(255)
);

insert into cities
values ('moscow','Москва')
		,('irkutsk','Иркутск')
		,('novgorod','Новгород')
		,('kazan','Казань')
		,('omsk', 'Омск');
select * from cities;

select 
f.id as id_flights
,f.from_ as fromEn
,(select name_ from cities c where f.from_=c.labels ) as fromRu
,f.to_ as toEn
,(select name_ from cities c where f.to_=c.labels ) as toRu
from flights f;
