# --- !Ups
use sinaaps;
create table user (
email varchar(255) not null,
f_name varchar(255),
 l_name varchar(255),
password varchar(255),
birthdate datetime,
address varchar(255),
constraint pk_user primary key (email))
;





create table author(author_id int,  email varchar(50), 
 constraint pk_author primary key (author_id) );

create table author_translation(id int, author_id int,language varchar(50),f_name nvarchar(50),
 l_name nvarchar(50),description nvarchar(2000),born nvarchar(50), gender nvarchar(50), constraint pk_author_translation primary key (id), foreign key (author_id) references author (author_id));

create table blog_post(post_id int,title varchar(100), content  mediumText,image  varchar(200),author_id int,topic  varchar(100),language  varchar(50),constraint pk_blog_post primary key (post_id), foreign key (author_id) references author (author_id));

alter table blog_post add published timestamp;

# --- !Downs

SET FOREIGN_KEY_CHECKS=0;


SET REFERENTIAL_INTEGRITY FALSE;

drop table if exists user;
drop table if exists author;
drop table if exists author_translation;
drop table if exists blog_post;
SET REFERENTIAL_INTEGRITY TRUE;


SET FOREIGN_KEY_CHECKS=1;

