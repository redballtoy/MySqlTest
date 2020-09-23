/*
1. В базе данных shop и sample присутвуют одни и те же таблицы учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
Используйте транзакции.
*/

#создание таблицы юзеров в example
drop table if exists example.users;
create table example.users(
	id serial primary key
	,`name` varchar(255) #Имя юзера
	,birthday_at date #День рождения юзера
	,created_at datetime default current_timestamp#Дата создания записи (регистрация покупателя)
	,updated_at datetime default current_timestamp on update current_timestamp
);

insert into example.users (`name`, birthday_at)
values	('Геннадий Sample','1990-10-05')
		,('Наталья','1984-11-12')
		,('Мария','2006-08-29');
		
select * from example.users;

#создание таблицы юзеров в shop
drop table if exists shop.users;
create table shop.users(
	id serial primary key
	,`name` varchar(255) #Имя юзера
	,birthday_at date #День рождения юзера
	,created_at datetime default current_timestamp#Дата создания записи (регистрация покупателя)
	,updated_at datetime default current_timestamp on update current_timestamp
);

insert into shop.users (`name`, birthday_at)
values	('Геннадий Shop','1990-10-05')
		,('Наталья','1984-11-12')
		,('Мария','2006-08-29');
		
select * from shop.users;


#перемещение из shop в sample
start transaction;
		
		delete from example.users
		where id=1;
		select * from example.users;
		
		insert into example.users (id, name,birthday_at,created_at,updated_at)
		select id, name,birthday_at,created_at,updated_at from shop.users where id=1;
commit;

select * from example.users;


/*
2. Создайте представление, которое выводит название (name) товарной позиции из 
таблицы products и соответствующее название (name) каталога из таблицы catalogs.
*/
create or replace view prod_catalog_name as
select p.name as productName, c.name as catalogName
from products p
join catalogs c on c.id=p.catalog_id;

select * from prod_catalog_name;

/*
3. (по желанию) Пусть имеется таблица с календарным полем created_at. 
В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', 
'2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный 
список дат за август, выставляя в соседнем поле значение 1, если дата присутствует 
в исходном таблице и 0, если она отсутствует.
*/

#-----------Новое решение
drop table if exists full_august;
create table full_august (date_ date);
drop procedure if exists august_calendar;
delimiter //
create procedure august_calendar (startDate date)
begin
	declare month_, month_2 int;
	set month_ = month(startDate);
	set month_2=month_;

	while month_=month_2 do
	insert into full_august values(startDate);
	set startDate = date_add(startDate,interval 1 day);
	set month_2 = month(startDate);
	#select * from august;
	end while;

end//
delimiter ;

call august_calendar ('2018-08-01');
select * from full_august;

#--------------------------------------------------------------------


drop table if exists full_august;
create table full_august (created_at date);
insert into full_august
values ('2018-08-01')
		,('2018-08-02')
		,('2018-08-03')
		,('2018-08-04')
		,('2018-08-05')
		,('2018-08-06')
		,('2018-08-07')
		,('2018-08-08')
		,('2018-08-09')
		,('2018-08-10')
		,('2018-08-11')
		,('2018-08-12')
		,('2018-08-13')
		,('2018-08-14')
		,('2018-08-15')
		,('2018-08-16')
		,('2018-08-17')
		,('2018-08-18')
		,('2018-08-19')
		,('2018-08-20')
		,('2018-08-21')
		,('2018-08-22')
		,('2018-08-23')
		,('2018-08-24')
		,('2018-08-25')
		,('2018-08-26')
		,('2018-08-27')
		,('2018-08-28')
		,('2018-08-29')
		,('2018-08-30')
		,('2018-08-31');
		
select * from full_august;

drop table if exists search_august;
create table search_august (created_at date);
insert into search_august
values	('2018-08-01')
		,('2018-08-04')
		,('2018-08-16') 
		,('2018-08-17');

select * from search_august;


select f.created_at
,case when (select s.created_at 
			from search_august s 
			where f.created_at=s.created_at)is null 
		then 0 
		else 1 
		end as hasDate
from full_august f;

/*
4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. 
Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 
5 самых свежих записей.
*/

drop table if exists full_august_copy;
create table full_august_copy (created_at date);
insert into full_august_copy (created_at)
select created_at from full_august;

set @deletedRows = (select count(1) -5 from full_august);
select @deletedRows;
delete from full_august_copy
order by created_at asc
limit 26;

select * from full_august_copy
order by created_at desc;





