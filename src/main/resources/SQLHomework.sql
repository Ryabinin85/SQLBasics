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