show databases;

CreAte DATABASE tripplannerdb;

USE tripplannerdb;

SHOW tables;

-- comment
-- user is a key word
-- name
-- id
-- age
-- room
-- email
-- phone number
CREATE TABLE t_user (
                        name VARCHAR(256),
                        age INT,
                        email VARCHAR(256)
);

DESCRIBE t_user;

INSERT INTO t_user
VALUES('John Doe', 40, 'j.d@mail.com');

INSERT INTO t_user (name, email)
VALUES ('Jane Doe', 'jane@mail.com');

SELECT * FROM t_user;

TRUNCATE TABLE t_user;
SHOW TABLES;

DROP TABLE t_user;

CREATE TABLE t_user (
                        name VARCHAR(256) NOT NULL,
                        age INT NOT NULL,
                        email VARCHAR(256) NOT NULL UNIQUE
);

DESCRIBE  t_user;

SHOW CREATE TABLE t_user;

INSERT INTO t_user (name, email)
VALUES ('John Doe', 'jd@mail.com');

SELECT * FROM t_user;

ALTER TABLE t_user
DROP COLUMN age;

ALTER TABLE t_user
    ADD COLUMN age
        INT NOT NULL
        DEFAULT 1 CHECK (age > 0);

SELECT email, age FROM t_user
WHERE email = 'jd@mail.com'

ALTER TABLE t_user
    ADD COLUMN
        id INT PRIMARY KEY AUTO_INCREMENT;
-- 	id SERIAL PRIMARY KEY

INSERT INTO t_user (name, age, email)
VALUES('Ivan Petrenko', 34, 'ip@mail.com'),
      ('Petro Ivanenko', 28, 'pi@mail.com');

SELECT * FROM t_user;

DESCRIBE t_user;

SELECT * FROM t_user;

UPDATE t_user
SET email = 'ivan.p@mail.com'
WHERE id = 3;

DELETE FROM t_user -- deletes all
WHERE email LIKE 'j%';

ALTER TABLE t_user
DROP COLUMN age;

TRUNCATE TABLE t_user;

ALTER TABLE t_user
    ADD COLUMN birth_date DATE NOT NULL;

USE tripplannerdb;

DESCRIBE t_user;

SHOW CREATE TABLE t_user;


CREATE TABLE `t_user` (
                          `name` varchar(256) NOT NULL,
                          `email` varchar(256) NOT NULL,
                          `id` int(11) NOT NULL AUTO_INCREMENT,
                          `birth_date` date NOT NULL,
                          PRIMARY KEY (`id`),
                          UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO t_user (name, email, birth_date)
VALUES ("John Doe", "jd@mail.com", "1980-01-01"),
       ("Jane Doe", "jane@mail.com", "1982-01-01");

INSERT INTO `t_user` (name, email, birth_date) VALUES
                                                   ('Oleksandr Kovalenko', 'oleksandrkovalenko@example.com', '1990-01-01'),
                                                   ('Yulia Shevchenko', 'yuliashevchenko@example.com', '1992-05-15'),
                                                   ('Dmytro Ivanov', 'dmytroivanov@example.com', '1988-08-20'),
                                                   ('Kateryna Petrenko', 'katerynapetrenko@example.com', '1995-12-10'),
                                                   ('Ivan Melnyk', 'ivanmelnyk@example.com', '1985-04-03'),
                                                   ('Sofia Pavlova', 'sofiapavlova@example.com', '1993-07-22'),
                                                   ('Artem Zhukov', 'artemzhukov@example.com', '1987-09-30'),
                                                   ('Olena Kryvyi', 'olenakryvyi@example.com', '1991-11-05'),
                                                   ('Vladyslav Bondar', 'vladyslavbondar@example.com', '1986-02-17'),
                                                   ('Natalia Vasylenko', 'nataliavasylenko@example.com', '1994-03-28');


-- one to one
CREATE TABLE t_address (
                           id INT PRIMARY KEY AUTO_INCREMENT,
                           country VARCHAR(256) NOT NULL DEFAULT "Ukraine",
                           state VARCHAR(256),
                           place VARCHAR(128) NOT NULL,
                           street VARCHAR(128) NOT NULL,
                           house_num VARCHAR(32) NOT NULL,
                           apartment VARCHAR(128),
                           user_id INT UNIQUE,
                           FOREIGN KEY (user_id)
                               REFERENCES t_user(id)
                               ON DELETE CASCADE
);

SELECT * FROM t_user;

INSERT INTO t_address
(place, street, house_num, apartment, user_id)
VALUES ("Kyiv", "Some str.", "1A", "24", 1),
       ("Dnipro", "Other str.", "2", "34", 2);


SELECT u.name, a.* FROM t_user AS u
                            JOIN t_address AS a
                                 ON u.id = a.user_id;




CREATE TABLE t_hotel (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         name VARCHAR(256) NOT NULL,
                         description VARCHAR(256),
                         phone_number VARCHAR(32)
);

INSERT INTO t_hotel (name, description, phone_number)
VALUES ('Hotel 1', 'Hotel 1 descr', '+134356645'),
       ('Hotel 2', 'Hotel 2 descr', '+35454345'),
       ('Hotel 3', 'Hotel 3 descr', '+134356645');

CREATE TABLE t_hotel_room (
                              id INT PRIMARY KEY AUTO_INCREMENT,
                              capacity INT NOT NULL,
                              price FLOAT NOT NULL,
                              hotel_id INT,
-- 	CONSTRAINT fk_hotel_id
                              FOREIGN KEY (hotel_id)
                                  REFERENCES t_hotel(id)
                                  ON DELETE CASCADE
);

DESCRIBE t_hotel_room;

SELECT * FROM t_hotel
ORDER BY phone_number DESC; -- default: ASCENDING

INSERT INTO t_hotel_room (capacity, price, hotel_id)
VALUES
    (1, 100, 1),
    (2, 150, 1),
    (5, 300, 1),
    (2, 400, 2);


SELECT * FROM t_hotel_room;

-- find hotel hvaing a room for 2
SELECT * FROM t_hotel AS h
                  JOIN t_hotel_room AS r
                       ON h.id = r.hotel_id
WHERE r.capacity = 2;

-- find hotel with OR without rooms
SELECT * FROM t_hotel AS h
                  LEFT JOIN t_hotel_room AS r
                            ON h.id = r.hotel_id;


-- booking - room
CREATE TABLE t_hotel_booking (
                                 id INT PRIMARY KEY AUTO_INCREMENT,
                                 checkin_date DATE NOT NULL,
                                 checkout_date DATE NOT NULL,
                                 user_id INT, -- many to one
                                 room_id INT,
                                 FOREIGN KEY (user_id) REFERENCES t_user(id)
                                     ON DELETE SET NULL,
                                 FOREIGN KEY (room_id) REFERENCES t_hotel_room(id)
                                     ON DELETE SET NULL
);

-- many-to-many
CREATE TABLE t_guest_hotel_booking (
                                       id INT PRIMARY KEY AUTO_INCREMENT,
                                       user_id INT,
                                       hotel_booking_id INT,
                                       FOREIGN KEY (user_id) REFERENCES t_user(id),
                                       FOREIGN KEY (hotel_booking_id) REFERENCES t_hotel_booking(id)
);

ALTER TABLE t_guest_hotel_booking
    ADD CONSTRAINT fk_user_hb_id
        FOREIGN KEY (user_id) REFERENCES t_user(id);

ALTER TABLE t_guest_hotel_booking
    ADD CONSTRAINT fk_hotel_booking_id_hb_id
        FOREIGN KEY (hotel_booking_id) REFERENCES t_hotel_booking(id);

DESCRIBE t_guest_hotel_booking;


SELECT * FROM 	t_user;

CREATE VIEW all_hotels_with_rooms
AS SELECT
       h.name,
       h.description,
       r.*
   FROM t_hotel AS h
            LEFT JOIN t_hotel_room AS r
                      ON hotel_id = r.hotel_id;

SELECT * FROM all_hotels_with_rooms;




SELECT * FROM t_hotel AS h
                  LEFT JOIN t_hotel_room AS r
                            ON h.id = r.hotel_id;

-- transaction begin
BEGIN;

INSERT INTO t_hotel_booking
(checkin_date, checkout_date, room_id, user_id)
VALUES('2023-12-12', '2023-12-15', 2, 1),
      ('2023-12-12', '2023-12-15', 3, 3);

SELECT b.*, r.id, r.capacity, u.id, u.name
FROM t_hotel_booking AS b
         JOIN t_hotel_room AS r
              ON b.id = r.hotel_id
         JOIN t_user AS u
              ON u.id = b.user_id;



INSERT INTO t_guest_hotel_booking
(user_id, hotel_booking_id)
VALUES
    (2, 1),
    (4, 2),
    (5, 2),
    (6, 2);

-- success
COMMIT;

-- get booking with its owner and rooms
SELECT b.id as booking_id,
       r.id AS room_id,
       r.capacity AS room_capa,
       r.price,
       u.id AS owner_id, u.name AS owner_name
FROM t_hotel_booking AS b
         JOIN t_user AS u
              ON u.id = b.user_id
         JOIN t_hotel_room AS r
              ON r.id = b.room_id
WHERE b.id = 2;

-- get booking with its owner and rooms and guests
SELECT b.id as booking_id,
       r.id AS room_id,
       r.capacity AS room_capa,
       r.price,
       u.id AS owner_id, u.name AS owner_name,
       g.name AS guest_name
FROM t_hotel_booking AS b
         JOIN t_user AS u
              ON u.id = b.user_id
         JOIN t_hotel_room AS r
              ON r.id = b.room_id
         JOIN t_guest_hotel_booking as g2b
              ON g2b.hotel_booking_id = b.id
         JOIN t_user AS g
              ON g.id = g2b.user_id
WHERE b.id = 2;



SELECT
    SUM(r.price), r.id
FROM t_hotel_booking AS b
         JOIN t_user AS u
              ON u.id = b.user_id
         JOIN t_hotel_room AS r
              ON r.id = b.room_id
         JOIN t_guest_hotel_booking as g2b
              ON g2b.hotel_booking_id = b.id
         JOIN t_user AS g
              ON g.id = g2b.user_id
GROUP BY b.id;

SELECT * FROM t_hotel_booking tghb

    SHOW CREATE TABLE t_hotel_booking;
DESCRIBE t_hotel_booking;

ALTER TABLE t_hotel_booking
    ADD CONSTRAINT fk_user_id
        FOREIGN KEY (user_id)
            REFERENCES t_user(id);


ALTER TABLE t_hotel_booking
    ADD CONSTRAINT fk_room_id
        FOREIGN KEY (room_id)
            REFERENCES t_hotel_room(id);



TRUNCATE t_hotel_booking;
TRUNCATE t_guest_hotel_booking;

SELECT * FROM t_hotel_booking;

INSERT INTO t_hotel_booking
(checkin_date, checkout_date, room_id, user_id)
VALUES('2023-12-12', '2023-12-15', 2, 1),
      ('2023-12-12', '2023-12-15', 3, 3);

INSERT INTO t_guest_hotel_booking
(user_id, hotel_booking_id)
VALUES (2, 1),
       (4, 2),
       (5, 2),
       (6, 2);

SELECT b.id, b.user_id, COUNT(u.id) FROM t_hotel_booking b
                                             JOIN t_guest_hotel_booking AS g2b
                                                  ON b.id = g2b.hotel_booking_id
                                             JOIN t_user AS u
                                                  ON u.id = g2b.user_id
GROUP BY b.id;

SELECT b.id, MAX(u.birth_date) as max_user FROM t_hotel_booking b
                                                    JOIN t_guest_hotel_booking AS g2b
                                                         ON b.id = g2b.hotel_booking_id
                                                    JOIN t_user AS u
                                                         ON u.id = g2b.user_id
GROUP BY b.id
HAVING b.id > 0 -- why not WHERE?
    WHERE max_user > "1990-01-01"







