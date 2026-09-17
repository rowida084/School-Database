# School Database Management System

A relational **School Database Management System** built using **Microsoft SQL Server**.

The project demonstrates database design, relationships, constraints, data manipulation, views, functions, stored procedures, joins, subqueries, window functions, and indexing.

---

## 📌 Project Overview

This project models a school system containing:

* Departments
* Teachers
* Students
* Courses
* Enrollments

The database is designed to represent the relationships between these entities while enforcing data integrity through **Primary Keys, Foreign Keys, Unique Constraints, Check Constraints, and Transactions**.

An **ERD / Database Schema Diagram** was also created to visualize the relationships between the tables.

---

## 🗂️ Database Schema

The database consists of the following main tables:

### 1. Departments

Stores information about school departments.

| Column          | Description                            |
| --------------- | -------------------------------------- |
| `dept_ID`       | Primary Key, Identity                  |
| `dept_Name`     | Unique department name                 |
| `leadTeacherID` | Teacher responsible for the department |

---

### 2. Teachers

Stores teacher information and their department/supervisor relationships.

| Column         | Description           |
| -------------- | --------------------- |
| `tech_ID`      | Primary Key, Identity |
| `tech_Name`    | Teacher name          |
| `dept_ID`      | Teacher's department  |
| `supervise_ID` | Optional supervisor   |

The table also contains a **self-referencing foreign key** to represent the supervisor relationship.

A teacher cannot supervise themselves.

---

### 3. Students

Stores student information.

| Column      | Description           |
| ----------- | --------------------- |
| `stud_ID`   | Primary Key, Identity |
| `stud_Name` | Student name          |
| `dept_ID`   | Student's department  |

Each student belongs to one department.

---

### 4. Courses

Stores courses offered by departments.

| Column          | Description                        |
| --------------- | ---------------------------------- |
| `course_ID`     | Primary Key, Identity              |
| `course_Name`   | Course name                        |
| `course_Code`   | Course code                        |
| `teacher_ID`    | Teacher responsible for the course |
| `department_ID` | Department offering the course     |

---

### 5. Enrollment

Represents the many-to-many relationship between students and courses.

| Column            | Description       |
| ----------------- | ----------------- |
| `Student_ID`      | Student reference |
| `Course_ID`       | Course reference  |
| `Grade`           | Student grade     |
| `Enrollment_Date` | Enrollment date   |

The table uses a composite primary key:

```sql
PRIMARY KEY(Student_ID, Course_ID)
```

This prevents the same student from being enrolled in the same course more than once.

---

## 🔐 Constraints & Data Integrity

The database uses several SQL Server constraints to maintain data integrity.

### Primary Keys

Every main entity has a primary key.

```text
Departments → dept_ID
Teachers → tech_ID
Students → stud_ID
Courses → course_ID
```

`Enrollment` uses a composite primary key:

```text
(Student_ID, Course_ID)
```

### Foreign Keys

Foreign keys enforce relationships between tables.

Examples:

* Teacher → Department
* Student → Department
* Course → Teacher
* Course → Department
* Enrollment → Student
* Enrollment → Course
* Teacher → Supervisor
* Department → Lead Teacher

### Unique Constraint

Department names must be unique.

```sql
dept_Name VARCHAR(50) UNIQUE NOT NULL
```

A composite unique constraint was also added to support the relationship between a department and its lead teacher.

### Check Constraints

The database validates grades:

```sql
CHECK (Grade >= 0 AND Grade <= 100)
```

It also prevents a teacher from supervising themselves:

```sql
CHECK (supervise_ID <> tech_ID)
```

Enrollment dates cannot be in the future.

---

# 🔎 Queries

The project includes several SQL queries demonstrating different database concepts.

## INNER JOIN

Retrieve every student together with their department name.

```sql
SELECT stud_ID, stud_Name, dept_Name
FROM Students
INNER JOIN Departments
    ON Students.dept_ID = Departments.dept_ID;
```

---

## GROUP BY & HAVING

Find teachers who teach more than three courses.

```sql
SELECT tech_Name, COUNT(course_Name) AS course_count
FROM Teachers
INNER JOIN Courses
    ON tech_ID = teacher_ID
GROUP BY tech_Name
HAVING COUNT(course_Name) > 3;
```

---

## EXISTS

Find students who have not received a grade in any enrolled course.

```sql
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
```

---

## SELF JOIN

Find departments whose lead teacher supervises more than five teachers.

The query uses a self join on the `Teachers` table because a teacher can supervise another teacher from the same table.

---

## Window Functions

The project uses `ROW_NUMBER()` to identify the top student in each department based on average grade.

```sql
ROW_NUMBER() OVER
(
    PARTITION BY dept_Name
    ORDER BY average DESC
)
```

This allows the students to be ranked independently inside each department.

---

# 👁️ Views

Several views were created to simplify frequently used queries.

## `vw_DepartmentSummary`

Displays each department with:

* Department ID
* Department name
* Number of students
* Number of teachers

`COUNT(DISTINCT ...)` is used to avoid duplicated counts caused by joining multiple tables.

---

## `vw_TeacherCourseLoad`

Displays each teacher and the number of courses they teach.

```text
Teacher
CourseCount
```

A `LEFT JOIN` is used so that teachers with no courses can also appear in the result.

---

## `vw_StudentFullReport`

Combines:

* Student information
* Enrolled courses
* Grades
* Calculated enrollment status

The status is calculated using `CASE`:

```text
NULL grade → Pending
Grade >= 50 → Passed
Grade < 50 → Failed
```

---

## `vw_DepartmentTopStudent`

Identifies the top student in each department based on average grade.

The view uses:

```sql
ROW_NUMBER()
OVER
(
    PARTITION BY dept_Name
    ORDER BY average DESC
)
```

Then only the first-ranked student from each department is returned.

---

# ⚙️ User-Defined Functions

The project contains both **Scalar-Valued Functions** and **Table-Valued Functions**.

## `fn_CalculateAge`

Calculates age based on the provided date of birth.

```sql
SELECT dbo.fn_CalculateAge('2006-09-09');
```

---

## `fn_GetCoursesByStudent`

A table-valued function that returns the courses and related information for a specific student.

Example:

```sql
SELECT *
FROM fn_GetCoursesByStudent(1);
```

---

## `fn_GetStudentsByCourse`

Returns the top N students in a specific course based on their grades.

It uses `ROW_NUMBER()` to rank students.

Example:

```sql
SELECT *
FROM fn_GetStudentsByCourse(3, 2);
```

---

## `fn_IsPassed`

Determines the student's status based on the grade.

Possible results:

```text
Pending
Passed
Failed
```

Example:

```sql
SELECT dbo.fn_IsPassed(80);
```

---

# 🛠️ Stored Procedures

The project includes stored procedures for common database operations.

## `sp_GetStudentsByDepartment`

Returns students belonging to a specific department.

The procedure also checks whether the department exists before executing the query.

Example:

```sql
EXEC sp_GetStudentsByDepartment 1;
```

---

## `sp_EnrollStudent`

Enrolls a student in a course after validating:

1. Student exists.
2. Course exists.
3. Student and course belong to the same department.
4. Student is not already enrolled in the course.

The procedure prevents invalid enrollments and duplicate enrollment records.

---

## `sp_TransferStudent`

Transfers a student to another department.

Before performing the transfer, the procedure checks:

* Student exists.
* New department exists.
* The student has no enrollment conflict with courses from another department.

The update is performed inside a **Transaction**.

```text
BEGIN TRANSACTION
        ↓
Validate transfer
        ↓
Update student department
        ↓
COMMIT
```

If a problem occurs, the transaction is rolled back.

---

# 📊 Indexing

The project also explores SQL Server indexing and query performance.

## Index on `Enrollment.Student_ID`

An index was created on:

```sql
CREATE INDEX IX_Enrollment_StudentId
ON Enrollment(Student_ID);
```

The project compares this with the existing clustered primary key:

```text
(Student_ID, Course_ID)
```

Because `Student_ID` is already the leading column of the clustered primary key, queries filtering only by `Student_ID` can already benefit from that key.

Therefore, an additional single-column index on `Student_ID` may be redundant depending on the query workload.

---

## Composite Index

A composite index was also created:

```sql
CREATE INDEX IX_Enrollment_StudentID_CourseID
ON Enrollment(Student_ID, Course_ID);
```

This index is useful for queries that filter using both:

```text
Student_ID
Course_ID
```

For example, checking whether a student is already enrolled in a specific course.

---

# 📈 Query Performance

SQL Server performance statistics were examined using:

```sql
SET STATISTICS TIME, IO ON;
```

This allows comparison of:

* CPU time
* Elapsed time
* Logical reads
* Physical reads
* Scan count

Execution plans can also be used to understand how SQL Server accesses the data.

---

# 🧩 SQL Concepts Covered

This project demonstrates the following SQL Server concepts:

* Database Design
* ERD / Schema Design
* Primary Keys
* Foreign Keys
* Composite Primary Keys
* Composite Unique Constraints
* Check Constraints
* Self-Referencing Foreign Keys
* `INNER JOIN`
* `LEFT JOIN`
* `SELF JOIN`
* `GROUP BY`
* `HAVING`
* `EXISTS`
* Subqueries
* Aggregate Functions
* `CASE`
* Views
* Scalar-Valued Functions
* Table-Valued Functions
* Window Functions
* `ROW_NUMBER()`
* Stored Procedures
* Transactions
* `TRY...CATCH`
* Indexes
* Composite Indexes
* Query Performance Analysis
* `STATISTICS IO`
* `STATISTICS TIME`

---

# 📁 Project Structure

A suggested project structure:

```text
SchoolDatabase/
│
├── README.md
│
├── ERD/
│   └── schema.png
│
└── SQL/
    ├── 01_Schema.sql
    ├── 02_Data.sql
    ├── 03_Queries.sql
    ├── 04_Views.sql
    ├── 05_Functions.sql
    ├── 06_StoredProcedures.sql
    └── 07_Indexes.sql
```

The `ERD/schema.png` file contains the database schema and relationships between the main entities.

---

# 🎯 Project Goals

The main goals of this project are to practice designing and implementing a relational database using SQL Server and to apply SQL concepts in a realistic school management scenario.

The project focuses on both **database structure** and **querying/manipulating data**, including validation, reporting, reusable database objects, transactions, and performance considerations.

---

## 🧰 Technologies

* **Microsoft SQL Server**
* **T-SQL**
* **SQL Server Management Studio (SSMS)**

---

## 👩‍💻 Author

**Rowida Hany**

Computer Science Student
Ain Shams University

GitHub: `rowida084`

---

## 📌 Notes

This project was developed as a practical SQL Server database exercise covering database design, querying, programmable database objects, transactions, and indexing.
