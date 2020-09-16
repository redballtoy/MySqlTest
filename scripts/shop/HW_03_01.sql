/*
В таблице users поля created_at и updated_at заполнить
текущей датой и временем
*/

use example;
drop table if exists users;
create table if not exists users(
	id serial primary key
	,name_id varchar(255) #Имя пользователя
	,birthday date #День рождения пользователя
	,created_at datetime default null
	,updated_at datetime default null
);

insert into users (name_id, birthday)
values	('Геннадий','1990-10-05')
		,('Наталья','1984-11-12')
		,('Александр','1985-05-20')
		,('Сергей','1988-02-14')
		,('Иван','1998-01-12')
		,('Дмитрий','1972-03-29')
		,('Мария','2006-08-29');
		

#заполняем created_at, updated_at
update users
set created_at = now()
	,updated_at = now();
	
#результат заполнения
select * from users;
	

/*
В таблице users ошибочно заведенное поле created_at и updated_ типа
varchar имеют значения типа '20.10.2017 8:10', необходимо 
преобразовать поля к типу datetime без потери данных
*/
drop table if exists users;
create table if not exists users(
	id serial primary key
	,name_id varchar(255) #Имя пользователя
	,birthday date #День рождения пользователя
	,created_at varchar(255) 
	,updated_at varchar(255) 
	,created_at_date datetime  null
	,updated_at_date datetime  null
);

insert into users (name_id, birthday,created_at,updated_at )
values	('Геннадий','1990-10-05','20.10.2017 8:10','20.10.2017 8:10')
		,('Наталья','1984-11-12','20.10.2017 8:10','20.10.2017 8:10')
		,('Александр','1985-05-20','20.10.2017 8:10','20.10.2017 8:10')
		,('Сергей','1988-02-14','20.10.2017 8:10','20.10.2017 8:10')
		,('Иван','1998-01-12','20.10.2017 8:10','20.10.2017 8:10')
		,('Дмитрий','1972-03-29','20.10.2017 8:10','20.10.2017 8:10')
		,('Мария','2006-08-29','20.10.2017 8:10','20.10.2017 8:10');

#исходная таблица
select * from users;

		
/*
select 
	date_format(
				str_to_date(
						concat(substring(created_at,4,2),'/'
								,substring(created_at,1,2),'/'
								,substring(created_at,7,char_length(created_at)),
								' AM')
						,'%c/%e/%Y %H:%i')
			,'%Y-%m-%d %H:%m:%s')
from users;
*/

/*
взято отсюда
https://overcoder.net/q/67841/%D0%BD%D0%B5%D0%B2%D0%B5%D1%80%D0%BD%D0%BE%D0%B5-%D0%B7%D0%BD%D0%B0%D1%87%D0%B5%D0%BD%D0%B8%D0%B5-%D0%B4%D0%B0%D1%82%D1%8B-%D0%B8-%D0%B2%D1%80%D0%B5%D0%BC%D0%B5%D0%BD%D0%B8-%D0%BD%D0%BE%D0%BC%D0%B5%D1%80-%D0%BE%D1%88%D0%B8%D0%B1%D0%BA%D0%B8-%D0%B1%D0%B0%D0%B7%D1%8B-%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85-1292
иначе не вставляет 
*/

#SELECT @@GLOBAL.sql_mode global, @@SESSION.sql_mode session;
SET sql_mode = '';
SET GLOBAL sql_mode = '';


#обновление дат
update users
set created_at_date = (
						date_format(
										str_to_date(
												concat(substring(created_at,4,2),'/'
														,substring(created_at,1,2),'/'
														,substring(created_at,7,char_length(created_at)),
														' AM')
												,'%c/%e/%Y %H:%i')
									,'%Y-%m-%d %H:%m:%s')
						) 
						
						
	,updated_at_date = 
						date_format(
										str_to_date(
												concat(substring(updated_at,4,2),'/'
														,substring(updated_at,1,2),'/'
														,substring(updated_at,7,char_length(created_at)),
														' AM')
												,'%c/%e/%Y %H:%i')
									,'%Y-%m-%d %H:%m:%s')
						
						;
#финальный результат
select * from users;

/*
РЕШЕНИЕ ПРЕПОДАВАТЕЛЯ
---------------------------------------------------------------------
*/
#преобразовываем значения используя функцию str_to_date

select created_at,
str_to_date(created_at, '%d.%m.%Y %k:%i')
from users;

update users
set created_at_date = str_to_date(created_at, '%d.%m.%Y %k:%i')
,updated_at_date = str_to_date(updated_at, '%d.%m.%Y %k:%i');

select * from users;
#------------------------------------------------------------------



/*
В таблице складских запасов storehouses_products в поле value могут 
встречаться самые разные цифры: 0, если товар закончился и выше нуля, 
если на складе имеются запасы. Необходимо отсортировать записи таким 
образом, чтобы они выводились в порядке увеличения значения value. 
Нулевые запасы должны выводиться в конце, после всех записей.
*/
use example;

drop table if exists warehause_lines;
create table   warehause_lines(
	id serial primary key
	,warehaus_id int unsigned 
	,product_id int unsigned
	,`value` int unsigned #Запас товарной позиции на складе
	,created_at datetime default current_timestamp #Дата создания записи 
	,updated_at datetime default current_timestamp on update current_timestamp
);

insert into warehause_lines (warehaus_id,product_id,`value`)
values (1,2,3)
		,(1,4,8)
		,(1,6,1)
		,(1,9,0);

select warehaus_id,product_id,`value`, if(value=0 ,1,0) as k
from warehause_lines
#order by k asc ,`value` desc;


/*
Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
Месяцы заданы в виде списка английских названий ('may', 'august')
*/

#создание таблицы покупателей
drop table if exists users;
create table users(
	id serial primary key
	,name_id varchar(255) #Имя покупателя
	,birthday date #День рождения покупателя
	,created_at datetime default current_timestamp#Дата создания записи (регистрация покупателя)
	,updated_at datetime default current_timestamp on update current_timestamp
);

insert into users (name_id, birthday)
values	('Геннадий','1990-10-05')
		,('Наталья','1984-11-12')
		,('Александр','1985-05-20')
		,('Сергей','1988-02-14')
		,('Иван','1998-01-12')
		,('Дмитрий','1972-03-29')
		,('Мария','2006-08-29');
		

#создание таблицы месяцев
drop table if exists two_month;
create table two_month(
	id serial primary key
	,two_month_name varchar(255)
	,two_month_name_key varchar(255)
	);
	
insert into two_month (two_month_name,two_month_name_key)
values ('may','May')
,('august','August');

select * from two_month;
		
select name_id, 
birthday
,date_format(birthday,'%M') as `Месяц рождения`,
two_month_name
from users
join two_month on date_format(birthday,'%M')=two_month_name_key;

/*
Из таблицы catalogs извлекаются записи при помощи запроса. 
SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
Отсортируйте записи в порядке, заданном в списке IN.
*/

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
		
select * from catalogs
where id in(5, 1, 2)
order by field (id,5,1,2);



