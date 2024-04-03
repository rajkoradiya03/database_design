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
    user_isactivated tinyint not null default 0,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table user_logged (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    role_id int, foreign key(role_id) references roles(id),
    isloggedin tinyint default 0,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)   
);

create table activity_status (
	id int primary key auto_increment,
	user_id int, foreign key(user_id) references users_details(id),
    work_date date not null,
    in_time time not null,
    out_time time not null,
    activity_id int, foreign key(activity_id) references activities(id),
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table activities(
	id int primary key auto_increment,
    activity_status varchar(100) not null
);

create table comments (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    comments varchar(255) not null,
    created_at timestamp(6) default current_timestamp(6)
);