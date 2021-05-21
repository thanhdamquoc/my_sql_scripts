create database homework_20210521_01;
use homework_20210521_01;

create table class (
	ClassID int not null primary key auto_increment,
    ClassName varchar(255) not null,
    StartDate datetime not null,
    Status bit);
    
create table Student (
	StudentID int not null primary key,
    StudentName varchar(30) not null,
    Address varchar(50),
    Phone varchar(20),
    Status bit,
    ClassID int not null);
    
create table Subject (
	SubID int not null primary key auto_increment,
    SubName varchar(30) not null,
    Credit tinyint not null default 1 check (Credit >= 1),
    Status bit);
    
create table Mark (
	MarkID int not null primary key auto_increment,
    SubID int not null,
    StudentID int not null,
    Mark float default 0 check (mark between 0 and 100),
    ExamTimes tinyint default 1);
    
alter table Student 
add foreign key (ClassID) references Class(ClassID);

alter table Student
alter Status
set default 1;

alter table Mark
add foreign key (SubID) references Subject(SubID),
add foreign key (StudentID) references Student(StudentID);

insert into Class(ClassName,StartDate,Status)
values ('A1', '2008-12-20', 1),
	('A2', '2008-12-22', 1),
    ('B3', curdate(), 0);
    
insert into Student
values (1, 'Hung', 'Hanoi', '0912113113', 1, 1),
	(2, 'Hoa', 'Hai phong ', null, 1, 1),
    (3, 'Manh', 'HCM', '0123123123', 0, 2);
    
insert into Subject(SubName, Credit, Status)
values ('CF', 5, 1),
	('C', 6, 1),
    ('HDJ', 5, 1),
    ('RDBMS', 10, 1);
    
insert into Mark(SubID, StudentID, Mark, ExamTimes)
values (1,1,8,1),
	(1,2,10,2),
	(2,1,12,1);
    
alter table mark
add index SubStudent_Index (SubId,StudentID);

update Student
set ClassID = 2
where StudentName = 'Hung';

update Student
set Phone = 'No phone'
where Phone is null;

update Class
set ClassName = concat('Old ', substr(ClassName,5,2))
where Status = 1 and substr(className,1,3) = 'New';


update Subject
set Status = 0
where SubID not in (
select SubID
from Mark);

select *
from Student
where StudentName like 'H%';

select *
from Class
where month(StartDate) = 12;

select *
from Subject
where Credit = (
select Max(Credit)
from Subject);

select *
from Subject
where Credit between 3 and 5;

select StudentName, Address, Student.ClassID, ClassName
from Student
join Class on Student.ClassID = Class.ClassID;

select * from subject
where SubID not in (select SubID from Mark);

select * from mark 
where mark = (select max(mark) from mark);

select StudentName, avg(mark) as AverageMark
from mark
join student on mark.StudentID = Student.StudentID
group by StudentName
having AverageMark >= 10
order by AverageMark;

select StudentName, SubName, Mark
from Mark
join Student on Mark.StudentID = Student.StudentID
join Subject on Mark.SubID = Subject.SubID
order by Mark DESC, StudentName ASC;

delete from Class
where Status = 0;

delete from Subject
where SubID not in (select SubID from Mark);

alter table Mark
drop column ExamTimes;

alter table Class
rename column Status to ClassStatus;

alter table Mark
rename to SubjectTest;

drop database homework_20210521_01;
