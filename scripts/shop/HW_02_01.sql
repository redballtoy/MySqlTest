#Домашнее задание 02

/*
В таблице catalogs БД shop в строке name могут храниться пустые
и null значения
Нужно написать запрос который заменяет такие поля на 'empty'

*/

drop database if exists shop;
create database shop;

use shop;

#создание таблицы каталога
drop table if exists catalogs;
create table catalogs(
	id serial primary key
	,name_id varchar(255) #Название раздела
);

insert into catalogs
values	(default, 'Раздел каталога 1')
		,(default, 'Раздел каталога 2')
		,(default, '')
		,(default, null)
		,(default, 'Раздел каталога 6')
		,(default, 'Раздел каталога 7');
	
#select * from catalogs;

#запрос на изменение нулевых или пустых значений
update catalogs
set name_id = 'empty'
where name_id='' or name_id is null;

select * from catalogs;

#------------------------------------------------------------------------------

/*
Спроектировать БД которая позволяла бы хранить медиафайлы загружаемые
пользователем (фото, аудио, видео)
Сами файлы будут храниться в файловом хранилище
база данных предназначена для хранения пути к файлу, названию, описания,
ключевых слов и принадлежности пользователю
*/

drop database if exists mediabase;
create database mediabase;

use mediabase;

#таблица хранения атрибутов медиа
drop table if exists media_item;
create table media_item(
	id serial primary key
	,media_name varchar(255) #Название медиа
	,media_describe text #описание медиа
	,media_type_id tinyint #тип медия (фото, аудио, видео)
	,user_id int #id пользователя которому принадлежит запись
	,key_words set ('рок','поп','эстрада','реп','нравится','не нравится','песни из кинофильмов')
	,path_media varchar(255) #путь к медиа
	,created_at datetime default current_timestamp #Дата создания записи 
	,updated_at datetime default current_timestamp on update current_timestamp
	
);

#select * from media_item;


#таблица типов медиа
drop table if exists media_type;
create table media_type(
	id serial primary key
	,media_name_id varchar(255) #Название медиа
	,created_at datetime default current_timestamp #Дата создания записи 
	,updated_at datetime default current_timestamp on update current_timestamp
	);


insert into media_type
values 	(default, 'Audio', default, default)
		,(default, 'Video', default, default)
		,(default, 'Photo', default, default);

#select * from media_type;

#создание таблицы пользователей
drop table if exists users;
create table users(
	id serial primary key
	,name_id varchar(255) #Имя пользователя
	,birthday date #День рождения пользователя
	,created_at datetime default current_timestamp#Дата создания записи (регистрация покупателя)
	,updated_at datetime default current_timestamp on update current_timestamp
);

insert into users
values 	(default, 'Грозный Иван Васильевич','1530-08-25',default, default );
#select * from users;


insert into media_item
values (
	default
	,'Песня Ивана Царевича'
	,'Песня прозвучавшая в фильме про Ивана Царевича'
	,2
	,1
	,'песни из кинофильмов,нравится'
	,'\my_mediateca\audio_01.mp4'
	,default
	,default); 	

#select * from media_item;

#выгрузка данных медиа принадлежащих Грозный Иван Васильевич
select media_describe
	,key_words
	,path_media
	,media_type.media_name_id
	,users.name_id
	,users.birthday
	,media_item.updated_at
from media_item
join media_type on media_item.media_type_id=media_type.id
join users on media_item.user_id=users.id
where users.name_id='Грозный Иван Васильевич';

