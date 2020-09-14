#Учебная база данных интернет магазина shop
#create database shop;



use shop;

#создание таблицы каталога
drop table if exists catalogs;
create table catalogs(
	id int unsigned,
	`name` varchar(255) comment 'Название раздела'
)comment = 'Разделы интернет-магазина';

#создание таблицы полusersьзователей
drop table if exists customers;
create table customers(
	id int unsigned,
	`name` varchar(255) comment 'Имя покупателя'
)comment = 'Покупатели';

#таблица с товарными позициями
drop table if exists products;
create table products(
	id int unsigned,
	`name` varchar(255) comment 'Название',
	description text comment 'Описание',
	price decimal (11,2) comment 'Цена',
	catalog_id int unsigned
)comment = 'Товарные позиции';

#таблица заказов сделанных пользователями
drop table if exists orders;
create table  orders(
	id int unsigned,
	customer_id int unsigned
)comment = 'Заказы';

#таблица товарных позиций в заказе
drop table if exists orders_line;
create table   orders_line(
	id int unsigned,
	order_id int unsigned,
	product_id int unsigned
)comment = 'Заказы';


