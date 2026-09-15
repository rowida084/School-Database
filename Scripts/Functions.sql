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
