

ALTER TABLE Departments
NOCHECK CONSTRAINT FK_Department_LeadTeacher;



INSERT INTO Departments (dept_Name, leadTeacherID)
VALUES
('Computer Science', 1),
('Mathematics', 4),
('Physics', 7);



INSERT INTO Teachers (tech_Name, dept_ID, supervise_ID)
VALUES
('Ahmed Hassan', 1, NULL),
('Mona Ali', 1, 1),
('Omar Khaled', 1, 1),

('Sara Mohamed', 2, NULL),
('Youssef Adel', 2, 4),
('Nour Ahmed', 2, 4),

('Mahmoud Samir', 3, NULL),
('Hana Mostafa', 3, 7),
('Karim Tarek', 3, 7);



ALTER TABLE Departments
WITH CHECK CHECK CONSTRAINT FK_Department_LeadTeacher;


INSERT INTO Students (stud_Name, dept_ID)
VALUES
('Ali Mostafa', 1),
('Mariam Ahmed', 1),
('Omar Hassan', 1),

('Yasmin Khaled', 2),
('Ahmed Samir', 2),
('Salma Adel', 2),

('Karim Mohamed', 3),
('Hala Tarek', 3),
('Adam Mahmoud', 3);


INSERT INTO Courses
    (course_Name, course_Code, teacher_ID, department_ID)
VALUES
('Database Systems', 'CS301', 1, 1),
('Object Oriented Programming', 'CS302', 2, 1),
('Data Structures', 'CS303', 3, 1),

('Calculus', 'MATH301', 4, 2),
('Linear Algebra', 'MATH302', 5, 2),

('Classical Mechanics', 'PHY301', 7, 3),
('Electromagnetism', 'PHY302', 8, 3);
  

INSERT INTO Enrollment
    (grade, enrollment_Date, student_ID, course_ID)
VALUES
(95, '2026-02-01', 3, 3),
(88, '2026-02-02', 3, 4),
(NULL, '2026-02-03', 3, 8),

(91, '2026-02-01', 4, 3),
(84, '2026-02-02', 4, 8),
(90, '2026-02-03', 4, 5),

(78, '2026-02-01', 5, 4),
(NULL, '2026-02-02', 5, 9),

(87, '2026-02-01', 6, 4),
(93, '2026-02-02', 6, 5),

(75, '2026-02-01', 7, 5),
(NULL, '2026-02-02', 7, 6),

(89, '2026-02-01', 8, 9),
(96, '2026-02-02', 8, 7),

(92, '2026-02-01', 11 ,8),
(85, '2026-02-02', 11, 8),

(80, '2026-02-01', 10, 9),
(NULL, '2026-02-02', 10, 7),

(94, '2026-02-01', 9, 6),
(88, '2026-02-02', 9, 7);
