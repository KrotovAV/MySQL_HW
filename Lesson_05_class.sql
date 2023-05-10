USE lesson_5;

WITH RECURSIVE sequence (n) AS
(
SELECT 0
UNION ALL
SELECT n + 1
FROM sequence
WHERE n + 1 <= 10
)
SELECT n
FROM sequence;
-- ------------------------------------------------------------

CREATE TABLE users (
username VARCHAR(50) PRIMARY KEY,
password VARCHAR(50) NOT NULL,
status VARCHAR(10) NOT NULL);

CREATE TABLE users_profile (
username VARCHAR(50) PRIMARY KEY,
name VARCHAR(50) NOT NULL,
address VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE);

INSERT INTO users values
('admin' , '7856', 'Active'),
('staff' , '90802', 'Active'),
('manager' , '35462', 'Inactive');

INSERT INTO users_profile values
('admin', 'Administrator' , 'Dhanmondi', 'admin@test.com' ) ,
('staff', 'Jakir Nayek' , 'Mirpur', 'zakir@test.com' ),
('manager', 'Mehr Afroz' , 'Eskaton', 'mehr@test.com' );

SELECT * FROM users;
SELECT * FROM users_profile;
/*
1. Используя cte, выведите всех пользователей из таблицы users_profile
2. Используя cte, подсчитайте количество активных пользователей. Задайте псевдоним результирующему окну. Пример:
3. С помощью СТЕ реализуйте таблицу квадратов чисел от 1 до 10:
(пример для чисел от 1 до 3)
*/
-- 1
WITH cte1 AS
(
SELECT * FROM users_profile
)
SELECT * FROM cte1;

-- 2
WITH cte2 AS
(
SELECT COUNT(*) FROM users
WHERE status = 'Active'
)
SELECT * FROM cte2;

-- 3
WITH RECURSIVE cte AS
(
SELECT 1 AS a, 1 * 1 AS res
UNION ALL
SELECT a + 1, POW(a + 1, 2) as res
FROM cte
WHERE a < 10
)
SELECT * FROM cte;

-- -------------------------------------
/*
CREATE TABLE  table1 (
tb VARCHAR(50),

username VARCHAR(50) PRIMARY KEY,
password VARCHAR(50) NOT NULL,
status VARCHAR(10) NOT NULL);
*/

/*
Собрать дэшборд, в котором содержится:
- информация о максимальной задолженности в каждом банке, а также 
- средний размер процентной ставки в каждом банке в зависимости
		от сегмента и количество договоров всего всем банкам
*/
SELECT TB, max(OSZ) OSZ
FROM T
group by TB;

SELECT *, MAX(OSZ) OVER(PARTITION BY TB) 'максимальной задолженности в каждом банке',
AVG(PROCENT_RATE) OVER(PARTITION BY TB, SEGMENT) AS "средний размер процентной ставки в каждом банке в зависимости от сегмента",
COUNT(ID_DOG) OVER() 'количество договоров '
FROM table1;

-- Проранжируем таблицу по убыванию количества ревизий
SELECT *,
ROW_NUMBER() OVER(ORDER BY count_revisions DESC),
RANK() OVER(ORDER BY count_revisions DESC),
DENSE_RANK() OVER(ORDER BY count_revisions DESC),
NTILE(3) OVER(ORDER BY count_revisions DESC)
FROM table1;

-- Найти второй отдел во всех банках по количеству ревизий.
WITH cte AS
(
SELECT *,
DENSE_RANK() OVER(ORDER BY count_revisions DESC) AS ds
FROM table1
)
SELECT * FROM cte
WHERE ds = 2;

-- ----------------------------
-- смщение для событий Event
SELECT *,
LEAD(Event, 1, 'end') OVER(PARTITION BY id_task ORDER BY date_event),
LEAD(date_event, 1, '2099-01-01') OVER(PARTITION BY id_task ORDER BY date_event)
FROM table1;





