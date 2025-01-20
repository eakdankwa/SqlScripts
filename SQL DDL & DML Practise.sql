-- Q1
CREATE TABLE Students (
student_ID BIGINT,
student_name VARCHAR(55),
student_level INT
)
;
INSERT INTO Students
VALUES (1001, 'Kofi Dankwa', 200),
(1002,'Roby Daniels',200),
(1003,'Mac Roby',100),
(1004, 'Michael Jackson', 400),
(1005, 'Dun Cooke', 100),
(1006,'Robert Hook',300)

-- select * from students;

-- *Q2 
ALTER TABLE students
ADD COLUMN height_cm float; 

/*UPDATE students SET height_cm = 170 WHERE student_ID = 1001;
UPDATE students SET height_cm = 165.5 WHERE student_ID = 1002;
UPDATE students SET height_cm = 200 WHERE student_ID = 1003;
UPDATE students SET height_cm = 145 WHERE student_ID = 1004;
UPDATE students SET height_cm = 167 WHERE student_ID = 1005;
UPDATE students SET height_cm = 200.5 WHERE student_ID = 1006; */

-- Q3 & Q4
ALTER TABLE students CHANGE student_id id int  NOT NULL;
select * from students;
DELETE FROM students WHERE id IS NULL AND student_name IS NULL AND student_level IS NULL and height_cm IS NULL;

-- Q5
RENAME TABLE students TO Student_Population;
RENAME TABLE Student_Population TO students ;