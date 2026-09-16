
--Create sp_GetStudentsByDepartment(@DepartmentId).

create proc sp_GetStudentsByDepartment @DepartmentID int 
as 
begin try 
if exists(select 1 from Departments where dept_ID =@DepartmentID)
begin
select s.stud_Name
from Students s inner join Departments d
on s.dept_ID=d.dept_ID
where d.dept_ID=@DepartmentID
end 
else 
begin 
select 'This Department ID Is Not Exist!' as Message
end 
end try
begin catch 
select ERROR_MESSAGE () as errorMessage
end catch

sp_GetStudentByDepartment 1
sp_GetStudentByDepartment 6 --this department id is not exist in my database 


