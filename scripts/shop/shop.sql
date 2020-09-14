#Учебная база данных интернет магазина shop
#create database shop;

use shop;

#создание таблицы каталога
drop table if exists catalogs;
create table catalogs(
	id int unsigned,
	name varchar(255) comment 'Название раздела'
)comment = 'Разделы интернет-магазина';

#создание таблицы полusersьзователей
drop table if exists users;
create table users(
	id int unsigned,
	name varchar(255) comment 'Имя покупателя'
)comment = 'Покупатели';

#таблица с товарными позициями
