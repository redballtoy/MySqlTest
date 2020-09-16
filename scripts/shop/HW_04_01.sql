/*
Подсчитайте средний возраст пользователей в таблице users.
*/

use example;

#создание таблицы users
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

select 
	round(avg(timestampdiff(year,birthday,now())),0) avr_age
from users;	


/*
Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
Следует учесть, что необходимы дни недели текущего года, а не года рождения.
*/

select 
#name_id, birthday,dayofweek(concat('2020-',substring(birthday,6,5))),
case 
	when dayofweek(concat('2020-',substring(birthday,6,5))) = 1 then 'Воскресенье'
	when dayofweek(concat('2020-',substring(birthday,6,5))) = 2 then 'Понедельник'
	when dayofweek(concat('2020-',substring(birthday,6,5))) = 3 then 'Вторник'
	when dayofweek(concat('2020-',substring(birthday,6,5))) = 4 then 'Среда'
	when dayofweek(concat('2020-',substring(birthday,6,5))) = 5 then 'Четверг'
	when dayofweek(concat('2020-',substring(birthday,6,5))) = 6 then 'Пятница'
	when dayofweek(concat('2020-',substring(birthday,6,5))) = 7 then 'Суббота'
	end as dayofweek,
	count(1) birthdayOfWeek
from users
group by dayofweek
;

#Вариант преподавателя
select 
#name_id, birthday,year(now()) year_, month(birthday) month_, day(birthday) day_,
#date(concat_ws('-',year(now()),month(birthday),day(birthday))) as date2020,
date_format(date(concat_ws('-',year(now()),month(birthday),day(birthday))),'%W') as dayWeek
,count(*) countBirthday
from users
group by dayWeek;



#Подсчитайте произведение чисел в столбце таблицы.

drop table  tbl2;
create table tbl2 (val int);
insert into tbl2 values(1),(2),(3),(4),(5);
select * from tbl2;

select round(exp(sum(log(val))),0) multi from tbl2;

		