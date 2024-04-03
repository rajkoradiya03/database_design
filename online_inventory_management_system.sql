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

create table inventory_locations (
	id int primary key auto_increment,
    inventory_id int, foreign key(inventory_id) references inventories_details(id),
    inventory_address varchar(255) not null,
    city varchar(100) not null,
    state varchar(100) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)   
);

create table inventories_details (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    inventory_name varchar(255) not null,
    total_stock int not null,
    minimum_stock int not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table suppliers_details(
	id int primary key auto_increment,
    supplier_name varchar(100) not null,
    supplier_company_name varchar(255) not null,
    supplier_contact_no bigint not null,
    supplier_address varchar(255) not null,
    supplier_email varchar(255) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table catogeries (
	id int primary key auto_increment,
    catogery varchar(100) not null
);

create table product_details (
	id int primary key auto_increment,
	catogery_id int, foreign key(catogery_id) references catogeries(id),
    supplier_id int, foreign key(supplier_id) references suppliers_details(id),
    inventory_id int, foreign key(inventory_id) references inventories_details(id),
    product_barcode varchar(255) not null,
    product_name varchar(255) not null,
    product_description varchar(255) not null,
    product_image varchar(255) not null,
    product_SKU varchar(255) not null,
    product_price int not null,
    quantity int not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table stoke_movement (
	id int primary key auto_increment,
    movement_type varchar(100) not null
);

create table inventory_tracking (
	id int primary key auto_increment,
    inventory_id int, foreign key(inventory_id) references inventories_details(id),
    stock_movement_id int, foreign key(stock_movement_id) references stoke_movement(id),
    stock_quantity int not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table order_details (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    product_id int, foreign key(product_id) references product_details(id),
    total_quantity int not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table sales_details (
	id int primary key auto_increment,
    supplier_id int, foreign key(supplier_id) references suppliers_details(id),
    product_id int, foreign key(product_id) references product_details(id),
    total_sale_quantity int not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table return_details (
	id int primary key auto_increment,
    order_id int, foreign key(order_id) references order_details(id),
    total_return_quantity int not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
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
    supplier_id int, foreign key(supplier_id) references suppliers_details(id),
	user_id int, foreign key(user_id) references users_details(id),
    address_id int, foreign key(address_id) references user_addresses(id),
    order_id int, foreign key(order_id) references order_details(id),
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
    order_id int, foreign  key(order_id) references order_details(id),
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
 card_expiry_date date not null,
 created_at timestamp(6) default current_timestamp(6),
 updated_at timestamp(6) on update current_timestamp(6)
);

create table payment_method (
	id int primary key auto_increment,
    payment_method varchar(100) not null
);