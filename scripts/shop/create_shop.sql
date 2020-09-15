#Создание базы данных интернет магазина shop
#create database shop;

use shop;



#создание таблицы каталога
drop table if exists catalogs;
create table catalogs(
	id serial primary key
	,name_id varchar(255) #Название раздела
	,unique unique_name_catalogs(name_id(10)) #запрещает вставлять повторяющиеся значения
);

insert into catalogs 
values (default, 'Процессоры')
		,(default, 'Мат. платы')
		,(default, 'Видеокарты')
		,(default, 'Корпуса')
		,(default, 'Блоки питания');
		

#describe catalogs;
#select * from catalogs;

#создание таблицы покупателей
drop table if exists customers;
create table customers(
	id serial primary key
	,name_id varchar(255) #Имя покупателя
	,birthday date #День рождения покупателя
	,created_at datetime default current_timestamp#Дата создания записи (регистрация покупателя)
	,updated_at datetime default current_timestamp on update current_timestamp
);

insert into customers (name_id, birthday)
values	('Геннадий','1990-10-05')
		,('Наталья','1984-11-12')
		,('Александр','1985-05-20')
		,('Сергей','1988-02-14')
		,('Иван','1998-01-12')
		,('Дмитрий','1972-03-29')
		,('Мария','2006-08-29');


#select * from customers;




#таблица с товарными позициями
drop table if exists products;
create table products(
	id serial primary key
	,name_id varchar(255) #Название товара
	,description text #Описание
	,price decimal (11,2) #цена товара
	,catalog_id int unsigned
	,created_at datetime default current_timestamp #Дата создания записи 
	,updated_at datetime default current_timestamp on update current_timestamp
	,key index_of_catalog_id using btree (catalog_id)
);

INSERT INTO products
  (name_id, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);



#создание и удаление индекса в существующей таблице
#create index index_of_catalog_id using hash on products (catalog_id);
#drop index index_of_catalog_id on products;
#describe products;





#таблица заказов сделанных пользователями
drop table if exists orders;
create table  orders(
	id serial primary key
	,customer_id int unsigned
	,created_at datetime default current_timestamp #Дата создания записи 
	,updated_at datetime default current_timestamp on update current_timestamp
	,key index_of_customer_id using btree (customer_id)
);




#таблица товарных позиций в заказе
drop table if exists orders_lines;
create table   orders_lines(
	id serial primary key
	,order_id int unsigned
	,product_id int unsigned
	,total int unsigned default 1 #Количество заказанной товарной позиции
	,created_at datetime default current_timestamp #Дата создания записи 
	,updated_at datetime default current_timestamp on update current_timestamp
	
	#индексы добавляем только когда это действительно необходимо
	#,key index_of_order_id (order_id)
	#,key index_of_product_id (product_id)
	
	#составные индексы
	#,key index_of_order_id_and_product_id (order_id,product_id)
	#,key index_of_product_id_and_order_id (product_id,order_id)
);
#describe orders_lines;


#таблица для учета скидок
drop table if exists discounts;
create table   discounts(
	id serial primary key
	,customer_id int unsigned
	,product_id int unsigned
	,discount float unsigned #Велична скидки от 0.0 до 1.0
	# если оба поля null скидка бессрочная, если stop_at = null значит у интервала
	#нет ограничений
	,start_at datetime #Дата начала действия скидки 
	,stop_at datetime #Дата окончания действия скидки
	,created_at datetime default current_timestamp #Дата создания записи 
	,updated_at datetime default current_timestamp on update current_timestamp
	#эти поля для поиска будут использоваться раздельно поэтому два индекса
	,key index_of_customer_id (customer_id)
	,key index_of_product_id (product_id)
);
#describe discounts;



#таблица складов
drop table if exists warehauses;
create table   warehauses(
	id serial primary key
	,name_id varchar(255) #Наименование склада
	,created_at datetime default current_timestamp #Дата создания записи 
	,updated_at datetime default current_timestamp on update current_timestamp
);




#таблица товарных позиций на складе
drop table if exists warehause_lines;
create table   warehause_lines(
	id serial primary key
	,warehaus_id int unsigned 
	,product_id int unsigned
	,`value` int unsigned #Запас товарной позиции на складе
	,created_at datetime default current_timestamp #Дата создания записи 
	,updated_at datetime default current_timestamp on update current_timestamp
);

#тестовая таблица cat совпадающая с catalog для insert select
drop table if exists cat;
create table cat(
	id serial primary key
	,name_id varchar(255) #Название раздела
	#,unique unique_name_catalogs(name_id(10)) #запрещает вставлять повторяющиеся значения
);

#тестовая таблица cat совпадающая с catalog для insert select
drop table if exists cat_2;
create table cat_2(
	id serial primary key
	,name_id varchar(255) #Название подраздела раздела
	,id_cat bigint
	#,unique unique_name_catalogs(name_id(10)) #запрещает вставлять повторяющиеся значения
);
