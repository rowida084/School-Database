
CREATE TABLE Departments 
(
    dept_ID INT PRIMARY KEY IDENTITY,
    dept_Name VARCHAR(50) UNIQUE NOT NULL,
    leadTeacherID INT NOT NULL
);


CREATE TABLE Teachers
(
    tech_ID INT PRIMARY KEY IDENTITY,
    tech_Name VARCHAR(200) NOT NULL,
    dept_ID INT NOT NULL,
    supervise_ID INT NULL,

    CONSTRAINT FK_Teacher_Department
        FOREIGN KEY (dept_ID)
        REFERENCES Departments(dept_ID), 

    CONSTRAINT FK_Teacher_Supervisor
        FOREIGN KEY (supervise_ID)
        REFERENCES Teachers(tech_ID),

    CONSTRAINT CK_Teacher_NotSupervisor
        CHECK (supervise_ID <> tech_ID)
);


ALTER TABLE Departments 
ADD CONSTRAINT FK_Department_LeadTeacher
FOREIGN KEY (leadTeacherID)
REFERENCES Teachers(tech_ID);


CREATE TABLE Students 
(
    stud_ID INT PRIMARY KEY IDENTITY,
    stud_Name VARCHAR(100) NOT NULL,

    dept_ID INT NOT NULL,

    CONSTRAINT FK_Student_Department
        FOREIGN KEY (dept_ID)
        REFERENCES Departments(dept_ID)
		ON DELETE CASCADE
);


CREATE TABLE Courses 
(
    course_ID INT PRIMARY KEY IDENTITY,
    course_Name VARCHAR(100) NOT NULL,
    course_Code VARCHAR(100) NOT NULL,

    teacher_ID INT NOT NULL,
    department_ID INT NOT NULL,

    CONSTRAINT FK_Course_Teacher
        FOREIGN KEY (teacher_ID)
        REFERENCES Teachers(tech_ID),

    CONSTRAINT FK_Course_Department
        FOREIGN KEY (department_ID)
        REFERENCES Departments(dept_ID)
        ON DELETE CASCADE 
);


CREATE TABLE Enrollment
(
    enrollment_ID INT PRIMARY KEY IDENTITY,
    grade INT NULL,
    enrollment_Date DATETIME,

    student_ID INT NOT NULL,
    course_ID INT NOT NULL,

    CONSTRAINT FK_Enrollment_Student
        FOREIGN KEY (student_ID)
        REFERENCES Students(stud_ID),

    CONSTRAINT FK_Enrollment_Course
        FOREIGN KEY (course_ID)
        REFERENCES Courses(course_ID)
        ON DELETE CASCADE,

    CONSTRAINT CK_Grade
        CHECK (grade >= 0 AND grade <= 100),

    CONSTRAINT CK_Enrollment_Date
        CHECK (enrollment_Date <= GETDATE())
);

ALTER TABLE Teachers 
ADD CONSTRAINT uq_teacher_dept	
UNIQUE (dept_ID,tech_ID)

ALTER TABLE Departments
DROP CONSTRAINT FK_Department_LeadTeacher

ALTER TABLE Departments 
ADD CONSTRAINT FK_Department_LeadTeacher
FOREIGN KEY (dept_ID,leadTeacherID)
REFERENCES Teachers(dept_ID,tech_ID)
