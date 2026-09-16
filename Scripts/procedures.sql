
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


--Create sp_EnrollStudent(@StudentId, @CourseId).
create proc sp_EnrollStudent @studentID int , @CourseID int 
as 
begin 
declare @StudentDeptID int 
set @StudentDeptID = (select dept_ID from Students where stud_ID=@studentID)
declare @CourseDeptID int 
set @CourseDeptID =(select department_ID from Courses where course_ID = @CourseID)
if (@StudentDeptID is null)
begin 
select 'Student Is Not Exist.'
return 
end 
if(@CourseDeptID is null)
begin 
select  'Course Is Not Exist.'
return 
end 
if @CourseDeptID<>@StudentDeptID
begin 
select 'This Student Can not Enroll On This Course.'
return 
end 
if exists
(
select 1 
from Enrollment 
where Student_ID=@studentID and Course_ID=@CourseID
)
begin 
select 'This Student Already Enroll On This Course.'
end 
else
begin 
insert Into Enrollment (Student_ID,Course_ID,Grade,Enrollment_Date)
values(@studentID,@CourseID,null,getdate())
end 
end 

sp_EnrollStudent 1,5--this student enrolled successefully
sp_EnrollStudent 1,3--this student is already enroll on this course
sp_EnrollStudent 1 ,899--course not exist 
sp_EnrollStudent 1111,5--student not exist


