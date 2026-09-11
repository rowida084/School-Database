

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

INSERT INTO Courses  --cources IDs from 3 to 20 
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
(2, 10, 92, '2025-10-06'),
(6, 10, NULL, '2025-10-07'),
(1, 11, 76, '2025-10-08'),
(3, 11, 85, '2025-10-09'),
(7, 11, 91, '2025-10-10'),
(4, 12, NULL, '2025-10-12'),
(8, 12, 78, '2025-10-13'),
(1, 13, 84, '2025-10-14'),
(5, 13, 73, '2025-10-15'),
(9, 13, 95, '2025-10-16'),
(2, 14, 89, '2025-10-17'),
(6, 14, 67, '2025-10-18'),
(10, 14, NULL, '2025-10-19'),
(3, 15, 94, '2025-10-20'),
(7, 15, 81, '2025-10-21'),
(11, 15, 72, '2025-10-22'),
(7, 16, 86, '2025-10-23'),
(8, 16, 91, '2025-10-24'),
(9, 16, NULL, '2025-10-25'),
(6, 17, 79, '2025-10-26'),
(8, 17, 88, '2025-10-27'),
(10, 17, 65, '2025-10-28'),
(7, 18, 93, '2025-10-29'),
(9, 18, 74, '2025-10-30'),
(11, 18, NULL, '2025-10-31'),
(6, 19, 82, '2025-11-01'),
(8, 19, 90, '2025-11-02'),
(10, 19, 77, '2025-11-03'),
(7, 20, 96, '2025-11-04'),
(9, 20, 69, '2025-11-05'),
(11, 20, NULL, '2025-11-06');
