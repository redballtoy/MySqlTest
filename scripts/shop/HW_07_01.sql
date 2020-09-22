/*
1. Создайте двух пользователей которые имеют доступ к базе данных shop. 
Первому пользователю shop_read должны быть доступны только запросы на чтение 
данных, второму пользователю shop — любые операции в пределах базы данных shop.
*/
create user 'readonlyuser'@'localhost' identified by 'pass';
select Host, User from mysql.user;
grant select on shop.* to 'readonlyuser'@'localhost';
flush privileges;


create user 'userwithallpriv'@'localhost' identified by 'pass';
select Host, User from mysql.user;
grant all privileges on shop.* to 'userwithallpriv'@'localhost';
flush privileges;
