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

INSERT INTO employee (first_name, last_name, gender, age)
VALUES ('Katya', 'Orlova', 'F', 25);
INSERT INTO employee (first_name, last_name, gender, age)
VALUES ('Oleg', 'Vasiliev', 'M', 32);
INSERT INTO employee (first_name, last_name, gender, age)
VALUES ('Tanya', 'Sidorova', 'F', 22);

SELECT * FROM employee;

SELECT first_name AS Имя,
       last_name AS Фамилия
FROM employee;

--Получите всю информацию о сотрудниках, которые младше 30 или старше 50 лет.
SELECT * FROM employee
WHERE NOT age BETWEEN 30 AND 50;

--Получите всю информацию о сотрудниках, которым от 30 до 50 лет.
SELECT * FROM employee
WHERE age BETWEEN 30 AND 50;

--Выведите полный список сотрудников, которые отсортированы по фамилиям в обратном порядке.
SELECT * FROM employee
ORDER BY first_name DESC;

--Выведите сотрудников, имена которых длиннее 4 символов.
SELECT * FROM employee
WHERE first_name LIKE '_____%';

--Измените имена у двух сотрудников так, чтобы на 5 сотрудников было только 3 разных имени,
--то есть чтобы получились две пары тезок и один сотрудник с уникальным именем.
UPDATE employee SET first_name = 'Petr',
                    last_name = 'Petrov',
                    age = 45
WHERE id = 1;

UPDATE employee SET first_name = 'Tanya',
                    last_name = 'Sidorova',
                    age = 23
WHERE id = 5;

--Посчитайте суммарный возраст для каждого имени. Выведите в двух столбцах «имя» и «суммарный возраст».
SELECT first_name AS Имя,
       SUM(age) AS Суммарный_возраст
FROM employee
GROUP BY first_name;

--Выведите имя и самый юный возраст, соответствующий имени.
SELECT first_name AS Имя,
       age AS Возраст
FROM employee
WHERE age = (SELECT MIN(age)
             FROM employee);

--Выведите имя и максимальный возраст только для неуникальных имен.
--Результат отсортируйте по возрасту в порядке возрастания.
SELECT first_name AS Имя,
       MAX(age) AS Возраст
FROM employee
GROUP BY first_name
HAVING COUNT(*) > 1
ORDER BY Возраст;

CREATE TABLE IF NOT EXISTS city (
    city_id   BIGSERIAL   NOT NULL PRIMARY KEY,
    city_name VARCHAR(60) NOT NULL);

INSERT INTO employee (first_name, last_name, gender, age)
VALUES ('Ivan', 'Ivanov', 'M', 30);
INSERT INTO employee (first_name, last_name, gender, age)
VALUES ('Petr', 'Petrov', 'M', 35);
INSERT INTO employee (first_name, last_name, gender, age)
VALUES ('Tanya', 'Sidorova', 'F', 22);
INSERT INTO employee (first_name, last_name, gender, age)
VALUES ('Katya', 'Orlova', 'F', 25);
INSERT INTO employee (first_name, last_name, gender, age)
VALUES ('Oleg', 'Vasiliev', 'M', 32);

SELECT * FROM employee;

--Добавьте в таблицу employee колонку city_id.
ALTER TABLE employee
    ADD COLUMN city_id INT;

--Назначьте ее внешним ключом и свяжите с таблицей city.
ALTER TABLE employee
    ADD CONSTRAINT city_id
    FOREIGN KEY (city_id) REFERENCES city (city_id);

--Заполните таблицу city и назначьте работникам соответствующие города.
INSERT INTO city (city_name)
VALUES ('Moscow');
INSERT INTO city (city_name)
VALUES ('Samara');
INSERT INTO city (city_name)
VALUES ('Kazan');
INSERT INTO city (city_name)
VALUES ('Krasnodar');
INSERT INTO city (city_name)
VALUES ('Volgograd');
INSERT INTO city (city_name)
VALUES ('Vladivostok');

SELECT * FROM city;

UPDATE employee SET city_id = 1 WHERE first_name = 'Ivan';
UPDATE employee SET city_id = 2 WHERE first_name = 'Petr';
UPDATE employee SET city_id = 3 WHERE first_name = 'Tanya';
UPDATE employee SET city_id = 4 WHERE first_name = 'Katya';
UPDATE employee SET city_id = 5 WHERE first_name = 'Oleg';

SELECT * FROM employee;

--Получите имена и фамилии сотрудников, а также города, в которых они проживают.
SELECT first_name, last_name, city_name FROM employee
INNER JOIN city
ON employee.city_id = city.city_id
ORDER BY first_name;

--Получите города, а также имена и фамилии сотрудников, которые в них проживают.
--Если в городе никто из сотрудников не живет, то вместо имени должен стоять null.
SELECT city_name, first_name, last_name FROM city
LEFT JOIN employee
ON city.city_id = employee.city_id
ORDER BY city_name;

SELECT first_name, last_name, city_name FROM employee
RIGHT JOIN city
ON employee.city_id = city.city_id
ORDER BY first_name;

--Получите имена всех сотрудников и названия всех городов.
--Если в городе не живет никто из сотрудников, то вместо имени должен стоять null.
--Аналогично, если города для какого-то из сотрудников нет в списке, так же должен быть получен null.
SELECT first_name, last_name, city_name FROM employee
FULL OUTER JOIN city
ON employee.city_id = city.city_id
ORDER BY first_name;

--Получите таблицу, в которой каждому имени должен соответствовать каждый город.
SELECT first_name, last_name, city_name FROM employee
CROSS JOIN city;