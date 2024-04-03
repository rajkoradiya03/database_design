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

create table cuisine_details(
	id int primary key auto_increment,
    cuisine_type varchar(100) not null,
    cuisine_description varchar(255) not null,
    created_at timestamp(6) default current_timestamp(6)
);

create table dietary_preferences (
	id int primary key auto_increment,
    dietary_preference varchar(100) not null,
    created_at timestamp(6) default current_timestamp(6)
);

create table cooking_techniques (
	id int primary key auto_increment,
    cooking_technique varchar(100) not null,
    created_at timestamp(6) default current_timestamp(6)
);

create table meal_types (
	id int primary key auto_increment,
    meal_type varchar(100) not null,
    created_at timestamp(6) default current_timestamp(6)
);

create table difficulty_levels (
	id int primary key auto_increment,
    `level` varchar(100) not null,
    created_at timestamp(6) default current_timestamp(6)
);

create table food_recipies_details (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    meal_type_id int, foreign key(meal_type_id) references meal_types(id),
    dietary_preference_id int, foreign key(dietary_preference_id) references dietary_preferences(id),
    cuisine_id int, foreign key(cuisine_id) references cuisine_details(id),
    food_name varchar(255) not null,
    difficulty_id int, foreign key(difficulty_id) references difficulty_levels(id),
    food_popularity varchar(100) not null,
    serving_size varchar(100) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)  
);

create table ingredients_details (
 id int primary key auto_increment,
 food_id int, foreign key(food_id) references food_recipies_details(id),
 ingredient_name varchar(100) not null,
 `nutritional_information(in %)` int not null,
 created_at timestamp(6) default current_timestamp(6),
 updated_at timestamp(6) on update current_timestamp(6) 
);

create table recipy_instructions(
	id int primary key auto_increment,
    food_id int, foreign key(food_id) references food_recipies_details(id),
    required_items varchar(255) not null,
    ingredient_id int, foreign key(ingredient_id) references ingredients_details(id), 
    instruction varchar(255) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);


create table user_favorite_recipies_details (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    food_id int, foreign key(food_id) references food_recipies_details(id),
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table user_shopping_lists_details (
	id int primary key auto_increment,
	user_id int, foreign key(user_id) references users_details(id),
    food_id int, foreign key(food_id) references food_recipies_details(id),
    ingredient_id int, foreign key(ingredient_id) references ingredients_details(id),
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table feedback_detials (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    food_id int, foreign key(food_id) references food_recipies_details(id),
    `comment` varchar(255) not null,
    rating int not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table feedback_reply_details (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    feedback_id int, foreign key(feedback_id) references feedback_detials(id),
    reply varchar(255) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table tips_for_cooking (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    food_id int, foreign key(food_id) references food_recipies_details(id),
    tips_video varchar(255) not null,
    tips_video_description varchar(255) not null,
	created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table cooking_articles_details (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    articale_title varchar(255) not null,
    articale_description varchar(255) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table social_media_plateforms (
	id int primary key auto_increment,
    social_media_plateform varchar(100) not null,
    created_at timestamp(6) default current_timestamp(6)
);

create table social_media_marketing_details (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    social_media_platform_id int, foreign key(social_media_platform_id) references social_media_plateforms(id),
    banner_image varchar(100) not null,
    interations int not null,
    likes int not null,
    comments int not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table collaborators_details (
	id int primary key auto_increment,
    collaborator_name varchar(100) not null,
    social_media_platform_id int, foreign key(social_media_platform_id) references social_media_plateforms(id),
    collaborator_social_media_id varchar(100) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);

create table collaboration_details (
	id int primary key auto_increment,
    user_id int, foreign key(user_id) references users_details(id),
    collaborator_id int, foreign key(collaborator_id) references collaborators_details(id),
    paying_price int not null,
    period_of_time varchar(100) not null,
    created_at timestamp(6) default current_timestamp(6),
    updated_at timestamp(6) on update current_timestamp(6)
);