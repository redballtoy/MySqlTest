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

#Пример использования ALTER TABLE
alter table tbl
change id #Определяем какой столбец будем менять
id int unsigned not null; #Новое определение столбца

#TRUNCATE Пример использования
insert into tbl values(1);
select * from tbl;
truncate tbl;
select * from tbl;

#DECRIBE вывод описания таблицы
describe tbl;



#Пример использования календарных типов данных
select '2020-09-15 0:00:00' date_;

#INTERVAL операция с датами
select '2020-09-15 0:00:00' - interval 1 day date_;
select '2020-09-15 0:00:00' + interval 1 week date_;
select '2020-09-15 0:00:00' + interval 1 year date_;
#комбинированные интервалы, прибавить один год и 1 месяц
select '2020-09-15 0:00:00' + interval '1-1' year_month date_;



#GSON пример использования формата gson
describe tbl;

alter table tbl
add collect JSON;

#добавление новой записи в json объект
insert into tbl
values(1,'{"first":"Hello", "second": "World"}');

select * from tbl

#можно обращаться не только к полям но и ключаи JSON поля
select collect->>"$.first" from tbl;
