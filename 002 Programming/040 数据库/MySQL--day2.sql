-- 查看系统中有哪些数据库
show databases;


-- 创建test数据库
create database test;


-- 选择进入数据库
use test;


-- 删除数据库(慎用)
drop database test;


-- 创建数据表
create table department(
deptno int,
dname varchar(10),
num int
);


-- 查看当前数据库中有哪些表
show tables;


-- 查看表结构
desc department;


-- 删除数据表(慎用)
-- drop table department;


-- 创建带有约束条件的表(因为两张表中有主外键约束,所以需要先创建主键所在的dept,再创建外键所在的emp)
create table dept(
deptno int primary key,
dname varchar(10),
loc varchar(15)
);

create table employee(
empid int primary key auto_increment,
ename varchar(10) unique,
job varchar(10) not null default "未知",
mgr int,
hiredate date,
sal float default 0,
comm float,
deptno int,
foreign key(deptno) references dept(deptno)
);

desc employee;

-- 修改表名
alter table employee rename emp;

-- 修改字段名
alter table emp change empid empno int;

-- 修改字段类型
alter table emp modify sal decimal default 0;

-- 添加字段
alter table emp add city varchar(20);

-- 修改字段的排列位置：
alter table emp modify city varchar(20) first;

alter table emp modify city varchar(20) after job;
-- 删除字段
alter table emp drop city;

desc emp;

-- 插入数据：字段名与字段值的数据类型、个数、顺序必须一一对应
insert into dept(deptno,dname,loc) values (10,'accounting','new york'),
										  (20,'research','dallas');

insert into dept values (30,'sales','chicago'),
						(40,'operations','boston');

select * from dept;-- 查看表中的数据
select * from emp;
-- 批量导入数据(路径中不能有中文，‘\’在编程语言中是转义符，需要将‘\\’改为‘’或‘/’)
-- 先有部门，才能存储每个部门的员工信息，所以先添加dept的部门信息，再导入emp的员工信息
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee.csv"
into table emp 
fields terminated by ',' 
ignore 1 lines;

select * from emp; -- 检查导入数据内容
select count(*) from emp; -- 检查导入数据总行数

-- 更新数据
set sql_safe_updates=0; -- 设置数据库安全权限
update emp set sal=sal+1000 where ename='smith';

update emp set sal=sal+1000;
-- 删除数据
delete from emp where deptno=20;

delete from emp;
-- 清空数据
truncate emp;

-- 单表查询(虚拟结果集)
use test;

select * from emp;
-- 查询指定列：查询emp表中ename,job,sal
select ename,job,sal from emp;

-- 设置别名：查询每位员工调整后的薪资(基本工资+1000)
select *,sal+1000 from emp;

select *,sal+1000 as 调薪 from emp;
select *,sal+1000 调薪 from emp;-- as关键字可以省略

-- 练习：查询每位员工的年薪(基本工资*12):empno,ename,年薪
select empno,ename,sal*12 as 年薪 from emp;

-- 查询不重复的数据：查询emp表中有哪些部门
select distinct deptno from emp;

select distinct deptno,job from emp;-- distinct多字段去重时位于第一个字段的前面

-- 条件查询
-- 查询基本工资大于等于2000小于等于3000的员工信息
select * 
from emp 
where sal>=2000 and sal<=3000;

select * 
from emp 
where sal between 2000 and 3000;

-- 查询10号部门和20号部门中sal低于2000的员工信息
select *
from emp
where (deptno=10 or deptno=20) and sal<2000;

select *
from emp
where deptno in (10,20) and sal<2000;
-- 练习：查询salesman的所属部门：姓名,职位,所在部门
select ename,job,deptno 
from emp
where job='salesman';

-- 空值查询
-- 查询mgr为空的记录
select * 
from emp
where mgr is null;

-- 练习：查询comm不为空的记录
select *
from emp
where comm is not null;

-- 模糊查询
-- 查询姓名以a开头的员工信息
select *
from emp
where ename like 'a%';

-- 查询姓名中包含a的员工信息
select *
from emp
where ename like '%a%';

-- 查询姓名中第二个字符为a的员工信息
select *
from emp
where ename like '_a%';

-- 练习：查询员工姓名中不包含s的员工信息
select *
from emp
where ename not like '%s%';

-- 查询结果排序
-- 单字段排序：查询所有员工信息按sal降序显示
select *
from emp
order by sal desc;

-- 多字段排序：查询所有员工信息按deptno升序、sal降序显示
select *
from emp
order by deptno asc,sal desc;

-- 限制查询结果数量
-- 查询基本工资最高的前5位员工
select *
from emp
order by sal desc
limit 5;

select *
from emp
order by sal desc
limit 0,5;

-- 查询基本工资第6到10名的员工
select *
from emp
order by sal desc
limit 5,5;

-- 查询基本工资第11到15名的员工
select *
from emp
order by sal desc
limit 10,5;

-- 练习：查询最后入职的5位员工
select *
from emp
order by hiredate desc
limit 5;

-- 聚合运算
-- 查询emp表中员工总数、最高工资、最低工资、平均工资及工资总和
select count(*) 员工总数,max(sal) 最高工资,min(sal) 最低工资,avg(sal) 平均工资,sum(sal) 工资总和
from emp;

select count(empno) 员工总数,max(sal) 最高工资,min(sal) 最低工资,avg(sal) 平均工资,sum(sal) 工资总和
from emp;

-- 分组查询
-- 查询各部门的平均工资
select deptno,ename,avg(sal)
from emp
group by deptno;

-- 查询各部门不同职位的平均工资
select deptno,job,avg(sal)
from emp
group by deptno,job;

-- 练习：查询各部门的员工数
select deptno,count(*)
from emp
group by deptno;

-- 练习：查询各部门不同职位的人数
select deptno,job,count(*)
from emp
group by deptno,job;

-- 分组后筛选
-- 查询各部门clerk的平均工资
select deptno,job,avg(sal) 
from emp
group by deptno,job
having job='clerk';

select deptno,job,avg(sal)
from emp
where job='clerk'
group by deptno;

-- 查询平均工资大于2000的部门
select deptno,avg(sal)
from emp
group by deptno
where avg(sal)>2000;-- 报错：where子句位于from后面

select deptno,avg(sal)
from emp
where avg(sal)>2000 -- 报错：where子句中不能使用聚合函数
group by deptno;

select deptno,avg(sal)
from emp
group by deptno
having avg(sal)>2000;

select deptno,avg(sal) 平均工资
from emp
group by deptno
having 平均工资>2000;

-- 多表连接查询
create table t1(key1 char,v1 int);

create table t2(key2 char,v2 int);

insert into t1 values('a',1),('a',2),('b',3),('c',4),('a',13);
                        
insert into t2 values('b',10),('b',11),('a',12),('a',13),('e',14);
                         
select * from t1;
select * from t2;

-- 内连接
select * from t1 inner join t2 on t1.key1=t2.key2;

select * from t1 join t2 on t1.key1=t2.key2;
-- 左连接
select * from t1 left join t2 on t1.key1=t2.key2;

-- 右连接
select * from t1 right join t2 on t1.key1=t2.key2;

select * from t2 left join t1 on t1.key1=t2.key2;
-- 合并查询
-- union去重
select * from t1
union 
select * from t2;

-- union all不去重
select * from t1
union all 
select * from t2;

-- 多表查询练习
create table salgrade(grade int,losal int,hisal int);

insert into salgrade values (1,700,1200),(2,1201,1400),(3,1401,2000),(4,2001,3000),(5,3001,9999);

select * from salgrade;-- 5
select * from emp;-- 14
select * from dept;-- 4

-- 查询每位员工的ename,dname,sal
select ename,dname,sal
from emp left join dept on emp.deptno=dept.deptno;

-- 查询各地区的员工数
select loc,count(empno) 员工数
from dept left join emp on emp.deptno=dept.deptno
group by loc;

-- 查询manager的姓名、所属部门名称和入职日期：ename,dname,job,hiredate(内连接/笛卡尔积连接)
select ename,dname,job,hiredate
from emp inner join dept on emp.deptno=dept.deptno
where job='manager';

select ename,dname,job,hiredate
from emp,dept
where emp.deptno=dept.deptno and job='manager';

-- 查询每位员工的工资等级；empno,ename,sal,grade(不等值连接)
select empno,ename,sal,grade
from emp left join salgrade on sal between losal and hisal;

-- 查询每个工资等级的员工数
select grade,count(empno) 员工数
from salgrade left join emp on sal between losal and hisal
group by grade;


-- 查询所有员工姓名及其直属领导姓名（自连接：通过别名，将同一张表视为多张表）



-- 查询入职日期早于其直属领导的员工：empno,ename,dname 



-- 子查询
-- 标量子查询：
-- 查询基本工资高于公司平均工资的员工信息



-- 练习：查询和allen同一个领导的员工：empno,ename,job,mgr



-- 行子查询
-- 查询和smith同部门同职位的员工：empno,ename,job,deptno



-- 列子查询：
-- 查询普通员工的工资等级：empno,ename,sal,grade



-- 练习：查询员工数不少于5人的部门的所有员工：empno,ename,deptno



-- 查询基本工资高于30号部门任意员工的员工信息



-- 查询基本工资高于30号部门所有员工的员工信息



-- from子查询
-- 查询各部门最高工资的员工：empno,ename,sal,deptno



-- 常用函数
-- 字符串函数
-- 练习：将每位员工的姓名首字母转换为大写



-- 日期函数
-- 练习：查询每位员工的工龄：ename,hiredate,工龄



-- 分组合并函数
-- 练习：查询各部门的员工姓名



-- 逻辑函数
-- if函数：查询每位员工的工资级别：3000及以上为高，1500-3000为中，1500及以下为低



-- 逻辑表达式 case when ...then... else ... end



-- 开窗函数
-- 聚合函数用于开窗函数



-- 序号函数









