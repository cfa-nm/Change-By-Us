# tablesDROP TABLE IF EXISTS users;CREATE TABLE users (    id INTEGER PRIMARY KEY AUTO_INCREMENT,    email VARCHAR(255) UNIQUE NOT NULL,    password VARCHAR(255) NOT NULL,    admin BOOLEAN DEFAULT 0,    oncall BOOLEAN DEFAULT 0,    salt VARCHAR(255) NOT NULL,    ip VARCHAR(255) NOT NULL,    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    key(email),    key(admin),    key(oncall));# will be a single rowDROP TABLE IF EXISTS badwords;CREATE TABLE badwords (    id INTEGER PRIMARY KEY AUTO_INCREMENT,    kill_words TEXT,    warn_words TEXT,    updated_datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP);insert into badwords (kill_words) values('shit fuck twat cunt blowjob buttplug dildo felching fudgepacker jizz smegma clitoris asshole bullshit bullshitter bullshitters bullshitting chickenshit chickenshits clit cockhead cocksuck cocksucker cocksucking cum cumming cums cunt cuntree cuntry cunts dipshit dipshits dumbfuck dumbfucks dumbshit dumbshits fuck fucka fucke fucked fucken fucker fuckers fuckface fuckhead fuckheads fuckhed fuckin fucking fucks fuckup fuckups kunt kuntree kuntry kunts motherfuck motherfucken motherfucker motherfuckers motherfuckin motherfucking shit shitface shitfaced shithead shitheads shithed shits shitting shitty');# simple 1 row table to determine if media is always approveddrop table if exists media_approval_mode;create table media_approval_mode (  is_always_approved bool not null default 1  ,updated_datetime timestamp default current_timestamp on update current_timestamp);# deprecateddrop table if exists user;create table user (  id int not null auto_increment  ,email varchar(100) not null  ,is_active bool not null default 1  ,created_datetime timestamp default current_timestamp  ,primary key (id)  ,key (email)  ,unique (email));drop table if exists media;create table media (  id int not null auto_increment  ,user_id int not null  ,description text null  ,topic_category_id tinyint null  ,media_handle varchar(255) not null  ,media_type enum('image', 'youtube', 'vimeo') not null  ,submission_type enum('web', 'email') null  ,submitter_email varchar(255) null  ,num_visits int not null default 0  ,num_flags smallint not null default 0  ,num_twitter_shares int not null default 0  ,num_facebook_shares int not null default 0  ,num_facebook_likes int not null default 0  ,is_featured bool not null default 0  ,approval_status enum('approved','rejected','unreviewed') not null default 'unreviewed'  ,created_datetime timestamp default current_timestamp  ,primary key (id)  ,key (user_id)  ,key (topic_category_id)  ,key (num_flags)  ,key (approval_status));# deprecateddrop table if exists media_vote;create table media_vote (  media_id int not null  ,num_visits int not null default 0  ,num_vote_0 int not null default 0  ,num_vote_1 int not null default 0  ,created_datetime timestamp default current_timestamp on update current_timestamp  ,primary key (media_id));# new votingdrop table if exists media_vote_category;create table media_vote_category (    id int not null     ,description varchar(100) not null    ,primary key(id));insert into media_vote_category (description) values ('dangerous');insert into media_vote_category (description) values ('more dangerous');insert into media_vote_category (description) values ('neutral');insert into media_vote_category (description) values ('less dangerous');insert into media_vote_category (description) values ('not dangerous');drop table if exists media_vote_count;create table media_vote_count (    media_id int not NULL    ,media_vote_category_id int not null    ,num_votes int not null default 0    ,is_active bool not null default 1    ,updated_datetime timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP    ,primary key(media_id, media_vote_category_id));# END new votingdrop table if exists topic_category;create table topic_category (  id int not null  ,topic_category varchar(255) not null  ,description text null  ,is_active bool default 1  ,created_datetime timestamp default current_timestamp  ,primary key (id));DROP TABLE IF EXISTS images;CREATE TABLE `images` (  `id` int(11) NOT NULL AUTO_INCREMENT,  `app` varchar(255) NOT NULL,  `mirrored` tinyint(1) DEFAULT '0',  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,  PRIMARY KEY (`id`),  KEY `app` (`app`),  KEY `mirrored` (`mirrored`));# init datainsert into media_approval_mode (is_always_approved) value (1);insert into topic_category (id, topic_category, description) values (1, 'Plays on emotions', 'Uses positive or negative imagery to manipulate human emotions.');insert into topic_category (id, topic_category, description) values (2, 'Truths, half-truths, or lies', 'Actively manipulating or distorting facts to your advantage.');insert into topic_category (id, topic_category, description) values (3, 'Targets desired audiences', 'Deploying tactics designed to appeal to a specific segment of society.');insert into topic_category (id, topic_category, description) values (4, 'Attacks opponents', 'Demonizing your opponents to diminish sympathy for their cause.');# testing data to get startedinsert into user (email) values ('ethan@localprojects.net');/*INSERT INTO media (`user_id`, description, `topic_category_id`,`media_type`,`media_handle`,`submission_type`)  VALUES (1,'Some lengthy description about the media...where it came from and thoughts pertaining to it.', 1,'vimeo','15888296','web');insert into media_vote (media_id, num_visits, num_vote_0, num_vote_1) values (1 , 100, 40, 55);*/