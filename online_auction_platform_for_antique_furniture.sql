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

create table auction_items_details(
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    item_name varchar(255) not null,
    item_description varchar(255) not null,
    item_image varchar(255) not null,
    item_starting_bid int not null,
    reserve_price int not null,
    item_provenance varchar(255) not null,
    `item_age(in year)` int not null,
    item_condition varchar(100) not null,
    item_material varchar(100) not null,
    item_uniqueness varchar(255) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table bid_buyers_details (
	id int primary key auto_increment,
    seller_id int, foreign key(seller_id) references users_details(id),
    item_id int, foreign key(item_id) references auction_items_details(id),
    last_bid_price int not null,
    buyer_id int, foreign key(buyer_id) references auction_items_details(id),
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table special_item_details (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    item_id int, foreign key(item_id) references auction_items_details(id),
    created_at timestamp(6) default current_timestamp(6)
);

create table user_addresses (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    address varchar(255) not null,
    city varchar(100) not null,
    state varchar(100) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table shipping_details (
	id int primary key auto_increment,
	buy_item_id int, foreign key(buy_item_id) references bid_buyers_details(id),
    address_id int, foreign key(address_id) references user_addresses(id),
    `estimate_shipping_time(inday)` int not null,
    shipping_cost int not null,
    `total_cost(include shipping)` int not null,
    shipping_status varchar(100) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table payment_details(
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    buy_item_id int, foreign key(buy_item_id) references bid_buyers_details(id),
	payment_method int, foreign key(payment_method) references payment_method(id), 
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table card_details (
 id int primary key auto_increment,
 user_id int, foreign key(user_id) references users_details(id),
 card_holder_name varchar(255) not null,
 card_number varchar(255) not null,
 card_number_salt varchar(100) not null,
 card_expiry_date date not null
);

create table payment_method (
	id int primary key auto_increment,
    payment_method varchar(100) not null
);

create table buyers_feedback (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
	buy_item_id int, foreign key(buy_item_id) references bid_buyers_details(id),
    feedback varchar(255) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);
