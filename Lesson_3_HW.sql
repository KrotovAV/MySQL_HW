USE lesson_3;

CREATE TABLE salespeople (
snum INT,
sname VARCHAR(45),
city VARCHAR(45),
comm DECIMAL (5,2)
);

INSERT INTO salespeople (snum, sname, city, comm)
VALUES
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rifkin', 'Barcelona', 0.15),
(1003, 'Axelrod', 'New York', 0.10);

SELECT * FROM salespeople;

CREATE TABLE customers (
cnum INT,
cname VARCHAR(45),
city VARCHAR(45),
rating INT,
snum INT
);

INSERT INTO customers (cnum, cname, city, rating, snum)
VALUES
(2001, 'Hoffman', 'London', 100,  1001),
(2002, 'Giovanni', 'Rome', 200, 1003),
(2003, 'Liu', 'SanJose',  200, 1002),
(2004, 'Grass', 'Berlin', 300, 1002),
(2006, 'Clemens', 'London', 100, 1001),
(2008, 'Cisneros', 'SanJose',  300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004);

SELECT * FROM customers;

CREATE TABLE orders (
onum INT,
amt DECIMAL (7,2),
odate DATE NOT NULL,
cnum INT,
snum INT
);

INSERT INTO orders (onum, amt, odate, cnum, snum)
VALUES
(3001, 18.69, '1990-03-01', 2008, 10070),
(3003, 767.19, '1990-03-01', 2001, 1001),
(3002, 1900.10, '1990-03-01', 2007, 10040),
(3005, 5160.45, '1990-03-01', 2003, 1002),
(3006, 1098.16, '1990-03-01', 2008, 1007),
(3009, 1713.23,'1990-04-01', 2002, 1003),
(3007, 75.75, '1990-04-01', 2004, 10020),
(3008, 4723.00, '1990-05-01', 2006, 1001),
(3010, 1309.95, '1990-06-01', 2004, 1002),
(3011, 9891.88, '1990-06-01', 2006 , 1001);

SELECT * FROM orders;


/*
1. Напишите запрос, который вывел бы таблицу со столбцами в следующем порядке: 
city, sname, snum, comm. (к первой или второй таблице, используя SELECT)
2. 	 Напишите команду SELECT, которая вывела бы оценку(rating), 
сопровождаемую именем каждого заказчика в городе San Jose. (“заказчики”)
3. Напишите запрос, который вывел бы значения snum всех продавцов из таблицы
заказов без каких бы то ни было повторений. (уникальные значения в  “snum“ “Продавцы”)
4*. Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются с буквы G. 
Используется оператор "LIKE": (“заказчики”) https://dev.mysql.com/doc/refman/8.0/en/string-comparison-functions.html
5. 	Напишите запрос, который может дать вам все заказы со значениями суммы выше чем $1,000. (“Заказы”, “amt”  - сумма)
6.	Напишите запрос который выбрал бы наименьшую сумму заказа.
 (Из поля “amt” - сумма в таблице “Заказы” выбрать наименьшее значение)
7. 	Напишите запрос к таблице “Заказчики”, который может показать всех заказчиков, у которых рейтинг больше 100 и они находятся не в Риме.
*/

-- 1
SELECT city, sname, snum, comm FROM salespeople;

-- 2
SELECT cname, rating, city FROM customers where city = 'SanJose'; 

-- 3
SELECT DISTINCT snum FROM orders;
SELECT DISTINCT snum FROM salespeople;
SELECT DISTINCT snum AS 'seylers' FROM salespeople;

-- 4 
SELECT cnum, cname, city FROM customers
where cname like 'G%';

-- 5 
SELECT onum FROM orders where amt > 1000;
SELECT onum, amt, odate, cnum, snum FROM orders where amt > 1000;

-- 6
SELECT amt FROM orders ORDER BY amt LIMIT 1;
SELECT onum, amt, odate, cnum, snum FROM orders ORDER BY amt LIMIT 1;

-- 7. 	
-- Напишите запрос к таблице “Заказчики”, который может показать всех заказчиков, 
-- у которых рейтинг больше 100 и они находятся не в Риме.

SELECT cname FROM customers where rating > 100;
SELECT cnum, cname, city, rating, snum FROM customers where rating > 100;


CREATE TABLE staff (
id INT AUTO_INCREMENT PRIMARY KEY,
firstname VARCHAR(45),
lastname VARCHAR(45),
post VARCHAR(100),
seniority INT,
salary INT,
age INT
);

-- Наполнение данными
INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
('Вася', 'Петров', 'Начальник', '40', 100000, 60),
('Петр', 'Власов', 'Начальник', '8', 70000, 30),
('Катя', 'Катина', 'Инженер', '2', 70000, 25),
('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
('Иван', 'Иванов', 'Рабочий', '40', 30000, 59),
('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49);

/*
1 Отсортируйте поле “зарплата” в порядке убывания и возрастания
2 ** Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк с наибольшей заработной платой (возможен подзапрос)
3 Выполните группировку всех сотрудников по специальности , суммарная зарплата которых превышает 100000
*/
 -- 1
SELECT * FROM staff ORDER BY  salary;
SELECT * FROM staff ORDER BY  salary desc;

-- 2
(SELECT * FROM staff ORDER BY salary DESC LIMIT 5) ORDER BY salary ;

-- 3 Выполните группировку всех сотрудников по специальности , суммарная зарплата которых превышает 100000
SELECT post, sum(salary) AS summ FROM staff GROUP BY post HAVING summ > 100000;