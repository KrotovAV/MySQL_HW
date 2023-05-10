USE lesson_5;

CREATE TABLE cars_5 (
id INT AUTO_INCREMENT PRIMARY KEY,
name_car VARCHAR(60),
cost INT
);

INSERT INTO cars_5 (name_car, cost)
VALUES
('Audi', 52642),
('Mercedes', 57127),
('Skoda', 9000),
('Volvo', 29000),
('Bentley', 350000),
('Citroen', 21000),
('Hummer', 41400),
('Volkswagen', 21600);

SELECT * FROM cars_5;

/*
1.	Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов
2.	Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 
3. 	Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
*/

-- 1
CREATE VIEW cost_2000 AS
SELECT * FROM cars_5
WHERE cost > 25000;

SELECT * FROM cost_2000;

-- 2
ALTER VIEW cost_2000 AS
SELECT * FROM cars_5
WHERE cost < 30000;

SELECT * FROM cost_2000;

-- 3
CREATE VIEW cost_Skoda_Audi AS
SELECT * FROM cars_5
HAVING name_car IN ('Skoda', 'Audi');

SELECT * FROM  cost_Skoda_Audi;

-- -------------
/* 
Есть таблица анализов Analysis:
an_id — ID анализа;
an_name — название анализа;
an_cost — себестоимость анализа;
an_price — розничная цена анализа;
an_group — группа анализов.

Есть таблица групп анализов Groups:
gr_id — ID группы;
gr_name — название группы;
gr_temp — температурный режим хранения.

Есть таблица заказов Orders:
ord_id — ID заказа;
ord_datetime — дата и время заказа;
ord_an — ID анализа.
*/

CREATE TABLE analysis (
an_id INT AUTO_INCREMENT PRIMARY KEY,
an_name VARCHAR(60),
an_cost INT,
an_price INT,
an_group VARCHAR(60)
);

INSERT INTO analysis (an_name, an_cost, an_price, an_group)
VALUES
('bcd_bl', 15, 15, 'simpl'),
('bca_bl', 15, 15, 'simpl'),
('acid_mi', 20, 25, 'semiH'),
('sho_bj', 25, 25, 'semiH'),
('abc_FBl', 25, 25, 'HevDEW');

SELECT * FROM analysis;

CREATE TABLE groups_an (
gr_id  INT AUTO_INCREMENT PRIMARY KEY,
gr_name VARCHAR(60),
gr_temp VARCHAR(60)
);

INSERT INTO  groups_an (gr_name, gr_temp)
VALUES
('simpl', 0),
('semiH', -5),
('HevDEW', -10);

SELECT * FROM  groups_an;

CREATE TABLE orders_an (
ord_id  INT AUTO_INCREMENT PRIMARY KEY,
ord_datetime DATETIME,
ord_an INT
);

INSERT INTO orders_an (ord_datetime, ord_an)
VALUES
('2020-02-05 10:25:54', 1),
('2020-02-05 11:25:54', 2),
('2020-02-05 14:25:54', 3),
('2020-02-06 21:25:54', 1),
('2020-02-06 21:25:54', 2),
('2020-02-06 21:25:54', 2),
('2020-02-07 21:25:54', 1),
('2020-02-08 21:25:54', 3),
('2020-02-15 21:25:54', 2),
('2020-03-25 10:00:00', 2),
('2020-03-28 10:00:00', 1);

SELECT * FROM  orders_an;

-- Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю

CREATE VIEW ordrs_date AS
SELECT ord_id, ord_datetime, an_name, an_cost  FROM orders_an, analysis
WHERE  orders_an.ord_an = analysis.an_id
HAVING ord_datetime BETWEEN '2020-02-05 00:00:00' and '2020-02-12 00:00:00';

SELECT * FROM ordrs_date;

-- -------------------------------------
/*
Добавьте новый столбец под названием «время до следующей станции». 
Чтобы получить это значение, мы вычитаем время станций для пар смежных станций. 
Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно. 
Проще это сделать с помощью оконной функции LEAD . Эта функция сравнивает 
значения из одной строки со следующей строкой, чтобы получить результат. 
В этом случае функция сравнивает значения в столбце «время» 
для станции со станцией сразу после нее.

*/
CREATE TABLE train_schedule (
train_id  INT,
station VARCHAR(20),
station_time TIME,
time_to_next_station TIME
);
INSERT INTO train_schedule (train_id, station, station_time, time_to_next_station)
VALUES
(110, 'San Francisco', '10:00:00', '00:54:00'),
(110, 'Red Wood city', '10:54:00', '00:08:00'),
(110, 'Palo Alto', '11:02:00', '01:33:00'),
(110, 'San Jose', '12:35:00', '00:00:00'),
(120, 'San Francisco', '11:0:00', '01:49:00'),
(120, 'Palo Alto', '12:49:00', '0:41:00'),
(120, 'San Jose', '13:30:00', '00:00:00');

SELECT * FROM train_schedule;

CREATE TABLE train_schedule (
train_id  INT,
station VARCHAR(20),
station_time TIME
);
INSERT INTO train_schedule (train_id, station, station_time)
VALUES
(110, 'San Francisco', '10:00:00'),
(110, 'Red Wood city', '10:54:00'),
(110, 'Palo Alto', '11:02:00'),
(110, 'San Jose', '12:35:00'),
(120, 'San Francisco', '11:0:00'),
(120, 'Palo Alto', '12:49:00'),
(120, 'San Jose', '13:30:00');

SELECT * FROM train_schedule;

-- ответ на запрос только новый столбец
SELECT SUBTIME (LEAD(station_time) 
OVER(PARTITION BY train_id 
ORDER BY train_id), station_time) AS time_to_next_station
FROM train_schedule;

-- ответ на запрос целиком
SELECT train_id, station, station_time, SUBTIME (LEAD(station_time) 
OVER(PARTITION BY train_id 
ORDER BY train_id), station_time) AS time_to_next_station
FROM train_schedule;

-- создание новой таблицы со столбцом time_to_next_station
CREATE TABLE new_train_schedule AS
SELECT train_id, station, station_time, SUBTIME (LEAD(station_time) 
OVER(PARTITION BY train_id 
ORDER BY train_id), station_time) AS time_to_next_station
FROM train_schedule;

SELECT * FROM new_train_schedule;


