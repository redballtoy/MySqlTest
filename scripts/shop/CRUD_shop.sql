#CRUD операции по БД shop

use shop;

#----------------------------INSERT - вставка данных
/*
#однострочная вставка
insert into catalogs (name_id) values ('Процессоры');
#Использование null или 0 все равно приводит к использованию autoincrement
insert into catalogs values (null,'Мат. платы');
insert into catalogs values (0,'Видеокарты');
*/


#многострочная вставка работает гораздо быстрее
insert into catalogs 
values (default, 'Процессоры')
		,(default, 'Мат. платы')
		,(default, 'Видеокарты')
		,(default, 'Корпуса')
		,(default, 'Блоки питания');
		


#Допустима запись с измененным порядком столбцов
insert into catalogs(name_id, id) values('Блоки питания', null);

#использование default все равно приводит к использованию автоинкремента если она
#был задан
insert ignore into catalogs(name_id, id) values('Корпуса', default);
#insert ignore into catalogs(name_id, id) values('Корпуса', default);


#---------------------SELECT извлечение данных

# при использовании * столбцы выводятся в том порядке
#в котором они определены в CREATE TABLE
select * from catalogs;


#-------------------DELETE удаление данных

#delete from
delete from catalogs;

#удаление ограниченного числа записей
#например 3
delete from catalogs limit 3;

#удаление ограниченного числа записей #WHERE
delete from catalogs
where id>10;


#truncate
truncate catalogs;

#-----------------UPDATE обновление

update catalogs
set name_id='Процессоры (Intel)'
where name_id='Процессоры';

#---------------INSERT SELECT вставка данных из одной таблицы в другую
#вставка из таблицы catalog в таблицу cat
select * from cat;
select * from catalogs;

insert into cat
select id, name_id from catalogs where id >2;



