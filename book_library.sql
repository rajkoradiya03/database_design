create table roles (
	id int primary key auto_increment, role_type varchar(50) not null
);

create table permission (
	id int primary key auto_increment,
    role_id int, foreign key(role_id) references roles(id),
    permission varchar(255) not null
);

create table users_details (
	id int primary key auto_increment,
    role_id int, foreign key(role_id) references roles(id),
    user_fname varchar(100) not null,
    user_lname varchar(100) not null,
    user_phoneno bigint not null,
    user_DOB date not null,
    user_email varchar(100) not null unique,
    user_password varchar(255) not null,
    user_pass_salt varchar(255) not null,
    user_activation_code varchar(255) not null,
    user_isactivated tinyint not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) default current_timestamp(6)
);

create table user_logged (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    role_id int, foreign key(role_id) references roles(id),
    isloggedin tinyint default 0,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)   
);

create table genre (
	id int primary key auto_increment,
    genre varchar(100) not null
);

create table book_details (
	id int primary key auto_increment,
    book_title varchar(255) not null,
    book_cover_image varchar(255) not null,
    book_auther varchar(100) not null,
    book_description varchar(255) not null,
    book_total_page int not null,
    book_publish_year int not null,
    book_ISBN varchar(255) not null,
    book_auther_details varchar(255) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table languages(
	id int primary key auto_increment,
    language varchar(100) not null
);

create table book_genre (
	id int primary key auto_increment,
    book_id int, foreign key(book_id) references book_details(id),
    genre_id int, foreign key(genre_id) references genre(id)
);

create table book_languages(
	id int primary key auto_increment,
    book_id int, foreign key(book_id) references book_details(id),
    language_id int, foreign key(language_id) references languages(id)
);

create table book_status (
	id int primary key auto_increment,
    book_id int, foreign key(book_id) references book_details(id),
	user_id int, foreign key(user_id) references users_details(id),
    book_status varchar(100) not null,
    currently_reading_page int not null,
    iscompletlyread tinyint default 0,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table review_rating (
	id int primary key auto_increment,
    book_id int, foreign key(book_id) references book_details(id),
	user_id int, foreign key(user_id) references users_details(id),
    review varchar(255) not null,
    rating int not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);