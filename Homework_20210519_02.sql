create database qlsv;

use qlsv; 

create table Marks (
	Mark int,
    SubjectID int,
    StudentID int);

create table Subjects (
	SubjectID int primary key,
    SubjectName varchar(50));

create table Students (
	StudentID int primary key,
    StudentName varchar(50),
    Age int,
    Email varchar(100));
    
alter table Marks 
add constraint FK_SubjectID foreign key (SubjectID) references Subjects(SubjectID),
add constraint FK_StudentID foreign key (StudentID) references Students(StudentID);

create table Classes (
	ClassID int primary key,
    ClassName varchar(50));
    
create table ClassStudent (
	StudentID int, 
    ClassID int,
    foreign key (StudentID) references Students(StudentID),
    foreign key (ClassID) references Classes(ClassID));
    
insert into Students
values (1, 'Nguyen Quang An', 18, 'an@yahoo.com'),
	(2, 'Nguyen Cong Vinh', 20, 'vinh@gmail.com'),
    (3, 'Nguyen Van Quyen', 19, 'quyen'),
    (4, 'Pham Thanh Binh', 25, 'binh@com'),
    (5, 'Nguyen Van Tai Em', 30, 'taiem@sport.vn');
    
insert into Classes 
values (1, 'C0706L'),
	(2, 'C0708G');
    
insert into ClassStudent
values (1,1),
	(2,1),
	(3,2),
	(4,2),
	(5,2);

insert into Subjects
values (1, 'SQL'),
	(2, 'Java'),
    (3, 'C'),
    (4, 'Visual Basic');
    
insert into Marks(SubjectID, StudentID, Mark)
values (1,1,8),
	(2,1,4),
    (1,1,9),
    (1,3,7),
    (1,4,3),
    (2,5,5),
    (3,3,8),
    (3,5,1),
    (2,4,3);
    
use qlsv;

select *
from Students;

select *
from Subjects;

select *
from Students 
where Email like '%_@__%.__%';

select *
from Students
where StudentName like 'Nguyen%';

select StudentName,ClassName
from ClassStudent
join Students on ClassStudent.StudentID = Students.StudentID
join Classes on ClassStudent.ClassID = Classes.ClassID
having ClassName = 'C0706L';

select SubjectName, StudentName , Mark
from Marks
join Students on Marks.StudentID = Students.StudentID
join Subjects on Marks.SubjectID = Subjects.SubjectID
order by SubjectName, StudentName;

select StudentName 
from Students
where StudentID not in (
select StudentID 
from Marks);

select SubjectName
from Subjects
where SubjectID not in (
select SubjectID
from Marks);

select StudentName, avg(Mark)
from Marks
join Students on Marks.StudentID = Students.StudentID
group by StudentName;

select SubjectName, count(*)
from Marks
join Subjects on Marks.SubjectID = Subjects.SubjectID
group by SubjectName
order by count(*) desc;

select SubjectName, max(Mark)
from Marks
join Subjects on Marks.SubjectID = Subjects.SubjectID
group by SubjectName
order by max(Mark) desc;

select SubjectName, count(Mark) as belowAvgCount
from Marks
join Subjects on Marks.SubjectID = Subjects.SubjectID
where Mark < 5
group by SubjectName
order by belowAvgCount desc;

alter table Students
add constraint CHECK_Age check (age between 15 and 50);

alter table ClassStudent
drop foreign key classstudent_ibfk_1,
drop foreign key classstudent_ibfk_2;

alter table Marks
drop foreign key FK_StudentID,
drop foreign key FK_SubjectID;

delete from Students
where StudentID = 1;

alter table Students
add StudentStatus bit default 1;

update Students
set StudentStatus = 0;