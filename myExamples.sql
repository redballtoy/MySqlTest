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
select * from catalogs where `name` like '_роцес%';
select * from catalogs where `name` like '_______';#7 символов подчеркивания

#покупатели которые родились в 90-e годы
select * from customers where birthday_at>='19900101' and birthday_at<'20000101';
select * from customers where birthday_at like '199%';



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
select id, catalog_id, price, `name`
from products
order by catalog_id , price desc; #desc относится только к полю price



#------------------------LIMIT - количество извлекаемых записей
#должно всегда располагаться в конце

select id, catalog_id, price, `name`
from products 
limit 3;

# limit с указанием начала следующей страницы
select id, catalog_id, price, `name`
from products 
limit 3;
select id, catalog_id, price, `name`
from products 
limit 3,3;

#offset - альтернативное задание смещения
select id, catalog_id, price, `name`
from products 
limit 3;
select id, catalog_id, price, `name`
from products 
limit 3 offset 3;
select id, catalog_id, price, `name`
from products 
limit 3 offset 6;

#------------------------------DISTINCT
select distinct catalog_id
from products 

#-------------------------------UPDATE
#уменьшить на 10% цены на материанские платы c ценой больше 5000
#сначала получить их
select id, catalog_id, price, `name`
from products
where catalog_id=2 and price > 5000;

#после этого заменить команду select на udate
update products
set price = price*(1-0.1)
where catalog_id=2 and price > 5000;

#удалить две самые дорогие позиции
select id, catalog_id, price, `name`
from products
order by price desc
limit 2;

#заменить select на delete
delete from products
order by price desc
limit 2;

select * from products;


#----------------------INSERT INTO
#вставка всех полей
#создание таблицы юзеров в example
drop table if exists example.users;
create table example.users(
	id serial primary key
	,`name` varchar(255) #Имя юзера
	,birthday_at date #День рождения юзера
	,created_at datetime default current_timestamp#Дата создания записи (регистрация покупателя)
	,updated_at datetime default current_timestamp on update current_timestamp
);


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
		
select * from example.users;
select * from shop.users;

#перемещение пользователя с id=1 с использованием транзакции
start transaction;
insert into example.users
	select * from shop.users
	where id=1;
delete from shop.users where id=1;
commit;

-------------------------------Предопределенные функции-----------------------


#----------------------NOW() получение текущей даты и времени
select now();

#----------------------DATE() - получение даты из даты времени
select `name`,
	date(created_at) as created_at,
	date(updated_at)  updated_at
from customers;

#-------------------DATE_FORMAT - форматирование календарных типов
select * from customers;
select `name`,
	date(created_at) as created_at,
	date(updated_at) as updated_at,
	date_format(birthday_at,'%d.%m.%Y') as `День рождения`,
	date_format(birthday_at,'Родился(-ась) в %M месяце') as `Месяц рождения`
from customers;

#-------------------UNIXSTAMP - преобразование в unixstamp формат
# это количество секунд которое прошло с полуночи 1970 года по 2038 год
select unix_timestamp(now()) as dateTOunix
	,from_unixtime(unix_timestamp(now())) as unixTOdate;
	
#пример вычисления возраста пользователя
select `name`
	,floor((to_days(now()) - to_days(birthday_at))/365.25) as age
	,timestampdiff(year,birthday_at,now()) as age_preciz
from customers;

#----------------------RAND() - использование случайного порядка
select * from customers order by rand();
#получение одной случайной записи
select * from customers order by rand() limit 1;

#получение случайного значения
select rand();

#-------------------VERSION() - возвращает текущую версию sql сервера
select version() as MySqlServerVersion;

#-------------------LAST_INSERT_ID - последнее значение присвоенное при autoincrement
#на самом деле используется для внесения внешнего ключа в таблицу при автоматическом
#создании первичного ключа
truncate table cat;
insert into cat (`name`)
values('Клара'),('у'),('Карла'),('украла'),('кораллы');

insert into cat (`name`)
values('Последнее добавленное значение');


#вставляем во внешний ключ
insert into cat_2
values(default,'Подраздел 1 раздела 6 в cat',last_insert_id())
	,(default,'Подраздел 2 раздела 6 в cat',last_insert_id())
	,(default,'Подраздел 3 раздела 6 в cat',last_insert_id());
	
select cat.id as `id последнего введенного раздела в cat` 
,cat.`name` as `наименование раздела в cat`
,cat_2.id as `id подраздела в cat2` 
,cat_2.`name` as `наименование подраздела в cat_02`
from cat
join cat_2 on cat.id=cat_2.id_cat;

#----------------------DATEBASE() возвращает текущую БД
select database() as curentdatabase;

#----------------------USER() - позволяет вернуть текущего пользователя
select user() as currentuser;

#---------------------SQRT() - получение корня
select sqrt(4);
#вычисление расстояния в декартовой системе координат
# D=sqrt((x1-x2)^2 + (y1-y2)^2)
use example;

#drop table distance;
create table if not exists distance(
	id serial primary key,
	x1 int not null,
	y1 int not null,
	x2 int not null,
	y2 int not null,
	distance double as (sqrt(pow(x1-x2,2)+pow(y1-y2,2)))
);

insert into distance (x1,y1,x2,y2)
	values	(1,1,4,5),
			(4,-1,3,2),
			(-2,5,1,3);
			
select * from distance;

#вариант с использованием json
create table if not exists distance_json(
	id serial primary key,
	a json not null,
	b json not null,
	#$ - вершина коллекции, к строковым ключам x и y подключаемся через .
	distance double as (sqrt(pow(a->>'$.x'-b->>'$.x',2)+pow(a->>'$.y'-b->>'$.y',2)))
);

insert into distance_json (a,b) 
values ('{"x":1,"y":1}','{"x":4,"y":5}')
		,('{"x":4,"y":-1}','{"x":3,"y":2}')
		,('{"x":-2,"y":5}','{"x":1,"y":3}');

select * from distance_json;


#---------------------тригонометрические формулы
#вычисление площади треугольника
#S=a*b*sin(angle)/2

create table if not exists triangle_square(
	id serial primary key,
	a double not null, #first side
	b double not null, #secone side
	angle int not null,	#angel between this sides, grad
	square double as (a*b*sin(angle)/2)
);

insert into triangle_square(a,b,angle)
values 	(1.414,1,45)
		,(2.707,2.104,60)
		,(2.088,2.112,56)
		,(5.014,2.304,23)
		,(3.482,4.708,38);

select * from triangle_square;

#----------------ROUND() округление до ближайшего целого числа
select id, a , b, square,round(square,4) as square_round from triangle_square;

#---------------CEILING() всегда отругляет в большую сторону
select id, a , b, square,ceiling(square) as square_ceiling from triangle_square;

#---------------floor() всегда отругляет в меньшую сторону
select id, a , b, square,floor(square) as square_floor from triangle_square;


#-------------SUBSTRING - извлечение подстроки
use shop;
#извлечение первых 4 символов
#нумерация символов в строках всегда начинается с 1
select id, substring(`name`,1,4) from customers;

#-------------CONCAT - соединение нескольких строк
#вывод имени пользователя и его возраста через пробел
select id,
concat(`name`,' ', timestampdiff(year, birthday_at,now())) as name_age
from customers;


#--------------IF логическая операция
#Пример определение совершеннолетия пользователя
select id
,`name`
,timestampdiff(year, birthday_at,now()) as age
,if(timestampdiff(year, birthday_at,now())>=18 #условие
	,'совершеннолетний'	#true
	,'не совершеннолетний'	#false
	) as status
from customers;


#--------------CASE - в случае когда нужно проверить несколько условий

#пример цвета радуги
use example;
drop table if exists rainbow;
create table if not exists rainbow(
	id serial primary key
	,color varchar(255)
);

insert into rainbow(color)
values 	('red')
		,('orange')
		,('yellow')
		,('green')
		,('blue')
		,('indigo')
		,('violet');

select color as color_eng
	,case
		when color='red' then 'красный'
		when color='orange' then 'оранЖовый'
		when color='yellow' then 'жовтый'
		when color='green' then 'ЗеленоМалахитовый'
		when color='blue' then 'ГоЛубой'
		when color='indigo' then 'Индейский'
		when color='violet' then 'Виолетовый'
		else 'неизвестный в природе цвет'
		end as color_rus
from rainbow;

#----------------------INET_ATON - переводит ip адрес в целое число
select inet_aton('127.0.0.1');

#---------------------INET_NTOA - решает обратную задачу
select inet_ntoa(inet_aton('127.0.0.1'));

#--------------------UUID() - возвращает уникальный идентификатор
select uuid();

#---------------------GROUP BY - группировка данных

#получение уникальных значений
select catalog_id
from products
group by catalog_id;

#использование вычисляемых значений для группирования
#например группировка пользователей по десятилениям рождения

select id
	,`name`
	,substring(birthday_at,1,3) as decade
from customers
order by decade;

#получение того сколько пользователей в какую декаду родились
select substring(birthday_at,1,3) as decade
,count(1) count_users
from customers
group by substring(birthday_at,1,3)
order by decade
limit 3; 

#-----------------------GROUP_CONCAT - соединенеие строк по полю в группе
#может извлекать из группы максимум 1000 элементов (увеличить можно изменив параметр
#GROUP_CONCAT  lenght на сервере

select group_concat(`name`) #бля он чувствителен к пробелу group_concat (`name`)
, substring(birthday_at,1,3) as decade
from customers
group by decade
order by decade;

#можно задавать разделитель используя слово separator
select group_concat(`name` separator ' ') 
, substring(birthday_at,1,3) as decade
from customers
group by decade
order by decade;

#позволяет сортировать пользователей в рамках полученной строки
select group_concat(`name` order by `name` desc separator ' ') 
, substring(birthday_at,1,3) as decade
from customers
group by decade
order by decade;

#----------------------COUNT - подсчет количества значений отличных от null
#count(*) считает вместе с null
#называется агрегационными потому что их поведение изменяется при использовании
#конструкции group by (подсчет производится внутри группы)

select catalog_id,count(id) 
from products
group by catalog_id;

#использование distinct вместе с count
select count(distinct id) as total_ids,
	count(distinct catalog_id) as total_catalog_ids
from products;

#---------------------MIN, MAX - возвращают минимальное и максимальное значение столбца
#получение максимальной и минимальной цены в рамках разделов каталога
select 
	catalog_id
	,min(price) as minPrice
	,max(price) as maxPrice
from products
group by catalog_id;

#--------------------AVG - возвращает среднее значение
select 
	catalog_id
	,min(price) as minPrice
	,round(avg(price),2) as avgPrice
	,max(price) as maxPrice
from products
group by catalog_id;

#---------------SUM подсчитывает значения отличные от null
select 
	catalog_id
	,min(price) as minPrice
	,round(avg(price),2) as avgPrice
	,max(price) as maxPrice
	,round(sum(price)/count(1),2) as avgPriceSum
from products
group by catalog_id;

#--------------HAVING - использование сортировки для агрегированных значений

select substring(birthday_at,1,3) as decade
,count(1) count_users
from customers
group by substring(birthday_at,1,3)
having count_users>1
order by decade;

#допускается использование having без группировки group by
#в этом случае каждая строка таблицы рассматривается как отдельная группа
select *
from customers
having birthday_at >='1990-01-01';


#---------------------WITH ROLLUP добавление итога
select substring(birthday_at,1,3) as decade
,count(1) count_users
from customers
group by substring(birthday_at,1,3)
with rollup;


#------------------объединение UNION
#операции проводятся над наборами данных
#должны сопдать порядок столбцов, их количество и тип
#первый select в запросе определяет названия столбцов в результате

#создание таблитцы rubrics кот орая полностью совпадает с catalogs
create table if not exists rubrics(
	id serial primary key
	,`name` varchar(255) #название раздела
);

insert into rubrics
values 	(default, 'Видеокарты')
		,(default, 'Память');

select * from catalogs;
select * from rubrics;

#в результирующий запрос попадают только результирующие строки
select `name` from rubrics
union
select `name` from catalogs;

# при использовании UNION ALL будут попадать всеп значения
select `name` from rubrics
union all
select `name` from catalogs
order by name;



#-----------------Вложенные запросы
/* позволяет использовать в базовом запросе результат из другого запроса

select
	id
	,<subquery>
where
	<subquery>
group by
	id
having
	<subquery>
*/
#вложенные запросы можно использовать везде где есть ссылка на таблицу

# вложеннные запросы вставляются в скобках
(select `name` from rubrics
order by `name` desc
limit 2)

union all

(select `name` from catalogs
order by `name` desc
limit 2);

#---Пример извлечь все товары относящиеся к каталогу процессоры
select * from catalogs;
select * from products;

#коррелированый запрос
#это запрос в котором внутренний запрос использует столбец из 
#внешнего
#внутренний запрос выполняется для каждой строки внешнего
select p.id
	,p.name
	,(select name from catalogs as c
		where c.id=p.catalog_id) as 'name_catalog_item'
from products as p; 

#не коррелированный запрос вычисляющий максимальную цену товара
#внутренний запрос будет выполнен один раз для всех строк внешнего
select p.id
	,p.name
	,(select max(price) from products) as max_price_all
from products as p;

#---------------IN использование когда внутренний запрос возвращает
# более одного значения
select p.catalog_id,p.id, p.name, p.description
from products p
where p.catalog_id in (select id from catalogs);


#---------------ANY - использование для множественного сравнения
#например найти все видеокарты цена которых будет меньше ЛЮБОЙ цены
#из каталога процессоров
select id, name, price, catalog_id
from products
where catalog_id=2
and price < any(select price from products where catalog_id=1);


#----------------SOME - синоним ANY фактически работает логика ИЛИ
select id, name, price, catalog_id
from products
where catalog_id=2
and price < some (select price from products where catalog_id=1);

#---------------ALL - логика И результат истинный если выполняется
#для всех строк внутреннего запроса

select id, name, price, catalog_id
from products
where catalog_id=2
and price > all (select price from products where catalog_id=1);

#-----------EXISTS или NOT EXISTS - внутренний запрос может возвращать
#пустую таблицу, для проверки этого факта используются эти операторы
#если запрос возвращает более одной строки EXISTS возвращает истину

#Например извлечем те рзделы каталога для которых используется хоть
#одна товарная позиция

#если не указать полные квалификационные имена запрос будет работать неправильно

select * from catalogs
where exists (select * from products where products.catalog_id=catalogs.id);

#поскольку EXISTS не проверяет результат запроса а только считает количество
#возвращаемых внутренним запросом строк, то столбцами могут быть любые значения
#использование 1 ускоряет выполнение запроса
select * from catalogs
where exists (select 1 from products where products.catalog_id=catalogs.id);

#пример с not exists
#извлечение каталогов для которых нет ни одной товарной позиции
select * from catalogs
where not exists (select 1 from products where products.catalog_id=catalogs.id);


#--------ROW - использование нескольких столбцов внутреннего запроса для отбора

#Пример использования с IN вариант когда внутренний запрос возвращает
#несколько столбцов по которым производится отбор
select products.id, products.name, products.price, products.catalog_id
from products
where (products.catalog_id, 5060.00) in (select id, price from catalogs);

#Для описания такого использования можно применять ключевое слово ROW
select products.id, products.name, products.price, products.catalog_id
from products
where row (products.catalog_id, 5060.00) in (select id, price from catalogs);

#использование вложенного запроса в FROM
#вложенные запросы можно использовать везде где есть ссылка на таблицу

#например получить среднюю цену товарных позиций из для раздела процессоры
select round(avg(p.price),2) avgPrice
from (select products.id, products.name, products.price, products.catalog_id
		from products
		where catalog_id=1) p;#обязательно необходимо назначить псевдоним

#получить минимальные цены в разделах и среднюю минимальную цену
#сначала получить минимальные цены разделов
select products.catalog_id, min(products.price)
from products
group by products.catalog_id

#использовать ее как резульат вложенного запроса
select avg(p.price)
from (
		select min(products.price) as price
		from products
		group by products.catalog_id
	) p;
	
#-----------------Соединения JOIN

#Декартово произведение = X * y 
drop table if exists tbl1;
create table tbl1 (value varchar(255));
insert into tbl1 values('fst1'),('fst2'),('fst3'),('fst4');
select * from tbl1;

drop table if exists tbl2;
create table tbl2 (value varchar(255));
insert into tbl2 values('snd1'),('snd2'),('snd3'),('snd4');
select * from tbl2;

#пример соединения используя ,
select * from tbl1, tbl2;
#пример соединения используя JOINT
select tbl1.*, tbl2.* from tbl1 join tbl2;

#пример join с условием в where
#where всегда действует после соединения (сначала таблица с декартовым произведением,
#потом фильтрация)
select p.name, p.price, c.name
from catalogs c
join products p
where c.id=p.catalog_id

#пример соединения с on
# on работает в момент соединения и промежуточная таблица сразу получается не большой
select p.name, p.price, c.name
from catalogs c
join products p on c.id=p.catalog_id

#запросы с самообъединением таблиц
#использование в запросе одной и той же таблицы
select * 
from catalogs fst
join catalogs snd;

#избавимся от повторов
select * 
from catalogs fst
join catalogs snd on fst.id=snd.id;

# в случае одинаковых назаний столбцов можно использовать ключевое слово USING
select * 
from catalogs fst
join catalogs snd 
using(id);

#-------------------- LEFT JOIN
select c.name,p.name
from catalogs c
left join products p on c.id=p.catalog_id;


#использование JOIN в update запросах,
#например снижение цены материнских плат на 10%
update catalogs
join products on catalogs.id=products.catalog_id
set price = price*0.9
where catalogs.name = 'Мат. платы';
select * from products;

#при многотабличном удалении необходимо явно указывать в каких таблицах
#удаляем строки
delete products, catalogs
from catalogs 
join products on catalogs.id=products.catalog_id
where catalogs.name = 'Мат. платы';

#--------Внешние ключи и ограничения ссылочной целостности
#например удаляем первичный ключ 1 в таблице каталогов
select * from catalogs;
delete from catalogs where id=1;

#в таблице products остаются записи относящиеся к этому каталогу
select * from products
where catalog_id=1;

#удаление из таблицы catalogs привело к тому что БД перестала быть согласованной
#произощло нарушение целостности данных

#-------------------------FOREIGN KEY - ограничение поддержания целостности
/*Стратегии при удалении первичного ключа
CASCADE - автоматическое удаление записей в таблице потомке по foreign key
SET NULL - при удалении или обновлении первичного ключа в потомке foreign key=null
NO ACTIONS - в таблице потомка никаких действий не производится
RESTRICT - возникает ошибка
SET DEDAULT - как и null, только вместо null устанавливается default значение
*/

#добавление внешнего ключа в products
alter table products
add foreign key (catalog_id)
references catalogs (id)
on delete no action
on update no action;

#если идентификаторы имеют разные типы id=bigint, _id=int
#возникнет ошибка
#исправим тип внешнего ключа у catalog_id таблицы products
alter table products
change catalog_id 
catalog_id bigint unsigned default null;

show create table products;

#удаление ограничения из таблицы
alter table products
drop foreign key `products_ibfk_1`;

#добавление внешнего ключа в products c указанием своего наименования
alter table products
add constraint fk_catalog_id
foreign key (catalog_id)
references catalogs (id)
on delete no action
on update no action;

#пример использования свойства CASCAD
alter table products
drop foreign key `fk_catalog_id`;

#добавление внешнего ключа в products c указанием своего наименования
#используя каскадное обновление и удаление
alter table products
add constraint fk_catalog_id
foreign key (catalog_id)
references catalogs (id)
on delete cascade
on update cascade;

#изменим первичный ключ процессоров с 1 на 8
update catalogs
set id=8
where name='Процессоры';

select * from products;

delete from catalogs where name ='Процессоры'

#Пример использования ограничения SET NULL
alter table products
drop foreign key `fk_catalog_id`;

alter table products
add constraint fk_catalog_id
foreign key (catalog_id)
references catalogs (id)
on delete set null
on update set null;

delete from catalogs
where name = 'Мат. платы';

select * from catalogs;
select * from products;


/*-------------Transactions - транзакции как инструмент поддержания целостности данных
 транзакция это атомарная группа запросов SQL рассматриваемая как единое целое
 транзакция должна удовлетворять принципу:
	ACID:
		Atomicity - атомарность - транзакция должна функционировать как единая
			неделимая единица, вся транзакция либо выполняется либот отменяется,
			если транзакция атомарная не существует такого понятия как частично
			выполненная транзакция
		Consistency - согласованность означает что после применения транзакции БД
			должна переходить из одного непротиворечивого состояния в другое
		Isolation - изолированность подразумевает что результаты транзакции не видны 
			другим транзакциям пока она не завершится
		Durability - сохраняемость означает что изменения зафиксированные транзакцией
			остаются в БД постоянными (т.е. они должны быть записаны так что бы не 
			быть потерянными в случае сбоя системы)
*/

/*
моделирование операции оплаты клиентом покупки в интернет магазине
	- проверяется наличие на счете клиента 2000 руб
	- уменьшается сумма акаунта клиента на 2000 руб
	- увеличивается сумма аккаунта магазина на 2000 руб
все должно проходить в виде транзакции что бы все выполнилось или ничего.
*/

#создание таблицы аккаунта пользователя
drop table if exists user_account;
create table user_account(
	id serial primary key
	,user_id int #внешний ключ id пользователя
	,total decimal (11,2) #сумма на счету пользователя
	,created_at datetime default current_timestamp
	,updated_at datetime default current_timestamp on update current_timestamp
);

#заполняем таблицу
insert into user_account(user_id, total)
values(4,5000)
	,(3,0)
	,(2,200)
	,(null,2500);
	
	
#моделирование операции оплаты клиентом через транзакцию
start transaction;

#убеждаемся что у пользователя достаточно средств (4000 руб)
select total 
from user_account
where user_id=4;

#снимаем средства со счета пользователя
update user_account
set total = total-1000
where user_id=4;

#перемещаем их на счет интернет магазина (номер счета null)
update user_account
set total = total+1000
where user_id=null;

#выписка движения по счетам
select * from user_account;

#в настоящий момент изменения в рамках транзакции не сохранены в таблице
#другие пользователи в данный момент видят исходное состояние таблицы
#для того что бы изменения вступили в силу необходимо выполнить комманду COMMIT
commit;

#для отмены транзакции в момент выполнения надо воспользоваться ROLLBACK
rollback;

#для включения режима автозавершения транзакции необходимо включить режим
set autocommit=1;

/*
Уровни изоляции дополнительные настройки позволяющие снизить нагрузку на базу при
	выполнении транзакций
	
	Уровни изоляции транзакций (SQL устанавливает ими какие изменения видны внутри и
	во вне при транзакции)
	- уровни отсортированы в порядке усиления изоляции:

		READ UNCOMMITTED - транзакции могут видеть результаты не завершенных транзакций
		(используется редко потому что не имеет высокую производительность и позволяет
		видеть результаты невыполненых других транзакций - т.е. осуществляет грязное
		чтение)
	
		READ COMMITTED - видит только те изменения которые были зафиксированы другими
			транзакциями на момент ее начала, а произведенные ей изменения не видны
			другим транзакциями пока она не будет зафиксирована. - на этом уровне
			возможен феномен невоспроизводимого чтения - это означает что одна и таже
			команда может быть выполена дважды и получить различный результат
	
		REPEATABLE READ - решает проблемы которые возникают на предыдущем уровне
			гарантирует что чтение в процессе транзакции соответствует тому что было
			вставлено транзакцией. существует феномен фантомного чтения когда после
			первого прочтения некоторого диапазона строк в него произошла вставка строк
			и последующее чтение будет отличаться от предыдущего
			- этот уровень изоляции установлен mySQL по умолчанию
			
	
		SERIALIZABLE - самый высокий уровень изоляции решает проблему фантомного 
			чтения, заставляет выполнять транзакции в таком порядке что бы исключить
			возможность конфликта, блокирует каждую строку которую транзакция читает,
			на этом уровне может возникнуть множество задержек и конфликтов
			при блокировках
*/

#изменить уровень изоляции можно с помощью команды set transaction
set transaction isolation level read committed;
	/* параметр innodb_log_files_in_group=2 говорит о том что журнал транзакций
		состоит из двух файлов разером по 50 Мб которые по умолчанию размещены в 
		каталоге с данными*/	
#получить путь к каталогу данных можно с помощью запроса:
show variables like 'datadir';


#журнал транзакций - место куда сначала записывается транзакция и затем в случае
#успешности фоновым режимом перезаписывается в таблицы

#получить информацию о журнале транзакций
show variables like 'innodb_log%';
	#используется движок inobd
	#ханит все данные в файле idbata
	#транзакции помещаются в файлы ib_logfile0 и ib_logfile1 и потом перегоняются в
	#файл единого табличного пространства ibdata1
	
#управление режимом сохранения журнала транзакций включает в себя три режима
# @@innodb_flush_log_at_trx_commit=
# 0 - сохранение журнала 1 рах в секунду
# 1 - сохранение после каждой транзакции
# 2 - сохранение журнала раз в секунду и после каждой транзакции
select @@innodb_flush_log_at_trx_commit; #или
show variables like 'innodb_flush_log_at_trx_commit';

#измение значения глобальной переменной
set global innodb_flush_log_at_trx_commit = 1;

/*
MVCC - многоверсионное управление конкурентным доступом
	- идея состоит в создании мгновенных снимков состояния
	- каждая транзакция читает из согласованного списка состояния (каждая транзакция
		видит старые данные на определенный момент времени), операция чтения
		не требует никаких блокировок и не блокирует операции на запись что позволяет
		использовать длительные операции на чтение продолжая при этом обработку 
		операций записи (без какой либо конкуренции и блокировок между ними)
	MVCC работает только на :
		READ COMMITTED
		REPEATABLE READ
*/

#---------------TEMP - Временные структуры живущие только в течении сессии

#присваивание значения переменной
select @total := count(*) from products;

#в текущей сессии переменная будет доступна
select @total;

#использование переменной в запросе
#получаем максимальную цену
select @maxPrice := max(price) from products;
#получает товар с максимальной ценой
select * from products where price = @maxPrice;

#при передачи в переменную имени столбца содержащим несколько значений,
#переменная получит последнее значение
select @myPrice := price from products;
select * from products;

#имена переменных не чувствительны к регистру!
select @MYPRICE;

#переменные могут объявляться с помощью SET
set @last := now()-interval 7 day;
select @last;

#использование переменной для нумерации записей в процессе вывода данных из таблицы
set @start := 0;
select @start:=@start+ 1 as id, name from products;

# @@ системные переменные
# получить полный список системных переменных
show variables like 'version%';

/*
Типы системных переменных:
	GLOBAL - глобальные (при старте сервера происходит инициализация переменных значением по
		умолчанию)
	SESSION - сеансовые переменные при создании сеанса получают значения заданные для
		глобальных переменных)

*/
#Изменение значения глобальной переменной
set global read_buffer_size := 2097152;
set @@read_buffer_size := 2097152;
select @@read_buffer_size;

#изменение значения сессионной переменной
set session read_buffer_size = 2048;
set @session.read_buffer_size = 1024;
set @read_buffer_size = 1024;#работает только эта
set read_buffer_size =default; #присволение локальной переменной значения глобальной
select @read_buffer_size;


#------------TEMPORARY -------временные таблицы
create temporary table temp (id int, name varchar(255));
select * from temp;
show tables;#временная таблица отсутствует в списке таблиц
describe temp; #однако все равно можеи запросить ее описание

#временные таблицы хранятся во временном пространстве ibtmp1


#-----------PREPARE = dynamic query - динамические запросы
#это запросы которые пользователи могут сохранять в переменные
#ограничения:
	#не допускается использование вложенных динамических запросов или нескольких запросов
	#параметр всегда передает строку поэтому задать имя столбца не получится
	
prepare ver from 'select version()';
execute ver;

#параметризованные динамические запросы на примере извлечения позиций определенного каталога
prepare prd from 'select id, name, price from products where catalog_id=?';
set @catalog_id=1;
#передача параметра с использованием конструкции using
execute prd using @catalog_id;

#удаление динамического запроса
drop prepare prd;


#--------------------VIEW - представление 
/*
- представление - это запрос на выборку которому присваивается уникальное имя и который
- можно сохранять и удалять в БД как обычную таблицу
- представление позволяет увидеть результат запроса как если бы это была простая таблица
- позволяют более гибко задавать права доступа к таблицам.
- при создании вьюшки тип данных берется из исходной таблицы
*/

#пример создания представления таблицы каталог в котором записи будут отсортированы
create view cat_w as
select * from catalogs
order by name;

select * from cat_w;

show tables;# данное представление появилось в списке таблиц (рассматривается как таблица)

#использование вычисляемых стольцов и тип записи при создании
create or replace view cat_w (id, name, lengthName) as
select id, name, length(name) from catalogs;
select * from cat_w;


#--------------ALGORITHM - ключевое слово определяющее взаимодействие 
#конечного запроса с представлением
/*
- может принимать три значения:
	- MERGE - запрос так объединяется с представлением что представление заменяет 
		соответствующие части в запросе
	- TEMPTABLE - результирующая таблица представления помещается во временную таблицу,
		которая затем используется во внешнем запросе
	- UNDEFINED - СУБД самостоятельно пытается выбрать алгоритм (предпочитает MERGE)
*/

#требуем создавать таблицу при каждом обращении к представлению
create algorithm = temptable view cat2 as select * from catalogs;
show tables;

#вертикальные представления - это представления в которых извлекается только часть столбцов
describe products;

create or replace view prod_w as
select id, name, price, catalog_id
from products
order by catalog_id;

select * from prod_w;

#горизонтальные представления - это представления ограничивающие доступ пользователей к 
#строкам таблиц
create or replace view processors_w as
select id, name, price, catalog_id
from products
where catalog_id=1;

select * from processors_w;

#добавление и удаление записей через представление
#при добавлении и удалении записей необходимо убедиться что параметры запроса удовлетворяют
# данным запроса

create table if not exists tbl1 (value varchar(255));
insert into tbl1
values ('fst1'),('fst2'),('fst3');
select * from tbl1;

#создание обновляемого представления
create view v1 as
select * from tbl1 where value<'fst5'
with check option;

#при попытке вставить fst5 срабатывает ограничение на условие
insert into v1 values ('fst5');

#отредактировать представление можно командаой ALTER
alter view v1 as
select * from tbl1 where value >'fts4'
with check option;

#или эквивалентный вариант
create or replace view v1 as
select * from tbl1 where value >'fts4'
with check option;


#для удаления
drop view if exists v1;


select * from v1;




