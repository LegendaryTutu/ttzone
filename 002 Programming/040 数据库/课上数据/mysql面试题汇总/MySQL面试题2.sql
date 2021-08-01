create database a;
use a;

create table employee(
	empid varchar(10) primary key not null,
    name varchar(10),
    gender varchar(10),
    title varchar(20),
    birthday date,
    depid varchar(10));
    
create table department(
	depid varchar(10) primary key not null,
    depname varchar(20));
    
create table salary(
	empid varchar(10) primary key not null,
    base_salary decimal(8,2),
    title_salary decimal(8,2),
    deduction int);
    
    
 #修改表结构，在部门表中添加一个”部门简介”字段   
alter table employee add 部门简介 varchar(100);


insert into employee values('1001','张三','男','高级工程师','1980-01-01','1111',null);
insert into employee values('1002','李四','女','助理工程师','1980-11-01','1111',null);
insert into employee values('1003','王五','男','工程师','1980-01-21','2222',null);
insert into employee values('1004','赵六','男','工程师','1980-01-11','2222',null);

insert into department(depid,depname) values
('1111','生产部'),
('2222','销售部'),
('3333','人事部');

insert into salary values
('1001',3200,1200,200),
('1002',4200,1100,100),
('1003',5200,2200,200),
('1004',2000,1500,150);


#5将李四的职称改为“工程师”，并将她的基本工资改为5700元，职务工资为1600。
update employee set title="工程师" where name="李四";

update salary set base_salary=5700,title_salary=600 
where empid=(select empid from employee where name="李四");


#6查询出每个雇员的雇员编号，姓名，职称，所在部门，实发工资和应发工资。
#涉及employee表和salary表、department表
select employee.empid,name,title,depname,(base_salary+title_salary-deduction) as 实发工资,
(base_salary+title_salary) as 应发工资 from employee 
left join salary on employee.empid=salary.empid
left join department on department.depid=employee.depid;


#7查询姓“张”且年龄小于40岁的员工的记录。
select * from employee where name like"张%" and (year(curdate())-year(birthday))<40;



#8查询销售部所有雇员的雇员编号，姓名，职称，部门名称，实发工资。
#涉及employee表和salary表、department表
select employee.empid,name,title,depname,
(base_salary+title_salary-deduction) as 实发工资 from employee 
left join salary on employee.empid=salary.empid
left join department on department.depid=employee.depid where depname="销售部";




#9统计出各类职称的人数。
#按职称分组
select title,count(*)as 人数 from employee group by title;




#10.统计各部门的部门名称，实发工资总和，平均工资。
#涉及三张表及group by分组
select depname,sum(base_salary+title_salary-deduction)as 实发工资,
avg(base_salary+title_salary-deduction) as 平均工资  from employee 
left join salary on employee.empid=salary.empid
left join department on department.depid=employee.depid group by depname;



select * from employee;
select * from salary;
select * from department;














