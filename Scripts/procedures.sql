
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


  --Create sp_TransferStudent(@StudentId, @NewDepartmentId).
create proc sp_TransferStudent @StudentID int , @NewDepartment_ID int 
as 
begin 
if not  exists
(
select 1 from Students where stud_ID=@StudentID
)

begin 
select 'Student is not exist.'
return
end 
if not exists 
(
select 1 from Departments where dept_ID=@NewDepartment_ID
)
begin 
select 'Department is not exist.'
return
end 
begin try 
begin Transaction 
if exists 
(
select 1 
from Enrollment e inner join Courses c
on e.Course_ID= c.course_ID
where e.Student_ID = @StudentID and 
c.department_ID <> @NewDepartment_ID
)
begin 
rollback
select 'Transfer cannot be completed because of Enrollment conflict.'
return 
end
update Students
set dept_ID =@NewDepartment_ID
where stud_ID=@StudentID
commit 
 SELECT 'Student transferred successfully.'
end try
begin catch 
if @@TRANCOUNT>0
rollback
end catch
end 

sp_TransferStudent 1,2--conflict
insert into Students (stud_Name,dept_ID)
values ('Rowida Hany',3)--new student in  department 3 with id 14
sp_TransferStudent 14,2 --transfer done successfully
sp_TransferStudent 14,5--this department is not exist in my database
sp_TransferStudent 15,2 --this student is not exist 
