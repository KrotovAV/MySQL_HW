-- SELECT * FROM univers.students
-- where name = 'Mic_Lomo';

-- SELECT * FROM univers.students
-- where name like '%Lomo';

-- SELECT id.name FROM univers.students
-- where name like '%Lomo';

update students 
set phon = '11111' 
where id = 1;

SELECT * FROM univers.students;

INSERT INTO `univers`.`students` (`id`, `name`, `email`, `phon`) 
VALUES ('4', 'Gfd', 'hjj@jk.jh', '521');


delete from students
where id = 3;
-- SELECT * FROM univers.students; 



