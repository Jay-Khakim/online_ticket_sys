DROP DATABASE IF EXISTS `online_ticket_sys`;
CREATE DATABASE `online_ticket_sys` ;
USE `online_ticket_sys`;

SET NAMES utf8;
SET character_set_client = utf8mb4;

CREATE TABLE `users` (
    `user_id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`user_id`)
)  ENGINE=INNODB AUTO_INCREMENT=5 DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;
INSERT INTO `users` values (1, "Jay Khakim", "mgmediajay@gmail.com", "12341234");
INSERT INTO `users` values (2, "Adam", "mgmediajay@gmail.com", "12341234");
INSERT INTO `users` values (3, "Ahmad", "mgmediajay@gmail.com", "12341234");


CREATE TABLE `branches` (
    `branch_id` INT(11) NOT NULL,
    `branch_name` VARCHAR(50) NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`branch_id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;
INSERT into `branches` values (1, "Lotte Cinema", "Busan branch");
INSERT into `branches` values (2, "CG Cinema", "Somyon branch");
INSERT into `branches` values (3, "CVV", "Daegu branch");

CREATE TABLE `seances` (
    `seance_id` INT(11) NOT NULL,
    `seance_time` TIME,
    `seance_date` DATE,
    `ticket_qty` INT(3),
    PRIMARY KEY (`seance_id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;

INSERT into `seances` (seance_id, seance_time, seance_date, ticket_qty) 
values 
	(1, "16:00", "2024-04-20", 120),
    (2, "20:00", "2024-04-20", 130);

CREATE TABLE `movies` (
    `movie_id` INT(11) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `genre` VARCHAR(255) NOT NULL,
    `language` VARCHAR(50) NOT NULL,
    `duration` INT(4) NOT NULL,
    `release_date` DATE NOT NULL,
    `fk_branch_id` INT NOT NULL,
    `fk_seance_id` INT NOT NULL,
    PRIMARY KEY (`movie_id`),
    FOREIGN KEY (`fk_branch_id`)
        REFERENCES branches (`branch_id`),
    FOREIGN KEY (`fk_seance_id`)
        REFERENCES seances (`seance_id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;

insert into `movies` values(1, "Avatar", "Scy-fi", "English", 123, "2012-10-12", 1, 1);
insert into `movies` values(2, "Titanic", "History", "English", 133, "2013-10-12", 1, 2);



CREATE TABLE `tickets` (
    `ticket_id` INT(11) NOT NULL UNIQUE,
    `price` DECIMAL(10 , 2 ),
    `type` ENUM('gold', 'silver', 'bronze'),
    `seat` VARCHAR(3),
    `aisle` CHAR(2),
    `fk_seance_id` INT NOT NULL,
    `fk_movie_id` INT NOT NULL,
    PRIMARY KEY (`ticket_id`),
    FOREIGN KEY (`fk_seance_id`)
        REFERENCES seances (`seance_id`),
    FOREIGN KEY (`fk_movie_id`)
        REFERENCES movies (`movie_id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;


INSERT INTO tickets (ticket_id, price, type, seat, aisle, fk_seance_id, fk_movie_id) 
VALUES 
	(1, 15, "gold", "15", "D", "1", "1"),
    (2, 20, "silver", "1", "A", "2", "2"),
    (3, 20, "silver", "2", "A", "2", "2"),
    (4, 15, "bronze", "20", "B", "1", "1");


CREATE TABLE `purchases` (
    `purchase_id` INT(11) NOT NULL,
    `card_number` VARCHAR(16) NOT NULL,
    `card_holder` VARCHAR(255) NOT NULL,
    `purchase_date` DATE,
    `status` ENUM('booked', 'paid', 'completed'),
    fk_ticket_id INT NOT NULL,
    fk_user_id INT NOT NULL,
    PRIMARY KEY (`purchase_id`),
    FOREIGN KEY (`fk_ticket_id`)
        REFERENCES tickets (`ticket_id`),
    FOREIGN KEY (`fk_user_id`)
        REFERENCES users (`user_id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;

INSERT INTO purchases (purchase_id, card_number, card_holder, purchase_date, status, fk_ticket_id, fk_user_id)
VALUES 
	(1, "1234123412341234", "James Black", "2024-04-04", "booked", "1", "1"),
    (2, "1234123412341234", "MRs Black", "2024-04-03", "paid", "2", "2"),
    (3, "1234123412341234", "Adam Black", "2024-04-01", "paid", "2", "2"),
    (4, "1234123412341234", "Jad Black", "2024-04-05", "completed", "1", "1");

