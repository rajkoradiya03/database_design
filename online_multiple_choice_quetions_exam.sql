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

create table exam_details (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    exam_title varchar(255) not null,
    exam_instruction varchar(255) not null,
    exam_duration varchar(255) not null,
    exam_passing_mark int not null,
    exam_total_mark int not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table answer_types(
	id int primary key auto_increment,
    answer_type varchar(100) not null
);

create table quetions (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    exam_id int, foreign key(exam_id) references exam_details(id),
    question varchar(255) not null,
    answer_type_id int, foreign key(answer_type_id) references answer_types(id),
    each_que_mark int not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table option_of_quetions (
	id int primary key auto_increment,
    quetion_id int, foreign key(quetion_id) references quetions(id),
    option_answer varchar(255) not null,
    created_at timestamp(6) default current_timestamp(6)
);

create table right_answers (
	id int primary key auto_increment,
    quetion_id int, foreign key(quetion_id) references quetions(id),
    right_answer varchar(255) not null,
    created_at timestamp(6) default current_timestamp(6)
);

create table exam_result (
	id int primary key auto_increment,
	user_id int, foreign key(user_id) references users_details(id),
    exam_id int, foreign key(exam_id) references exam_details(id),
    obtain_mark int not null,
    grade varchar(100) not null,
    feedback varchar(255) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);