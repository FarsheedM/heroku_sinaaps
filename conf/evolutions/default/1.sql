# --- !Ups

/*
Useful Tools:
-- SHOW ENGINE INNODB STATUS;  //shows the detailed info about sql error
-- SHOW FULL COLUMNS FROM tbl_name;  //shows the detailed info about table's cols

In the case of this error(by creating a new table):
"There is no index in the table which would contain
the columns as the first columns, or the data types in the
table do not match the ones in the referenced table."

The problem could be in mismatched CHARACTERSET or in missmatched COLLATION. 
In defining the foreign key, the referencing field should be defined explicitly, e.g.
'usr_email varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci'

*/


use sinaaps;

create table user(
email varchar(255),
f_name varchar(255),
l_name varchar(255),
password varchar(255),
day int,month int,year int,
address varchar(255),
photo varchar(300),
gender bool,
registration_date timestamp ,
description varchar(500),
primary key (email));


create table author(author_id int,  email varchar(50), photo varchar(300),primary key (author_id) );

create table author_translation(id int, author_id int,language varchar(50),f_name nvarchar(50),
 l_name nvarchar(50),description nvarchar(2000),born nvarchar(50), gender nvarchar(50), primary key (id), foreign key (author_id) references author (author_id));

create table blog_post(
post_id int,
title varchar(100),
content  LongText,
image  varchar(300),
author_id int,
topic  varchar(100),
language  varchar(50),
published timestamp,
aux_img1 varchar(300),
aux_img2 varchar(300),
primary key (post_id),
foreign key (author_id) references author (author_id));



create table book(book_id int, isbn varchar(15),page int, published timestamp, photo varchar(300),dimensions varchar(20),weight float, user_rating int, farsireads_rating int, primary key (book_id));

create table book_translation(id int, book_id int, language varchar(50), title nvarchar(200),summary mediumtext, author_id int, publication nvarchar(200),format nvarchar(30),primary key (id),foreign key (book_id) references book (book_id));

create table book_author(id int,book_id int,author_id int, primary key (id) ,foreign key (book_id) references book (book_id), foreign key (author_id) references author (author_id));

create table blog_comment(comment_id bigint, post_id int, user_email varchar(255), published timestamp, comment nvarchar(2000),rating int, primary key (comment_id),foreign key (post_id) references  blog_post (post_id) ,foreign key (user_email) references user (email));

create table book_review(
review_id bigint, 
book_id int, 
user_email varchar(255), 
published timestamp, 
review nvarchar(2000),
rating int, 
primary key (review_id),
foreign key (book_id) references  book (book_id),
foreign key (user_email) references  user (email)
);

create table topic(topic_id int,  en_name varchar(50), fa_name varchar(50), en_description LongText, fa_description LongText,primary key (topic_id) );
create table topic_book(id int,book_id int,topic_id int, primary key (id) ,foreign key (book_id) references book (book_id), foreign key (topic_id) references topic (topic_id));

create table event(
	event_id int,
	title varchar(100),
	events_date varchar(100),
	location varchar(100),
	speakers varchar(300),
	speaker_img1 varchar(300),
	speaker_img2 varchar(300),
	speaker_img3 varchar(300),
	hosted_by varchar(300),
	image varchar(300),
	description LongText,
	price varchar(100),
	language varchar(50),
	primary key (event_id)
);

create table event_guest (
email varchar(255),
name varchar(255),
contact_number varchar(100),
number_of_adults int,
number_of_kids int,
comment varchar(255),
primary key (email));


create table book_user(
id int,
book_id int,
user_email varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci, 
added_to_vl timestamp;
finished boolean,
reading boolean,
to_read boolean,
book_rating int,
primary key (id),
foreign key (book_id) references  book (book_id),
foreign key (user_email) references  user (email)
);

create table relationship(
relationship_id int,
user1_email varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci,
user2_email varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci,
/* Status Codes:
* 	0 	Pending
	1 	Accepted
	2 	Declined
	3 	Blocked
* */
status int,
actionuser_email varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci,
primary key (relationship_id),
foreign key (user1_email) references user (email),
foreign key (user2_email) references user (email),
foreign key (actionuser_email) references user (email)
);

create table activity(
	id bigint NOT NULL AUTO_INCREMENT,
	user_email varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci, 
	verb varchar(255),
	object_type varchar(255),
	object_id bigint,
	object_url varchar(255),
	source_type varchar(255),
	source_url varchar(255),
	published timestamp,
	primary key (id),
	foreign key (user_email) references user (email)
);
create table activity_stream_list(
	id int NOT NULL AUTO_INCREMENT,
	user_email varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci, 
	activity_id bigint, 
	primary key (id),
	foreign key (user_email) references user (email),
	foreign key (activity_id) references activity (id)
);


create table library(	
    library_id int NOT NULL AUTO_INCREMENT,
	name varchar(255),
	established timestamp,
	Address varchar(255),
	church_name varchar(255),
	primary key (library_id)
);

create table local_library_admin(
	admin_id int NOT NULL AUTO_INCREMENT,
	admin_email varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci,
	library_id int,
	foreign key (admin_email) references user (email),
	foreign key (library_id) references library (library_id),
	primary key (admin_id)
);

create table book_entry(
	book_tage varchar(255) not null,
	book_id int not null,
	borrowed_by varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci,
	borrowed_on timestamp,
	cellphone varchar(255),
	address varchar(255),
	deposit boolean,
	library_id int default null,
	foreign key (book_id) references  book (book_id),
	foreign key (borrowed_by) references user (email),
	foreign key (library_id) references library (library_id),
	primary key (book_tage)
);

create table LIB_BOOKENTRY(
    library_id int NOT NULL,
	book_tage varchar(255) not null,
	primary key (library_id,book_tage)
);

# --- !Downs

#--- !SET FOREIGN_KEY_CHECKS=0;


#--- !SET REFERENTIAL_INTEGRITY FALSE;

drop table if exists user;
drop table if exists author;
drop table if exists author_translation;
drop table if exists blog_post;
drop table if exists book;
drop table if exists book_translation;
drop table if exists book_author;
drop table if exists blog_comment;
drop table if exists book_review;
drop table if exists topic;
drop table if exists topic_book;
drop table if exists event;
drop table if exists event_guest;
drop table if exists book_user;
drop table if exists relationship;
drop table if exists activity;
drop table if exists activity_stream_list;
drop table if exists library;
drop table if exists local_library_admin;
drop table if exists book_entry;
drop table if exists LIB_BOOKENTRY;
#---drop table if exists library_book_entry;
#--- !SET REFERENTIAL_INTEGRITY TRUE;


#--- !SET FOREIGN_KEY_CHECKS=1;

