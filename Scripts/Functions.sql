--Create fn_CalculateAge(@DateOfBirth DATE) as a Scalar Function.
create function fn_CalculateAge (@DateOfBirth date)
returns int 
as
begin 
declare @age int 
set @age = datediff(year,@DateOfBirth,getdate())
return @age
end 

select dbo.fn_CalculateAge('2000-05-10') as Age
select dbo.fn_CalculateAge('2006-09-9') as Age



--Create fn_GetCoursesByStudent(@StudentId INT) as a Table-Valued Function.

create function fn_GetCoursesByStudent(@StudentID int)
returns table 
as 
return 
(
select * 
from vw_StudentFullReport
where stud_ID=@StudentID
)

select * from fn_GetCoursesByStudent(1)
select course_Name from fn_GetCoursesByStudent(5)



--Create fn_GetTopStudentsByCourse(@CourseId INT, @TopN INT) using a Window Function.
create function fn_GetStudentsByCourse(@CourseID int,@TopN int)
returns table 
as 
return 
(

select * 
from 
( select *, ROW_NUMBER() over (order by Grade desc) as RN
from (
select * 
from vw_StudentFullReport
where course_ID=@CourseID 
) as StudentByCourse
) as topStudents
where RN<= @TopN)


select * from fn_GetStudentsByCourse(3,2)
select * from fn_GetStudentsByCourse(8,3)





