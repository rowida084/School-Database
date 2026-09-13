
--Create vw_DepartmentSummary showing each Department with Student Count and Teacher Count.
create view vw_DepartmentSummary 
as select d.dept_ID,d.dept_Name ,
count(distinct stud_ID) as StudentCount ,
count (distinct tech_ID) as TeacherCount 
from Students s inner join Departments d 
on s.dept_ID=d.dept_ID
inner join Teachers t 
on t.dept_ID=d.dept_ID
group by d.dept_ID,d.dept_Name

select * from vw_DepartmentSummary


--Create vw_TeacherCourseLoad showing each Teacher and the number of Courses they teach.
create view vw_TeacherCourseLoad
as select tech_ID,tech_Name , count(course_ID) as CourseCount
from Teachers  t left join Courses c
on t.tech_ID=c.teacher_ID
group by tech_ID,tech_Name

select * from vw_TeacherCourseLoad

