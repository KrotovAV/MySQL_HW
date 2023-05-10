USE lesson_6;
/*
1.	Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней, часов, минут и секунд.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

2.	Выведите только четные числа от 1 до 10 включительно.
Пример: 2,4,6,8,10 (можно сделать через шаг +  2: х = 2, х+=2)
*/

CREATE TABLE time_6 (
	times varchar(20) PRIMARY KEY NOT NULL, 
	seconds INT
);

INSERT INTO time_6
VALUES 
('years', 31536000),
('days', 84600),
('hours', 3600),
('minutes', 60)
;

SELECT 'years' FROM time_6;
SELECT seconds FROM time_6 WHERE times = 'years';

-- 1
DELIMITER $$
CREATE PROCEDURE times(seconds INTEGER)
BEGIN
	DECLARE years INT default 0;
    DECLARE days INT default 0;
    DECLARE hours INT default 0;
    DECLARE minutes INT default 0;

	-- SELECT @const_years := seconds From time_6 WHERE times = 'years';
    -- SELECT @const_days := seconds From time_6 WHERE times = 'days';
	-- SELECT @const_hours := seconds From time_6 WHERE times = 'hours';
	-- SELECT @const_seconds := seconds From time_6 WHERE times = 'seconds';
  
   WHILE seconds >= 31536000 DO
		SET years = seconds / 31536000;
		SET seconds = seconds % 31536000;
    END WHILE;
    WHILE seconds >= 84600 DO
		SET days = seconds / 84600;
		SET seconds = seconds % 84600;
    END WHILE;

    WHILE seconds >= 3600 DO
		SET hours = seconds / 3600;
		SET seconds = seconds % 3600;
    END WHILE;

    WHILE seconds >= 60 DO
		SET minutes = seconds / 60;
		SET seconds = seconds % 60;
    END WHILE;
	SELECT years, days, hours, minutes, seconds;
END $$
DELIMITER ;

CALL times(123456); 

-- 2

DELIMITER $$
CREATE PROCEDURE even_increase(n INT)
BEGIN
	DECLARE m INT DEFAULT 0;
	DECLARE res VARCHAR(50) DEFAULT '';

	REPEAT
		SET res = CONCAT(res, ' ', m);
		SET m = m + 2;
		UNTIL n < m
	END REPEAT;
	SELECT res;
END $$
DELIMITER ;

CALL even_increase(12);
