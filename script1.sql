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











