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
			