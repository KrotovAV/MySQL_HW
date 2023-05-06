USE lesson_4;

CREATE TABLE  auto 
(       
	regnum VARCHAR(10) PRIMARY KEY, 
	mark VARCHAR(10), 
	color VARCHAR(15),
	released DATE, 
	phonenum VARCHAR(15)
);
-- auto
INSERT INTO auto (regnum, mark,	color, released, phonenum )
VALUES
(111114,'LADA', 'КРАСНЫЙ', date'2008-01-01', '9152222221'),
(111115,'VOLVO', 'КРАСНЫЙ', date'2013-01-01', '9173333334'),
(111116,'BMW', 'СИНИЙ', date'2015-01-01', '9173333334'),
(111121,'AUDI', 'СИНИЙ', date'2009-01-01', '9173333332'),
(111122,'AUDI', 'СИНИЙ', date'2011-01-01', '9213333336'),
(111113,'BMW', 'ЗЕЛЕНЫЙ', date'2007-01-01', '9214444444'),
(111126,'LADA', 'ЗЕЛЕНЫЙ', date'2005-01-01', null),
(111117,'BMW', 'СИНИЙ', date'2005-01-01', null),
(111119,'LADA', 'СИНИЙ', date'2017-01-01', 9213333331);

CREATE TABLE man 
(	
	phonenum VARCHAR(15) PRIMARY KEY , 
	firstname VARCHAR(50),
	lastname VARCHAR(50),  
	citycode INT, 
	yearold INT	 
);

-- man
INSERT INTO man (phonenum, firstname, lastname, citycode, yearold)
VALUES
('9152222221','Андрей','Николаев', 1, 22),
('9152222222','Максим','Москитов', 1, 31),
('9153333333','Олег','Денисов', 3, 34),
('9173333334','Алиса','Никина', 4, 31),
('9173333335','Таня','Иванова', 4, 31),
('9213333336','Алексей','Иванов', 7, 25),
('9213333331','Андрей','Некрасов', 2, 27),
('9213333332','Миша','Рогозин', 2, 21),
('9214444444','Алексей','Галкин', 1, 38);

CREATE TABLE city 
(	
    citycode INT PRIMARY KEY,
	cityname VARCHAR(50), 
	peoples INT 
);

-- city
INSERT INTO city (citycode, cityname, peoples)
VALUES
(1, 'Москва', 10000000),
(2, 'Владимир', 500000),
(3, 'Орел', 300000),
(4, 'Курск', 200000),
(5, 'Казань', 2000000),
(7, 'Котлас', 110000),
(8, 'Мурманск', 400000),
(9, 'Ярославль', 500000);

SELECT * FROM city;
SELECT * FROM man;
SELECT * FROM auto;

/*
1.Вывести на экран, сколько машин каждого цвета  для машин марок BMW и LADA
2.Вывести на экран марку авто(количество) и количество авто не этой марки.
100 машин, их них 20 - BMW и 80 машин другой марки ,  AUDI - 30 и 70 машин другой марки, LADA - 15, 85 авто другой марки
*/
-- 1
SELECT mark, color, COUNT(*) as count FROM auto 
where mark IN ('BMW', 'LADA')
GROUP BY mark, color
ORDER BY mark;

-- 2
SELECT mark, COUNT(*) as count, (SELECT COUNT(*) AS 'Кол-во' FROM auto) - COUNT(*) FROM auto 
GROUP BY mark;

CREATE TABLE test_a_2 (id INT, test varchar(10));
INSERT INTO test_a_2 (id, test) values
(10, 'A'),
(20, 'A'),
(30, 'F'),
(40, 'D'),
(50, 'C');

CREATE TABLE test_b_2 (id INT);
INSERT INTO test_b_2 (id) values
(10),
(30),
(50);

SELECT * FROM test_a_2;
SELECT * FROM test_b_2;

-- Напишите запрос, который вернет строки из таблицы test_a, id которых нет в таблице test_b, НЕ используя ключевого слова NOT.
SELECT * FROM test_a_2
WHERE !EXISTS (SELECT * FROM test_b_2
WHERE test_a_2.id = test_b_2.id);




