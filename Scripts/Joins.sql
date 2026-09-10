--get every student together with their department name using inner join 
select stud_ID,stud_Name,dept_Name
from Students inner join Departments 
on Students.dept_ID=Departments.dept_ID
