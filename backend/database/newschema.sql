BEGIN TRANSACTION;

DROP TABLE IF EXISTS users;
DROP SEQUENCE IF EXISTS seq_user_id;

CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE SEQUENCE seq_team_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

  CREATE SEQUENCE seq_game_type_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE SEQUENCE seq_tournament_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

  CREATE SEQUENCE seq_match_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE TABLE users (
	user_id int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	wins integer NOT NULL DEFAULT 0,
	losses integer NOT NULL DEFAULT 0,
	tournament_wins integer NOT NULL DEFAULT 0,
	tournaments_entered integer NOT NULL DEFAULT 0,
    user_image varchar(1000) NOT NULL DEFAULT '../assets/vectorBlueLogoXTourney.png',

	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE team_name (
    team_id int DEFAULT nextval('seq_team_id'::regclass) NOT NULL,
    team_name varchar(50) NOT NULL,
    wins integer NOT NULL DEFAULT 0,
	losses integer NOT NULL DEFAULT 0,
	tournament_wins integer NOT NULL DEFAULT 0,
	tournaments_entered integer NOT NULL DEFAULT 0,
    team_image varchar(1000) NOT NULL DEFAULT '../assets/vectorBlueLogoXTourney.png',

    CONSTRAINT PK_team_id PRIMARY KEY (team_id)
);

CREATE TABLE team_name_users (
    user_id integer NOT NULL,
    team_id integer NOT NULL,

    CONSTRAINT FK_user_id_team_id FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT FK_team_id_user_id FOREIGN KEY (team_id) REFERENCES team_name (team_id)
);

CREATE TABLE game_type (
    game_type_id int DEFAULT nextval('seq_game_type_id'::regclass) NOT NULL,
    game_type varchar(50) NOT NULL,

    CONSTRAINT PK_game_type_id PRIMARY KEY (game_type_id)
);

CREATE TABLE tournament (
    tournament_id int DEFAULT nextval('seq_tournament_id'::regclass) NOT NULL,
    game_type_id integer NOT NULL,
    host_id integer NOT NULL,
    name varchar(100) NOT NULL,
    description varchar(1000),
    is_private boolean NOT NULL,
    is_open boolean NOT NULL,
    max_teams integer NOT NULL,
    elimination_type varchar(50) NOT NULL,
    start_date date NOT NULL,
    start_time time NOT NULL,
    end_date date NOT NULL,
    signup_open date NOT NULL,
    signup_close date NOT NULL,
    tournament_image varchar(1000) NOT NULL DEFAULT '../assets/vectorBlueLogoXTourney.png',

    CONSTRAINT PK_tournament_id PRIMARY KEY (tournament_id),
    CONSTRAINT FK_game_type_id FOREIGN KEY (game_type_id) REFERENCES game_type (game_type_id),
    CONSTRAINT FK_host_id FOREIGN KEY (host_id) REFERENCES users (user_id)

);

CREATE TABLE tournament_users (
    user_id integer NOT NULL,
    team_id integer NOT NULL,
    tournament_id integer NOT NULL,

    CONSTRAINT FK_user_id_team_id_tournament_id FOREIGN KEY (user_id) REFERENCES users (user_id),
    CONSTRAINT FK_team_id_user_id_tournament_id FOREIGN KEY (team_id) REFERENCES team_name (team_id),
    CONSTRAINT FK_tournament_id_user_id_team_id FOREIGN KEY (tournament_id) REFERENCES tournament (tournament_id)
);

CREATE TABLE matches (
    match_id int DEFAULT nextval('seq_match_id'::regclass) NOT NULL,
    tournament_id integer NOT NULL,
    team_1_id integer NOT NULL,
    team_2_id integer NOT NULL,
    winning_team_id integer,
    losing_team_id integer,
    winning_team_score integer,
    losing_team_score integer,
    match_date date,
    match_time time,

    CONSTRAINT FK_tournament_id FOREIGN KEY (tournament_id) REFERENCES tournament (tournament_id)
);

INSERT INTO users (user_id,username,password_hash,role) VALUES (1, 'user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (user_id,username,password_hash,role) VALUES (2, 'admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');
INSERT INTO users (user_id,username,password_hash,role) VALUES (3, 'MikeMan','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (user_id,username,password_hash,role) VALUES (4, 'KorryTheCowboy','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (user_id,username,password_hash,role) VALUES (5, 'JacobyBurtonby','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (user_id,username,password_hash,role) VALUES (6, 'HowieTheNinja','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (user_id,username,password_hash,role) VALUES (7, 'StephenTheGreat','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (user_id,username,password_hash,role) VALUES (8, 'TomMasterOfScrum','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');

INSERT INTO game_type (game_type_id, game_type) VALUES (1, 'Golf'), (2, 'Baseball'), (3, 'Hockey'), 
(4, 'Basketball'), (5, 'Table Tennis'), (6, 'Tennis'), (7, 'Football'), (8, 'PUBG'), (9, 'Fortnite'), 
(10, 'Apex Legends'), (11, 'Leage of Legends'), (12, 'Counter-Strike'), (13, 'Hearthstone'), 
(14, 'Valorant'), (15, 'Rainbow Six Siege');

INSERT INTO team_name (team_id, team_name) VALUES (1, 'Team One With All'), (2, 'Two True for You'), 
(3, 'Team Three for Me'), (4, 'Team Four on the Floor'), (5, 'Team Five Guys and Fries');

INSERT INTO team_name_users (user_id, team_id) VALUES (3, 1), (8, 1), (7, 1), 
(4, 2), (3, 2), (8, 2), 
(5, 3), (4, 3), 
(5, 4), (6, 4), 
(7, 5), (6, 5);

INSERT INTO tournament (tournament_id, game_type_id, host_id, name, description, is_open, is_private, 
max_teams, elimination_type, start_date, end_date, signup_open, signup_close, start_time) VALUES 
(1, 1, 3, 'Golf Extravaganza', 'Come play in this super cool golf tournament!', true, false, 8, 'Single', 
'05/01/2021', '05/05/2021', '04/20/2021', '04/28/2021', '12:00:00'), 
(2, 3, 4, 'Hockey Hooplah', 'Hittin up the hockey gods for a fun tournament - INVITE ONLY - ', true, true, 4, 'Single', 
'06/01/2021', '06/05/2021', '05/20/2021', '05/28/2021', '12:00:00'),
(3, 5, 5, 'Table Tennis Tourney', 'Get it on with some ping pong!', false, false, 4, 'Single', 
'03/01/2021', '03/05/2021', '02/20/2021', '02/28/2021', '12:00:00'),
(4, 8, 6, 'PUBG Chicken Dinner Winner', 'Wanna win this dinner? You better be the winner!', true, false, 6, 'Single', 
'04/15/2021', '05/01/2021', '04/01/2021', '04/14/2021', '12:00:00'),
(5, 14, 7, 'Viscious Valorant', 'Victory to the Valorant Victor who Visciously Vanquishes their foes', true, false, 8, 'Single', 
'05/01/2021', '05/05/2021', '04/01/2021', '04/28/2021', '12:00:00');

INSERT INTO tournament_users (tournament_id, team_id, user_id) VALUES (1, 1, 3), (1, 2, 4), (1, 3, 5), 
(2, 4, 5), (2, 5, 7), 
(3, 1, 3), (3, 2, 4), (3, 3, 5), (3, 4, 6), 
(4, 5, 7), (4, 1, 8), (4, 2, 3), (4, 3, 5), 
(5, 1, 7), (5, 2, 8), (5, 4,5 ), (5, 5, 6);

INSERT INTO matches (match_id, tournament_id, team_1_id, team_2_id, match_date, match_time, winning_team_id, 
losing_team_id, winning_team_score, losing_team_score) VALUES 
(1, 3, 1, 2, '03/01/2021', '12:00:00', 1, 2, 5, 3), 
(2, 3, 3, 4, '03/02/2021', '12:00:00', 3, 4, 7, 5), 
(3, 3, 1, 3, '03/04/2021', '12:00:00', 1, 3, 6, 4);

COMMIT TRANSACTION;
