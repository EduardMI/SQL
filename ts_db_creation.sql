/* Создание базы данных */

drop database if exists tickets_shop;
create database tickets_shop;
use tickets_shop;

drop table if exists categories;
create table categories (
	id serial primary key,
	name varchar(255) not null
) comment = 'Категории';

drop table if exists scenes;
create table scenes (
	id serial primary key,
	name varchar(255) not null
) comment = 'Сцены';

drop table if exists theaters;
create table theaters (
	id serial primary key,
	name varchar(255) not null,
	scene bigint unsigned default null,
	
	foreign key (scene) references scenes(id)
) comment = 'Театры';


drop table if exists genres;
create table genres (
	id  serial primary key,
	name varchar(255) not null
) comment = 'Жанры';

drop table if exists actors;
create table actors (
	id serial primary key,
	firstname varchar(255) not null,
	lastname varchar(255) not null
) comment = 'Актеры';

drop table if exists media_types;
create table media_types (
	id serial,
    name varchar(255)
) comment = 'Типы медиафайлов';

drop table if exists events;
create table events (
	id serial primary key,
	name varchar(255) not null,
	date_event date not null,
	time_event time not null,
	theatre bigint unsigned not null,
	genre bigint unsigned not null,
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp,
	
	foreign key (theatre) references theaters(id),
	foreign key (genre) references genres(id)
) comment = 'Мероприятия';

drop table if exists tickets;
create table tickets (
	id serial primary key,
	event bigint unsigned not null,
	category bigint unsigned not null,
	number_row int unsigned not null,
	number_position int unsigned not null,
	status enum('свободен', 'забронирован', 'продан') not null default 'свободен',
	created_at datetime default current_timestamp,
	updated_at datetime default current_timestamp on update current_timestamp,
	
	foreign key (event) references events(id),
	foreign key (category) references categories(id)
) comment = 'Билеты';

drop table if exists events_actors;
create table events_actors (
	event_id bigint unsigned not null,
	actor_id bigint unsigned not null,
	
	primary key (event_id, actor_id),
	foreign key (event_id) references events(id),
	foreign key (actor_id) references actors(id)
) comment = 'Главная роль в мероприятии';
 
drop table if exists media;
create table media (
	id serial,
    media_type_id bigint unsigned not null,
    event_id bigint unsigned not null,
  	body text default null,
    filename varchar(255) not null,	
    size int not null,
	metadata json default null,
    created_at datetime default now(),
    updated_at datetime on update current_timestamp,

    foreign key (event_id) references events(id),
    foreign key (media_type_id) references media_types(id)
) comment = 'Медиафайлы';

drop table if exists photo_albums;
create table photo_albums (
	id serial primary key,
	name varchar(255) not null,
	event_id bigint unsigned default null,
	
	foreign key (event_id) references events(id)
) comment = 'Фотоальбомы';

drop table if exists photos;
create table photos (
	id serial,
	album_id bigint unsigned null,
	media_id bigint unsigned not null,

	foreign key (album_id) references photo_albums(id),
    foreign key (media_id) references media(id)
);

drop table if exists orders;
create table orders (
	order_id bigint unsigned not null,
	users varchar(255) not null,
	tel_number bigint unsigned not null,
	tickets_id bigint unsigned not null,
	
	index (order_id) 
) comment = 'Заказы';
