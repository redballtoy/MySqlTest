#Работа с типами данных строки
use example;
			
drop table if exists tbl ;
create table tbl(
	name char(10) default 'anonimus',
	description varchar(255)
	);
					
insert into tbl values(default, 'Новый пользователь');
insert into tbl values('Вадим', 'Новый пользователь');
#слишком длиное поле для типа name
#insert into tbl values('Очень длинное имя пользователя', 'Новый пользователь');
select * from tbl;
			
			
#Проверка работы с null
select null+2;

drop table  if exists tbl;
create table tbl (id int unsigned);
insert into tbl values();

select * from tbl

#-------------------------ALTER TABLE-------------------------------

#Пример использования ALTER TABLE
alter table tbl
change id #Определяем какой столбец будем менять
id int unsigned not null; #Новое определение столбца


#-----------------------------TRUNCATE
#TRUNCATE Пример использования
insert into tbl values(1);
select * from tbl;
truncate tbl;
select * from tbl;

#------------------------DECRIBE вывод описания таблицы
describe tbl;



#-----------------------Пример использования календарных типов данных
select '2020-09-15 0:00:00' date_;

#INTERVAL операция с датами
select '2020-09-15 0:00:00' - interval 1 day date_;
select '2020-09-15 0:00:00' + interval 1 week date_;
select '2020-09-15 0:00:00' + interval 1 year date_;
#комбинированные интервалы, прибавить один год и 1 месяц
select '2020-09-15 0:00:00' + interval '1-1' year_month date_;



#----------------------GSON пример использования формата gson
describe tbl;

alter table tbl
add collect JSON;

#добавление новой записи в json объект
insert into tbl
values(1,'{"first":"Hello", "second": "World"}');

select * from tbl

#можно обращаться не только к полям но и ключаи JSON поля
select collect->>"$.first" from tbl;

#----------------------------Арифметические операторы

#остаток от деления
select 10%3, 10%5;

#целочисленное деление
select 10 div 3, 10 div 5;

#создание вычисляемых столбцов которые могут быть сохранены (stored) на диск и 
#даже проиндексированы
use example;
drop table if exists tbl;
create table tbl(
	x int,
	y int,
	sum int as (x+y) stored
);

insert into tbl values (2,3,default);
select * from tbl;

#---------------------------------WHERE Фильтрация---------------------------

use shop;
select * from catalogs;

#BETWEEN
select * from catalogs where id>2 and id<=4;
select * from catalogs where id between 2 and 4;
select * from catalogs where id not between 2 and 4;


#IN
select * from catalogs where id in (2,4);

#LIKE
select * from catalogs where name_id like '_роцес%';
select * from catalogs where name_id like '_______';#7 символов подчеркивания

#покупатели которые родились в 90-e годы
select * from customers where birthday>='19900101' and birthday<'20000101';
select * from customers where birthday like '199%';



#----------------RLIKE или REGEXP поиск с использованием регулярных выражений

# ^ - начало строки
select 'программированик' rlike '^грам', 'граммпластинка' rlike '^грам';

# $  - конец строки
select 'граммпластинка' rlike '^граммпластинка$', # должно полностью соответствовать строке
 'граммпластинка на столе' rlike '^граммпластинка$';

# | - альтернативы
select 'abc' rlike 'abc|abb', 'abb' rlike 'abc|aba';

# [] задание символов которыми ограничен поиск
select 	'a' rlike '[abc]' as a, 
		'b' rlike '[abc]' as b,
		'w' rlike '[abc]' as w;
#можно использовать диапазон  
select 	'а' rlike '[а-т]' as а, 
		'b' rlike '[а-т]' as b,
		'ю' rlike '[а-т]' as ю;

select 7 rlike '[0-7]';

#использование классов '[[:class:]]'
select 7 rlike '[[:digit:]]' as '7',
'7' rlike '[[:digit:]]' as '7_str',
'7a' rlike '[[:digit:]]' as '7a_str',
'a' rlike '[[:digit:]]' as 'a_str';

#квантификаторы
select '1' rlike '^[0-9]+$' as '1',
	'34234' rlike '^[0-9]+$' as '34234',
	'342.34' rlike '^[0-9]+$' as '342.34',
	'' rlike '^[0-9]+$' as '';

#-------------------------ORDER BY
select id, catalog_id, price, name_id
from products
order by catalog_id , price desc; #desc относится только к полю price



#------------------------LIMIT - количество извлекаемых записей
select id, catalog_id, price, name_id
from products 
limit 3;

# limit с указанием начала следующей страницы
select id, catalog_id, price, name_id
from products 
limit 3;
select id, catalog_id, price, name_id
from products 
limit 3,3;

#offset - альтернативное задание смещения
select id, catalog_id, price, name_id
from products 
limit 3;
select id, catalog_id, price, name_id
from products 
limit 3 offset 3;
select id, catalog_id, price, name_id
from products 
limit 3 offset 6;

#------------------------------DISTINCT
select distinct catalog_id
from products 

#-------------------------------UPDATE
#уменьшить на 10% цены на материанские платы c ценой больше 5000
#сначала получить их
select id, catalog_id, price, name_id
from products
where catalog_id=2 and price > 5000;

#после этого заменить команду select на udate
update products
set price = price*(1-0.1)
where catalog_id=2 and price > 5000;

#удалить две самые дорогие позиции
select id, catalog_id, price, name_id
from products
order by price desc
limit 2;

#заменить select на delete
delete from products
order by price desc
limit 2;

select * from products;

-------------------------------Предопределенные функции-----------------------


#----------------------NOW() получение текущей даты и времени
select now();

#----------------------DATE() - получение даты из даты времени
select name_id,
	date(created_at) as created_at,
	date(updated_at)  updated_at
from customers;

#-------------------DATE_FORMAT - форматирование календарных типов
select * from customers;
select name_id,
	date(created_at) as created_at,
	date(updated_at) as updated_at,
	date_format(birthday,'%d.%m.%Y') as `День рождения`,
	date_format(birthday,'Родился(-ась) в %M месяце') as `Месяц рождения`
from customers;

#-------------------UNIXSTAMP - преобразование в unixstamp формат
# это количество секунд которое прошло с полуночи 1970 года по 2038 год
select unix_timestamp(now()) as dateTOunix
	,from_unixtime(unix_timestamp(now())) as unixTOdate;
	
#пример вычисления возраста пользователя
select name_id
	,floor((to_days(now()) - to_days(birthday))/365.25) as age
	,timestampdiff(year,birthday,now()) as age_preciz
from customers;

#----------------------RAND() - использование случайного порядка
select * from customers order by rand();
#получение одной случайной записи
select * from customers order by rand() limit 1;

#-------------------VERSION() - возвращает текущую версию sql сервера
select version() as MySqlServerVersion;

#-------------------LAST_INSERT_ID - последнее значение присвоенное при autoincrement
#на самом деле используется для внесения внешнего ключа в таблицу при автоматическом
#создании первичного ключа
truncate table cat;
insert into cat (name_id)
values('Клара'),('у'),('Карла'),('украла'),('кораллы');

insert into cat (name_id)
values('Последнее добавленное значение');


#вставляем во внешний ключ
insert into cat_2
values(default,'Подраздел 1 раздела 6 в cat',last_insert_id())
	,(default,'Подраздел 2 раздела 6 в cat',last_insert_id())
	,(default,'Подраздел 3 раздела 6 в cat',last_insert_id());
	
select cat.id as `id последнего введенного раздела в cat` 
,cat.name_id as `наименование раздела в cat`
,cat_2.id as `id подраздела в cat2` 
,cat_2.name_id as `наименование подраздела в cat_02`
from cat
join cat_2 on cat.id=cat_2.id_cat;

#----------------------DATEBASE() возвращает текущую БД
select database() as curentdatabase;

#----------------------USER() - позволяет вернуть текущего пользователя
select user() as currentuser;



