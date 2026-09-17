School  Database

A SQL Server database project designed to manage an academic environment, including departments, teachers, students, courses, enrollments, and grades.

The project focuses on practicing relational database design and advanced SQL concepts such as constraints, joins, aggregation, views, functions, stored procedures, indexing, and query performance analysis.

---

📌 Project Overview

The database models the relationships between academic departments, teachers, students, and courses.

It supports operations such as:

- Managing departments and their lead teachers
- Managing teachers and supervisor relationships
- Managing students and their departments
- Managing courses and assigned teachers
- Enrolling students in courses
- Recording and validating grades
- Generating academic reports
- Retrieving top-performing students
- Transferring students between departments
- Analyzing query performance and indexing

---

🗂️ Database Structure

The database consists of the following main tables:

Table| Description
"Departments"| Stores departments and their lead teachers
"Teachers"| Stores teachers, departments, and supervisor relationships
"Students"| Stores students and their departments
"Courses"| Stores courses, course codes, teachers, and departments
"Enrollment"| Connects students with courses and stores grades and enrollment dates

🔗 Main Relationships

Departments
    │
    ├── Students
    │
    ├── Courses
    │
    └── Teachers
          │
          └── Supervisor → Teacher

Students
    │
    └── Enrollment ─── Courses

The "Enrollment" table represents the many-to-many relationship between students and courses.

---

🛡️ Data Integrity & Constraints

The project uses SQL Server constraints to maintain data integrity.

Primary Keys

Each main entity has its own primary key:

- "Departments.dept_ID"
- "Teachers.tech_ID"
- "Students.stud_ID"
- "Courses.course_ID"

"Enrollment" uses a composite primary key:

PRIMARY KEY (Student_ID, Course_ID)

This prevents the same student from being enrolled in the same course more than once.

Foreign Keys

Foreign keys are used to enforce relationships between entities, including:

- Teacher → Department
- Teacher → Supervisor
- Student → Department
- Course → Teacher
- Course → Department
- Enrollment → Student
- Enrollment → Course

Check Constraints

Examples include:

CHECK (Grade >= 0 AND Grade <= 100)

and:

CHECK (supervise_ID <> tech_ID)

to prevent invalid supervisor relationships.

---

🔍 SQL Queries

The project includes queries demonstrating different SQL concepts.

INNER JOIN

Retrieve students together with their departments:

SELECT stud_ID, stud_Name, dept_Name
FROM Students
INNER JOIN Departments
    ON Students.dept_ID = Departments.dept_ID;

GROUP BY & HAVING

Find teachers who teach more than three courses:

SELECT tech_Name, COUNT(course_Name) AS course_count
FROM Teachers
INNER JOIN Courses
    ON tech_ID = teacher_ID
GROUP BY tech_Name
HAVING COUNT(course_Name) > 3;

EXISTS

Find students who have not received a grade in any enrolled course:

SELECT DISTINCT stud_Name
FROM Students
INNER JOIN Enrollment
    ON Enrollment.Student_ID = Students.stud_ID
WHERE NOT EXISTS
(
    SELECT 1
    FROM Enrollment
    WHERE Enrollment.Student_ID = Students.stud_ID
      AND Grade IS NOT NULL
);

Self JOIN

Identify departments whose lead teacher supervises more than five teachers.

Aggregation

Retrieve departments offering more than five courses using:

- "JOIN"
- "GROUP BY"
- "HAVING"

---

👁️ Views

The project includes reusable database views for reporting and data retrieval.

"vw_DepartmentSummary"

Provides:

- Department ID
- Department name
- Number of students
- Number of teachers

"vw_TeacherCourseLoad"

Shows each teacher and the number of courses they teach.

"vw_StudentFullReport"

Combines:

- Student information
- Enrolled courses
- Grades
- Computed academic status

Example statuses:

Pending
Passed
Failed

"vw_DepartmentTopStudent"

Uses a window function to identify the top student in each department based on average grade.

---

⚙️ User-Defined Functions

The project includes both Scalar-Valued Functions and Table-Valued Functions.

"fn_CalculateAge"

Calculates a person's age based on their date of birth.

SELECT dbo.fn_CalculateAge('2000-05-10');

"fn_IsPassed"

Determines the status of a grade:

Passed
Failed
Pending

"fn_GetCoursesByStudent"

A table-valued function used to retrieve courses associated with a specific student.

SELECT *
FROM fn_GetCoursesByStudent(1);

"fn_GetStudentsByCourse"

Returns the top students in a specific course using "ROW_NUMBER()".

SELECT *
FROM fn_GetStudentsByCourse(3, 2);

---

🧩 Stored Procedures

The project contains stored procedures for common academic operations.

"sp_GetStudentsByDepartment"

Retrieves students belonging to a specific department and handles invalid department IDs.

EXEC sp_GetStudentsByDepartment 1;

"sp_EnrollStudent"

Handles student enrollment while validating:

- Student existence
- Course existence
- Department compatibility
- Duplicate enrollment

Example:

EXEC sp_EnrollStudent 1, 5;

"sp_TransferStudent"

Transfers a student to another department while checking:

- Student existence
- Target department existence
- Existing enrollment conflicts
- Transaction success/failure

The procedure uses a transaction to maintain data consistency.

---

📊 Window Functions

Window functions were used for ranking and analytical queries.

Example:

ROW_NUMBER() OVER
(
    ORDER BY Grade DESC
)

and:

ROW_NUMBER() OVER
(
    PARTITION BY dept_Name
    ORDER BY average DESC
)

These were used to retrieve top-performing students while keeping the query within a relational SQL approach.

---

🚀 Indexing & Query Performance

The project also includes practical experimentation with query performance and indexing.

Existing Clustered Primary Key

The "Enrollment" table has a composite primary key:

PRIMARY KEY (Student_ID, Course_ID)

Since "Student_ID" is the leading column, queries filtering by "Student_ID" can already benefit from the clustered index.

A separate index was also tested:

CREATE INDEX IX_Enrollment_StudentId
ON Enrollment(Student_ID);

The execution behavior was then investigated using SQL Server performance statistics.

Composite Index

A composite index was also created for queries filtering by both student and course:

CREATE INDEX IX_Enrollment_StudentID_CourseID
ON Enrollment(Student_ID, Course_ID);

Performance was analyzed using:

SET STATISTICS TIME, IO ON;

This helped compare query behavior and understand how indexes can affect database access patterns.

---

🧪 Sample Data

The database includes sample data for:

- Computer Science
- Mathematics
- Physics

along with:

- Teachers and supervisor relationships
- Students
- Courses
- Course enrollments
- Grades
- Enrollment dates

This sample data was designed to test different queries, views, functions, and stored procedures.

---

🛠️ Technologies & Concepts

Database

- Microsoft SQL Server
- T-SQL

SQL Concepts

- Relational Database Design
- Primary & Foreign Keys
- Composite Keys
- Unique Constraints
- Check Constraints
- Cascading Deletes
- Self Relationships
- INNER JOIN
- SELF JOIN
- GROUP BY
- HAVING
- EXISTS
- Aggregate Functions
- Window Functions
- Views
- Scalar Functions
- Table-Valued Functions
- Stored Procedures
- Transactions
- Indexes
- Query Performance Analysis
- Execution Plans
- "STATISTICS IO"
- "STATISTICS TIME"

---

🎯 Learning Outcomes

Through this project, I practiced moving beyond basic SQL queries toward building and working with a more complete relational database system.

Key areas I strengthened:

- Designing related database tables
- Enforcing data integrity
- Writing complex SQL queries
- Creating reusable views and functions
- Building stored procedures with validation
- Handling transactions and business rules
- Using window functions for analytical queries
- Understanding indexes and their impact on query performance
- Reading and analyzing query execution behavior

---

📁 Project Structure

A possible repository structure:

Academic-Management-Database/
│
├── Database/
│   ├── 01_CreateTables.sql
│   ├── 02_Constraints.sql
│   ├── 03_InsertData.sql
│   ├── 04_Queries.sql
│   ├── 05_Views.sql
│   ├── 06_Functions.sql
│   ├── 07_StoredProcedures.sql
│   └── 08_Indexing_Performance.sql
│
└── README.md

---

👩‍💻 Author

Rowida Hany

Computer & Information Science Student
Aspiring Full Stack .NET Developer

Focused on building strong foundations in:

"C#" • ".NET" • "SQL Server" • "Database Design"
