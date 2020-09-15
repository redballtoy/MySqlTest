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

insert into customers(id,name_id,birthday)
values(1, 'hello','1972-03-29');

select * from customers;




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
describe discounts;



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
	,unique unique_name_catalogs(name_id(10)) #запрещает вставлять повторяющиеся значения
);
