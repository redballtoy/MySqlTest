/*
1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать 
фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — 
"Доброй ночи".
*/


drop procedure if exists example.hello;
delimiter //
create procedure example.hello()
begin
	#declare totalOrder int default 0;
	declare currentTime time default '00:00';
	set currentTime = date_format(now(), '%H:%i');
	select currentTime as currentTime,
	case 
		when currentTime between '06:00' and '12:00' 
			then 'Доброе утро'
		when currentTime between '12:00' and '18:00' 
			then 'Добрый день'
		when currentTime between '18:00' and '00:00' 
			then 'Добрый вечер'
		when currentTime between '00:00' and '06:00' 
			then 'Доброй ночи'	
		else 'no time'
		end as hello;
end//
delimiter ;

call example.hello();

#--------------------Решение преподавателя
#создаем функцию для получения текущего часа:
drop function if exists get_hour;
delimiter //
create function get_hour()
returns int deterministic #не работает с not deterministic
begin
	return hour(now());
end//
delimiter ;

#создаем конечную функцию
drop function if exists hello;
delimiter //
create function hello()
returns tinytext 





/*
2. В таблице products есть два текстовых поля: name с названием товара и description с 
его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда 
оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, 
добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке 
присвоить полям NULL-значение необходимо отменить операцию.
*/

#таблица с товарными позициями
drop table if exists products;
create table products(
	id serial primary key
	,`name` varchar(255) #Название товара
	,description text #Описание
	,price decimal (11,2) #цена товара
	,catalog_id int unsigned
	,created_at datetime default current_timestamp #Дата создания записи 
	,updated_at datetime default current_timestamp on update current_timestamp
	,key index_of_catalog_id using btree (catalog_id)
);

INSERT INTO products
  (`name`, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

select * from products;

#оба вставляемых поля не должны быть не null.
drop trigger if exists check_not_null_products_name_on_insert;
delimiter //
create trigger check_not_null_products_name_on_insert before insert on products
for each row
begin
	if(new.name is null and new.description is null) then
		signal sqlstate '45000' set message_text='INSERT canceled';
	end if;
end//
delimiter //	

#проверка
insert into products (name, description, price, catalog_id)
values('name_1',null,1000,1);
insert into products (name, description, price, catalog_id)
values(null,'description 2',1000,1);
insert into products (name, description, price, catalog_id)
values(null,null,1000,1);



#если при обновлении оба null то отменить
drop trigger if exists check_not_null_products_name_on_update;
delimiter //
create trigger check_not_null_products_name_on_update before update on products
for each row
begin
	if(new.name is null and new.description is null) then
		signal sqlstate '45000' set message_text='UPDATE canceled';
	end if;
end//
delimiter //	

#проверка добавляем обновление до двух нулевых
update products
set name = null
where id = 9;

update products
set description = null
where id = 10;

select * from products;



