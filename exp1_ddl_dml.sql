-- ============================================================
-- SRIT R23 | Database Management Systems Lab
-- Experiment 1 : SQL Data Definition and Data Manipulation
-- Oracle Database 21c XE
-- ============================================================

SET SERVEROUTPUT ON


-- ------------------------------------------------------------
-- EXPERIMENT 1a : SQL DDL commands (tables WITHOUT constraints)
-- ------------------------------------------------------------

-- 1a-1. Create the tables of the database without constraints
CREATE TABLE student (
  name           VARCHAR2(20),
  student_number NUMBER(3),
  class          NUMBER(1),
  major          VARCHAR2(10)
);
CREATE TABLE course (
  course_name   VARCHAR2(30),
  course_number VARCHAR2(15),
  credit_hours  NUMBER(2),
  department    VARCHAR2(15)
);
CREATE TABLE section (
  section_identifier NUMBER(4),
  course_number      VARCHAR2(15),
  semester           VARCHAR2(10),
  year               VARCHAR2(4),
  instructor         VARCHAR2(15)
);
CREATE TABLE grade_report (
  student_number     NUMBER(3),
  section_identifier NUMBER(4),
  grade              VARCHAR2(5)
);
CREATE TABLE prerequisite (
  course_number       VARCHAR2(15),
  prerequisite_number VARCHAR2(20)
);

-- 1a-2. Insert all values into the tables
INSERT INTO student VALUES ('Smith', 17, 1, 'CS');
INSERT INTO student VALUES ('Brown', 8, 2, 'CS');
INSERT INTO course VALUES ('Intro to Computer Science', 'CS1310', 4, 'CS');
INSERT INTO course VALUES ('Data Structures', 'CS3320', 4, 'CS');
INSERT INTO course VALUES ('Discrete Mathematics', 'MATH2410', 3, 'MATH');
INSERT INTO course VALUES ('Database', 'CS3380', 3, 'CS');
INSERT INTO section VALUES (85, 'MATH2410', 'Fall', '07', 'King');
INSERT INTO section VALUES (92, 'CS1310', 'Fall', '07', 'Anderson');
INSERT INTO section VALUES (102, 'CS3320', 'Spring', '08', 'Knuth');
INSERT INTO section VALUES (112, 'MATH2410', 'Fall', '08', 'Chang');
INSERT INTO section VALUES (119, 'CS1310', 'Fall', '08', 'Anderson');
INSERT INTO section VALUES (135, 'CS3380', 'Fall', '08', 'Stone');
INSERT INTO grade_report VALUES (17, 112, 'B');
INSERT INTO grade_report VALUES (17, 119, 'C');
INSERT INTO grade_report VALUES (8, 85, 'A');
INSERT INTO grade_report VALUES (8, 92, 'A');
INSERT INTO grade_report VALUES (8, 102, 'B');
INSERT INTO grade_report VALUES (8, 135, 'A');
INSERT INTO prerequisite VALUES ('CS3380', 'CS3320');
INSERT INTO prerequisite VALUES ('CS3380', 'MATH2410');
INSERT INTO prerequisite VALUES ('CS3320', 'CS1310');
COMMIT;

-- 1a-3. Describe all tables
DESC student;
DESC course;
DESC section;
DESC grade_report;
DESC prerequisite;

-- 1a-4. List the created tables
SELECT table_name FROM user_tables ORDER BY table_name;

-- 1a-5. Display the values of each table
SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM section;
SELECT * FROM grade_report;
SELECT * FROM prerequisite;

-- 1a-6. Delete all tables
DROP TABLE grade_report PURGE;
DROP TABLE prerequisite PURGE;
DROP TABLE section PURGE;
DROP TABLE course PURGE;
DROP TABLE student PURGE;

-- ------------------------------------------------------------
-- EXPERIMENT 1b : SQL DML commands (tables WITH constraints)
-- ------------------------------------------------------------

-- 1b-1. Implement the tables using the given constraints
CREATE TABLE student (
  name           VARCHAR2(20),
  student_number NUMBER(3),
  class          NUMBER(1),
  major          VARCHAR2(10) NOT NULL,
  CONSTRAINT pk_student PRIMARY KEY (student_number)
);
CREATE TABLE course (
  course_name   VARCHAR2(30),
  course_number VARCHAR2(15),
  credit_hours  NUMBER(2) NOT NULL,
  department    VARCHAR2(15),
  CONSTRAINT pk_course PRIMARY KEY (course_number)
);
CREATE TABLE section (
  section_identifier NUMBER(4),
  course_number      VARCHAR2(15),
  semester           VARCHAR2(10) NOT NULL,
  year               VARCHAR2(4),
  instructor         VARCHAR2(15),
  CONSTRAINT pk_section PRIMARY KEY (section_identifier)
);
CREATE TABLE grade_report (
  student_number     NUMBER(3),
  section_identifier NUMBER(4),
  grade              VARCHAR2(5) NOT NULL,
  CONSTRAINT pk_grade_report PRIMARY KEY (student_number, section_identifier),
  CONSTRAINT fk_gr_student FOREIGN KEY (student_number)
    REFERENCES student(student_number) ON DELETE CASCADE,
  CONSTRAINT fk_gr_section FOREIGN KEY (section_identifier)
    REFERENCES section(section_identifier) ON DELETE CASCADE
);
CREATE TABLE prerequisite (
  course_number       VARCHAR2(15),
  prerequisite_number VARCHAR2(20),
  CONSTRAINT pk_prerequisite PRIMARY KEY (course_number, prerequisite_number),
  CONSTRAINT fk_prereq_course FOREIGN KEY (course_number)
    REFERENCES course(course_number) ON DELETE CASCADE
);

-- 1b-2. Display the description of each table
DESC student;
DESC course;
DESC section;
DESC grade_report;
DESC prerequisite;

-- 1b-3. Insert the values of the database
INSERT INTO student VALUES ('Smith', 17, 1, 'CS');
INSERT INTO student VALUES ('Brown', 8, 2, 'CS');
INSERT INTO course VALUES ('Intro to Computer Science', 'CS1310', 4, 'CS');
INSERT INTO course VALUES ('Data Structures', 'CS3320', 4, 'CS');
INSERT INTO course VALUES ('Discrete Mathematics', 'MATH2410', 3, 'MATH');
INSERT INTO course VALUES ('Database', 'CS3380', 3, 'CS');
INSERT INTO section VALUES (85, 'MATH2410', 'Fall', '07', 'King');
INSERT INTO section VALUES (92, 'CS1310', 'Fall', '07', 'Anderson');
INSERT INTO section VALUES (102, 'CS3320', 'Spring', '08', 'Knuth');
INSERT INTO section VALUES (112, 'MATH2410', 'Fall', '08', 'Chang');
INSERT INTO section VALUES (119, 'CS1310', 'Fall', '08', 'Anderson');
INSERT INTO section VALUES (135, 'CS3380', 'Fall', '08', 'Stone');
INSERT INTO grade_report VALUES (17, 112, 'B');
INSERT INTO grade_report VALUES (17, 119, 'C');
INSERT INTO grade_report VALUES (8, 85, 'A');
INSERT INTO grade_report VALUES (8, 92, 'A');
INSERT INTO grade_report VALUES (8, 102, 'B');
INSERT INTO grade_report VALUES (8, 135, 'A');
INSERT INTO prerequisite VALUES ('CS3380', 'CS3320');
INSERT INTO prerequisite VALUES ('CS3380', 'MATH2410');
INSERT INTO prerequisite VALUES ('CS3320', 'CS1310');
COMMIT;

-- 1b-4. Display the instances of each table
SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM section;
SELECT * FROM grade_report;
SELECT * FROM prerequisite;

-- 1b-5. Add a branch attribute to student and describe the table
ALTER TABLE student ADD branch VARCHAR2(10);
DESC student;

-- 1b-6. Copy major values into branch and display it
UPDATE student SET branch = major;
SELECT * FROM student;

-- 1b-7. Remove the major attribute from student
ALTER TABLE student DROP COLUMN major;
DESC student;

-- 1b-8. Rename course_number to cid in course and describe it
ALTER TABLE course RENAME COLUMN course_number TO cid;
DESC course;

-- 1b-9. Change the credit hours of all courses to 4
UPDATE course SET credit_hours = 4;
SELECT * FROM course;

-- 1b-10. Put a NOT NULL constraint on branch in student
ALTER TABLE student MODIFY branch NOT NULL;
DESC student;

-- 1b-11. Rename the student table to pupil
ALTER TABLE student RENAME TO pupil;

-- 1b-12. Remove the student table (it is now named pupil, so this gives an error)
DROP TABLE student;

-- 1b-13. Remove the rows of the 'Fall' semester in section
DELETE FROM section WHERE semester = 'Fall';
SELECT * FROM section;

-- 1b-14. Remove the row of 'Data Structures' in course
DELETE FROM course WHERE course_name = 'Data Structures';
SELECT * FROM course;
COMMIT;

-- 1b-15. Remove all rows of all tables using TRUNCATE
TRUNCATE TABLE grade_report;
TRUNCATE TABLE prerequisite;
TRUNCATE TABLE pupil CASCADE;
TRUNCATE TABLE section CASCADE;
TRUNCATE TABLE course CASCADE;

-- 1b-16. Remove pupil, course and section so that they stay in the recycle bin
DROP TABLE pupil CASCADE CONSTRAINTS;
DROP TABLE course CASCADE CONSTRAINTS;
DROP TABLE section CASCADE CONSTRAINTS;
SHOW RECYCLEBIN;

-- 1b-17. Remove grade_report and prerequisite tables permanently
DROP TABLE grade_report PURGE;
DROP TABLE prerequisite PURGE;
SELECT table_name FROM user_tables;
