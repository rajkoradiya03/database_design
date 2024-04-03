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
    user_email varchar(100) not null unique,
    user_password varchar(255) not null,
    user_pass_salt varchar(255) not null,
    user_activation_code varchar(255) not null,
    user_isactivated tinyint not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) default current_timestamp(6)
);

create table address_details (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    address varchar(255) not null,
    city varchar(100) not null,
    state varchar(100) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);


create table available_slot (
	id int primary key auto_increment,
    starting_time varchar(100) not null,
    ending_time varchar(100) not null,
    available_toggle tinyint not null
);

create table booked_slot(
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    available_slot_id int, foreign key(available_slot_id) references available_slot(id),
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table vehicle_details (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    vehical_type varchar(255) not null,
    model_name varchar(255) not null,
    vehical_no varchar(255) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table vehical_service_details (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    vehical_id int, foreign key(vehical_id) references vehicle_details(id),
    vehical_problem varchar(255) not null, 
    estimate_price_range int not null,
    estimate_return_time varchar(255) not null,
    isok tinyint not null default 0,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table payments (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    book_slot_id int, foreign key(book_slot_id) references booked_slot(id),
    vehical_service_id int, foreign key(vehical_service_id) references vehical_service_details(id),
	price int not null,
    payment_method int, foreign key(payment_method) references payment_method(id), 
    isdone tinyint not null default 0,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table card_details (
 id int primary key auto_increment,
 user_id int, foreign key(user_id) references users_details(id),
 card_holder_name varchar(255) not null,
 card_number varchar(255) not null,
 card_salt varchar(100) not null,
 card_expiry_date date not null,
 created_at timestamp(6) default current_timestamp(6),
 updated_at timestamp(6) on update current_timestamp(6)
);

create table payment_method (
	id int primary key auto_increment,
    payment_method varchar(100) not null
);

create table feedback (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    vehical_id int, foreign key(vehical_id) references vehicle_details(id),
    feedback varchar(255) not null,
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