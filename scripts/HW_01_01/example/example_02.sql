use example
		drop table users;
		create table users(
			id serial comment '����',
			name varchar(255) comment '���'
		)
		character set utf8 collate utf8_unicode_ci;
		
