--get every student together with their department name using inner join 
select stud_ID,stud_Name,dept_Name
from Students inner join Departments 
on Students.dept_ID=Departments.dept_ID


--Get every Teacher who teaches more than 3 Courses using JOIN, GROUP BY, and HAVING 
select tech_Name ,count(course_Name) as course_count
from Teachers inner join Courses
on tech_ID=teacher_ID
group by tech_Name 
having count(course_Name)>3


--Get every Student who has not received a Grade in any enrolled Course without using NOT IN.
select distinct stud_Name
from Students inner join  Enrollment
on Enrollment.Student_ID=Students.stud_ID
where not  exists 
(
select 1
from Enrollment 
where Enrollment.Student_ID=Students.stud_ID
and Grade is not null
)


--Get every Department whose Lead Teacher supervises more than 5 Teachers using a Self JOIN and aggregation.  The result is "Computer Sceince"
select dept_Name
from Departments D inner join Teachers leadTeacher
on D.dept_ID = leadTeacher.dept_ID
inner join Teachers supervisedTeacher
on leadTeacher.tech_ID=supervisedTeacher.supervise_ID
group by dept_Name 
having count(supervisedTeacher.tech_ID)>5

