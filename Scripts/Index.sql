

dbcc freeproccache;

dbcc freeproccache;

-- 1. index on enrollment.studentid

set statistics time, io on;
go

select *
from Enrollment
where Student_ID = 5;
--The query already uses the clustered primary key (StudentId, CourseId)
--where StudentId is the leading key column
--so a separate index on StudentId is redundant for this query.
CREATE INDEX IX_Enrollment_StudentId
ON Enrollment(Student_ID);

SELECT *
FROM Enrollment
WHERE Student_ID = 5
  AND Course_ID = 3;


SELECT *
FROM Enrollment
WHERE Student_ID = 5
  AND Course_ID = 3;

  CREATE INDEX IX_Enrollment_StudentID_CourseID
ON Enrollment(Student_ID, Course_ID);
