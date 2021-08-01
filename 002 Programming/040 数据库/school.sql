-- 创建数据库school
create database school;

-- 选择进入school数据库
use school;


-- ------------建表导数-------------
-- 创建stu
create table stu(
s_id varchar(10) primary key,
s_name varchar(10) not null,
s_birth date,
s_sex varchar(10));

-- 导入数据
insert into stu values
('01' , '赵雷' , '1990-01-01' , '男'),
('02' , '钱电' , '1990-12-21' , '男'),
('03' , '孙风' , '1990-05-20' , '男'),
('04' , '李云' , '1990-08-06' , '男'),
('05' , '周梅' , '1991-12-01' , '女'),
('06' , '吴兰' , '1992-03-01' , '女'),
('07' , '郑竹' , '1992-04-21' , '女'),
('08' , '王菊' , '1990-01-20' , '女');

select * from stu; -- 检查数据
select count(*) from stu; -- 检查总行数8


-- 创建co
create table co(
c_id varchar(10) primary key,
c_name varchar(10),
t_id varchar(10));

-- 导入数据
insert into co values
('01' , '语文' , '02'),
('02' , '数学' , '01'),
('03' , '英语' , '03');

select * from co; -- 检查数据
select count(*) from co; -- 检查总行数3


-- 创建te
create table te(
t_id varchar(10) primary key,
t_name varchar(10));

-- 导入数据
insert into te values
('01' , '张三'),
('02' , '李四'),
('03' , '王五');

select * from te; -- 检查数据
select count(*) from te; -- 检查总行数3


-- 创建sc
create table sc(
s_id varchar(10),
c_id varchar(10),
score int);

-- 导入数据
insert into sc values
('01' , '01' , 80),
('01' , '02' , 90),
('01' , '03' , 99),
('02' , '01' , 70),
('02' , '02' , 60),
('02' , '03' , 80),
('03' , '01' , 80),
('03' , '02' , 80),
('03' , '03' , 80),
('04' , '01' , 50),
('04' , '02' , 30),
('04' , '03' , 20),
('05' , '01' , 76),
('05' , '02' , 87),
('06' , '01' , 31),
('06' , '03' , 34),
('07' , '02' , 89),
('07' , '03' , 98);

select * from sc; -- 检查数据
select count(*) from sc; -- 检查总行数18


-- ----------------------------------------------------------------------------------
-- 1、查询"01"课程比"02"课程成绩高的学生信息及课程分数(选修的每一门课程的分数)
#查询"01"课程的成绩
select * from sc where c_id='01';

#查询"02"课程的成绩
select * from sc where c_id='02';

select stu.*,sc.c_id,sc.score
from (select * from sc where c_id='01') t1
join (select * from sc where c_id='02') t2 on t1.s_id=t2.s_id
join stu on t1.s_id=stu.s_id
join sc on stu.s_id=sc.s_id
where t1.score>t2.score;
-- ----------------------------------------------------------------------------------
-- 2、练习：查询"01"课程比"02"课程成绩低的学生的信息及课程分数
select stu.*,sc.c_id,sc.score
from (select * from sc where c_id='01') t1
join (select * from sc where c_id='02') t2 on t1.s_id=t2.s_id
join stu on t1.s_id=stu.s_id
join sc on stu.s_id=sc.s_id
where t1.score<t2.score;
-- ----------------------------------------------------------------------------------
-- 3、查询平均成绩大于等于60分的同学的学生编号、学生姓名和平均成绩
select stu.s_id,s_name,avg(score) 平均成绩
from stu left join sc on stu.s_id=sc.s_id
group by stu.s_id
having avg(score)>=60;
-- ----------------------------------------------------------------------------------
-- 4、练习：查询平均成绩小于60分的同学的学生编号、学生姓名和平均成绩
select stu.s_id,s_name,avg(score) 平均成绩
from stu left join sc on stu.s_id=sc.s_id
group by stu.s_id
having avg(score)<60;
-- ----------------------------------------------------------------------------------
-- 6、查询"李"姓老师的数量
select count(t_id)
from te 
where t_name like '李%';
-- ----------------------------------------------------------------------------------
-- 29、练习：查询名字中含有"风"字的学生信息
select * 
from stu
where s_name like '%风%';
-- ----------------------------------------------------------------------------------
-- 7、查询学过"张三"老师授课的同学的信息
#查询学过"张三"老师授课的同学
select s_id 
from sc 
left join co on sc.c_id=co.c_id 
left join te on co.t_id=te.t_id 
where t_name='张三';

select * 
from stu
where s_id in(select s_id 
				from sc 
				left join co on sc.c_id=co.c_id 
				left join te on co.t_id=te.t_id 
				where t_name='张三');
                
select stu.*
from stu
left join sc on stu.s_id=sc.s_id
left join co on sc.c_id=co.c_id
left join te on te.t_id=co.t_id
where t_name='张三';
-- ----------------------------------------------------------------------------------
-- 40、查询选修"张三"老师所授课程的学生中，成绩最高的学生信息及其成绩
select stu.*,score
from stu
left join sc on stu.s_id=sc.s_id
left join co on sc.c_id=co.c_id
left join te on te.t_id=co.t_id
where t_name='张三' and score=(select max(score)
								from stu
								left join sc on stu.s_id=sc.s_id
								left join co on sc.c_id=co.c_id
								left join te on te.t_id=co.t_id
								where t_name='张三');
-- ----------------------------------------------------------------------------------
-- 8、练习：查询没学过"张三"老师授课的同学的信息
select * 
from stu
where s_id not in(select s_id 
					from sc 
					left join co on sc.c_id=co.c_id 
					left join te on co.t_id=te.t_id 
					where t_name='张三');


-- ----------------------------------------------------------------------------------
-- 9、查询学过编号为"01"并且也学过编号为"02"的课程的同学的信息
#每个学生选修了哪些课程
select stu.*,group_concat(c_id order by c_id) 
from stu left join sc on stu.s_id=sc.s_id
group by stu.s_id
having group_concat(c_id order by c_id) like '01,02%';
-- ----------------------------------------------------------------------------------
-- 10、练习：查询学过编号为"01"但是没有学过编号为"02"的课程的同学的信息
select stu.*
from stu left join sc on stu.s_id=sc.s_id
group by stu.s_id
having group_concat(c_id order by c_id) like '%01%' and group_concat(c_id order by c_id) not like '%02%';

select * 
from stu 
where s_id in(select s_id from sc  where c_id='01') and s_id not in (select s_id from sc  where c_id='02');

select stu.*
from stu left join sc on stu.s_id=sc.s_id
where c_id in ('01','02')
group by stu.s_id
having group_concat(c_id)='01';

select stu.*
from stu left join sc on stu.s_id=sc.s_id
where c_id='01'and stu.s_id not in (select s_id from sc where c_id='02');
-- ----------------------------------------------------------------------------------
-- 45、查询选修了全部课程的学生信息
select *
from stu
where s_id in (select s_id 
				from sc 
				group by s_id 
				having count(c_id)=(select count(c_id) from co));

select stu.*
from stu left join sc on stu.s_id=sc.s_id
group by stu.s_id
having count(c_id)=(select count(c_id) from co);
-- ----------------------------------------------------------------------------------
-- 11、练习：查询没有学全所有课程的同学的信息
select *
from stu
where s_id not in (select s_id 
					from sc 
					group by s_id 
					having count(c_id)=(select count(c_id) from co));

select stu.*
from stu left join sc on stu.s_id=sc.s_id
group by stu.s_id
having count(c_id)<(select count(c_id) from co);
-- ----------------------------------------------------------------------------------
-- 12、查询至少有一门课与学号为"01"的同学所学相同的同学的信息 
#学号为"01"的同学所学课程
select c_id from sc where s_id='01';

select distinct stu.*
from stu left join sc on stu.s_id=sc.s_id
where c_id in (select c_id from sc where s_id='01') and stu.s_id<>'01';
-- ----------------------------------------------------------------------------------
-- 13、练习：查询和"01"号的同学学习的课程完全相同的其他同学的信息
select stu.*
from stu left join sc on stu.s_id=sc.s_id
group by stu.s_id
having group_concat(sc.c_id)=(select group_concat(c_id) from sc where s_id='01') and stu.s_id!=01;
-- ----------------------------------------------------------------------------------
-- 35、查询所有学生的课程及分数情况（一维转二维）
select stu.s_id,
		sum(if(c_id='01',score,0)) '01',
        sum(if(c_id='02',score,0)) '02',
        sum(if(c_id='03',score,0)) '03'
from stu left join sc on stu.s_id=sc.s_id
group by stu.s_id;

select stu.s_id,
	sum(case when c_id='01' then score else 0 end) '01',
    sum(case when c_id='02' then score else 0 end) '02',
    sum(case when c_id='03' then score else 0 end) '03'
from stu left join sc on stu.s_id=sc.s_id
group by stu.s_id;

select stu.s_id,
	ifnull(sum((c_id='01')*score),0) '01',
    ifnull(sum((c_id='02')*score),0) '02',
    ifnull(sum((c_id='03')*score),0) '03'
from stu left join sc on stu.s_id=sc.s_id
group by stu.s_id;
-- ----------------------------------------------------------------------------------
-- 17、练习：按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩
select stu.s_id,
		sum(if(c_id='01',score,0)) '01',
        sum(if(c_id='02',score,0)) '02',
        sum(if(c_id='03',score,0)) '03',
        ifnull(avg(score),0) 平均成绩
from stu left join sc on stu.s_id=sc.s_id
group by stu.s_id
order by 平均成绩 desc;
-- ----------------------------------------------------------------------------------
-- 18、查询各科成绩最高分、最低分和平均分：以如下形式显示：课程ID，课程name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
#及格为：>=60，中等为：70-80，优良为：80-90，优秀为：>=90
select co.c_id,c_name,max(score) 最高分,min(score) 最低分,avg(score) 平均分,
	avg(score>=60) 及格率,
    avg(score>=70 and score<80) 中等率,
    avg(score>=80 and score<90) 优良率,
    avg(score>=90) 优秀率
from co left join sc on co.c_id=sc.c_id
group by co.c_id;
-- ----------------------------------------------------------------------------------
-- 23、练习：统计各科成绩各分数段人数：课程编号,课程名称,[100-85],[85-70],[70-60],[0-60]及所占百分比
select co.c_id,c_name,
	sum((score>=85)) '[100-85]',
    sum((score>=70 and score<85)) '[85-70]',
    sum((score>=60 and score<70)) '[70-60]',
    sum((score<60)) '[0-60]',
	concat(avg(score>=85)*100,'%') '[100-85]百分比',
    concat(avg(score>=70 and score<85)*100,'%') '[85-70]百分比',
    concat(avg(score>=60 and score<70)*100,'%') '[70-60]百分比',
    concat(avg(score<60)*100,'%') '[0-60]百分比'
from co left join sc on co.c_id=sc.c_id
group by co.c_id;
-- ----------------------------------------------------------------------------------
-- 19、查询学生的总成绩并进行排名
-- 19、查询学生的总成绩并进行排名
select s_id,sum(score) 总成绩,row_number() over(order by sum(score) desc) 排名
from sc
group by s_id;
-- ----------------------------------------------------------------------------------
-- 24、练习：查询每个学生平均成绩及其名次
-- 24、练习：查询每个学生平均成绩及其名次
select s_id,avg(score) 平均成绩,row_number() over(order by avg(score) desc) 排名
from sc
group by s_id;
-- ----------------------------------------------------------------------------------
-- 20、按各科成绩进行排序，并显示排名
select *,dense_rank() over(partition by c_id order by score desc) 排名 
from sc;
-- ----------------------------------------------------------------------------------
-- 25、查询各科成绩前三名的记录
-- 25、查询各科成绩前三名的记录
select *
from 
(select *,dense_rank() over(partition by c_id order by score desc) 排名 
from sc) t
where 排名<=3;
-- ----------------------------------------------------------------------------------
-- 42、练习：查询每门功成绩最好的前两名
select *
from 
(select *,dense_rank() over(partition by c_id order by score desc) 排名 
from sc) t
where 排名<=2;
-- ----------------------------------------------------------------------------------
-- 22、练习：查询所有课程的成绩第2名到第3名的学生信息及该课程成绩
select *
from 
(select stu.*,c_id,score,dense_rank() over(partition by c_id order by score desc) 排名 
from stu join sc on stu.s_id=sc.s_id) t
where 排名 between 2 and 3;
-- ----------------------------------------------------------------------------------
-- 26、查询每门课程被选修的学生数
select c_id,count(s_id) 选修人数 
from sc
group by c_id;
-- ----------------------------------------------------------------------------------
-- 43、练习：统计每门课程的学生选修人数（超过5人的课程才统计）
#要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列
select c_id,count(s_id) 选修人数 
from sc
group by c_id
having count(s_id)>5;
-- ----------------------------------------------------------------------------------
-- 30、查询同名同姓学生名单，并统计同名人数
select s_name,count(s_name)-1 同名人数
from stu
group by s_name;
-- ----------------------------------------------------------------------------------
-- 36、查询任何一门课程成绩在70分以上的姓名、课程名称和分数
select s_name,c_name,score 
from stu 
join sc on stu.s_id=sc.s_id
join co on sc.c_id=co.c_id
where score>70;

select s_name,c_name,score 
from stu 
join sc on stu.s_id=sc.s_id
join co on sc.c_id=co.c_id
where stu.s_id in (select s_id from sc where score>70);
-- ----------------------------------------------------------------------------------
-- 37、练习：查询出现过学生考试不及格的课程
select c_name,sc.c_id,score
from sc join co on sc.c_id=co.c_id
where score<60;
-- ----------------------------------------------------------------------------------
-- 41、查询课程不同、成绩相同的学生的学生编号、课程编号、学生成绩
select distinct t1.* 
from sc t1 join sc t2 on t1.s_id=t2.s_id and t1.c_id<>t2.c_id and t1.score=t2.score;
-- ----------------------------------------------------------------------------------
-- 47、查询本周过生日的学生
select * 
from stu
where week(s_birth)=week(curdate());
-- ----------------------------------------------------------------------------------
-- 48、练习：查询下周过生日的学生
select * 
from stu
where week(s_birth)=if(week(curdate())=54,1,week(curdate())+1);
-- ----------------------------------------------------------------------------------
-- 49、查询本月过生日的学生
select * 
from stu
where month(s_birth)=month(curdate());
-- ----------------------------------------------------------------------------------
-- 50、练习：查询下月过生日的学生
select * 
from stu
where month(s_birth)=if(month(curdate())=12,1,month(curdate())+1);





