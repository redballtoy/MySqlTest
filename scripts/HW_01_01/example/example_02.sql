use example
		drop table users;
		create table users(
			id serial comment 'ключ',
			name varchar(255) comment 'имя'
		)
		character set utf8 collate utf8_unicode_ci;
		
