drop database test;-- 将原有的数据库删除

-- 第一步：创建数据库
create database test;-- 如果数据库已经存在，这一步可省略 不需要再次创建了

-- 第二步：选择进入数据库
use test;-- 进入数据库之后，才可以在数据库中创建表和导入数据

-- 第三步：创建表
-- 因为两张表中有主外键约束，所以需要先创建主键所在的dept,再创建外键所在的emp
create table dept(
	deptno int primary key,
    dname varchar(15),
    loc varchar(10)
);

create table emp(
    empid int primary key,
    ename varchar(15) unique,
    job varchar(10) not null,
    mgr int,
    hiredate date,
    sal float default 0,
    comm float,
    deptno int,
    foreign key(deptno) references dept(deptno)
);

-- 第四步：添加数据
-- 先有部门，才能存储每个部门的员工信息，所以先添加dept的部门信息，再导入emp的员工信息
insert into dept values 
(10,'accounting','new york'),
(20,'research','dallas'),
(30,'sales','chicago'),
(40,'operations','boston');

select * from dept; -- 检查导入数据内容

-- MySQL8.0版本为了安全起见，默认不允许客户端从本地载入文件，可以将本地文件放在系统文件夹中再导入
-- 路径中不能有中文，‘\’在编程语言中是转义符，需要将‘\’改为‘\\’或‘/’
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee.csv"
into table emp 
fields terminated by ',' 
ignore 1 lines;

select * from emp; -- 检查导入数据内容
