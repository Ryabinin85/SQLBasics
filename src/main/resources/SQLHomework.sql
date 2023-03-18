CREATE DATABASE skypro;
CREATE TABLE IF NOT EXISTS employee (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(6) NOT NULL,
    age INT NOT NULL
    );
SELECT * FROM employee;

INSERT INTO employee (first_name, last_name, gender, age)
VALUES ('Ivan', 'Ivanov', 'M', 30);
INSERT INTO employee (first_name, last_name, gender, age)
VALUES ('Petr', 'Petrov', 'M', 35);
INSERT INTO employee (first_name, last_name, gender, age)
VALUES ('Tanya', 'Sidorova', 'F', 22);

SELECT * FROM employee;

UPDATE employee SET first_name = 'Aleksandr',
                    last_name = 'Aleksandrov',
                    age = 40
WHERE id = 1;

SELECT * FROM employee;

DELETE FROM employee WHERE id = 3;

SELECT * FROM employee;