create table roles (
	id int primary key auto_increment, role_type varchar(50) not null
);

create table permission (
	id int primary key auto_increment,
    role_id int, foreign key(role_id) references roles(id),
    permission varchar(255) not null
);

create table team_lead_details (
	id int primary key auto_increment,
    team_lead_fname varchar(100) not null,
    team_lead_lname varchar(100) not null,
    team_lead_phoneno bigint not null,
    team_lead_DOB date not null,
    team_lead_email varchar(100) not null unique,
    team_lead_password varchar(255) not null,
    team_lead_pass_salt varchar(255) not null,
    team_lead_activation_code varchar(255) not null,
    team_lead_isactivated tinyint not null default 0,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table team_members_details (
	id int primary key auto_increment,
    team_lead_id int, foreign key(team_lead_id) references team_lead_details(id),
    team_members_fname varchar(100) not null,
    team_members_lname varchar(100) not null,
    team_members_phoneno bigint not null,
    team_members_DOB date not null,
    team_members_email varchar(100) not null unique,
    team_members_password varchar(255) not null,
    team_members_pass_salt varchar(255) not null,
    team_members_activation_code varchar(255) not null,
    team_members_isactivated tinyint not null default 0,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table user_logged (
	id int primary key auto_increment,
    role_id int, foreign key(role_id) references roles(id),
    username varchar(100) not null,
    password varchar(255) not null,
    isloggedin tinyint default 0,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)   
);

create table priorities(
	id int primary key auto_increment,
    priority varchar(100) not null
);

create table created_task_details (
	id int primary key auto_increment,
    team_lead_id int, foreign key(team_lead_id) references team_lead_details(id),
    task_title varchar(255) not null,
    task_description varchar(255) not null,
    task_due_date date not null,
    task_priority_id int, foreign key(task_priority_id) references priorities(id),
    task_assigned_id int, foreign key(task_assigned_id) references team_members_details(id),
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table statuses (
	id int primary key auto_increment,
    `status` varchar(100) not null
);

create table task_status_details (
	id int primary key auto_increment,
    task_id int, foreign key(task_id) references created_task_details(id),
    team_lead_id int, foreign key(team_lead_id) references team_lead_details(id),
    team_member_id int, foreign key(team_member_id) references team_members_details(id),
    add_comments varchar(255)  not null,
    task_status_id int, foreign key(task_status_id) references statuses(id),
	created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

