

ALTER TABLE Departments
NOCHECK CONSTRAINT FK_Department_LeadTeacher;



INSERT INTO Departments (dept_Name, leadTeacherID)
VALUES
('Computer Science', 1),
('Mathematics', 4),
('Physics', 7)



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
('Karim Tarek', 3, 7)

('Hassan Ahmed', 1, 1),
('Mai Mohamed', 2, 4),
('Khaled Samir', 3, 7)



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
('Adam Mahmoud', 3)
('Asmaa Ali', 3),
('Mai Hany',1)

INSERT INTO Courses
    (course_Name, course_Code, teacher_ID, department_ID)
VALUES
('Database Systems', 'CS301', 1, 1),
('Object Oriented Programming', 'CS302', 2, 1),
('Data Structures', 'CS303', 3, 1),

('Calculus', 'MATH301', 4, 2),
('Linear Algebra', 'MATH302', 5, 2),

('Classical Mechanics', 'PHY301', 7, 3),
('Electromagnetism', 'PHY302', 8, 3)
    
('Operating Systems', 'CS304', 10, 1),
('Computer Networks', 'CS305', 10, 1),
('Web Development', 'CS306', 10, 1),
('Software Engineering', 'CS307', 10, 1),

('Statistics', 'MATH303', 11, 2),
('Differential Equations', 'MATH304', 11, 2),
('Probability', 'MATH305', 11, 2),
('Number Theory', 'MATH306', 11, 2),
('Mathematical Logic', 'MATH307', 11, 2),

('Thermodynamics', 'PHY303', 12, 3),
('Optics', 'PHY304', 12, 3)

INSERT INTO Enrollment
    (student_ID, course_ID, grade)
VALUES
(3,3,0),
(3, 4, 90),
(3, 5, null),
(4, 3, 92),
(4, 4, null),
(4, 5, 50),
(5, 3, 76),
(5, 4, 95),
(5, 5, 38),
(6, 6, 89),
(6, 7, 94),
(7, 6, 45),
(7, 7, 79),
(8, 6, 91),
(8, 7, null),
(9, 8, 40),
(9, 9, 60),
(10, 8, 77),
(10, 9, 84),
(11, 8, 67),
(11, 9, null)


INSERT INTO Enrollment
    (student_ID, course_ID, grade, enrollment_Date)
VALUES
(8, 4, 34, '2025-10-10'),
(9, 3, null, '2025-10-12'),
(10, 5, 87, '2025-10-20')

