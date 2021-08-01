create database cda;

use cda;

create table table1(
dt date,
商品编码 varchar(10),
商品名称 text,
销量 int,
销额 int,
primary key(dt,商品编码)
);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/table1.csv"
into table table1
fields terminated by ','
ignore 1 lines;

select * from table1;
select count(*) from table1;-- 3360
select count(distinct dt) from table1;-- 36
select count(distinct 商品编码) from table1;-- 100


create table table2(
商品编码 varchar(10) primary key,
品类 varchar(10),
品牌 varchar(10)
);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/table2.csv"
into table table2
fields terminated by ','
ignore 1 lines;

select * from table2;
select count(*) from table2;-- 100
select count(distinct 商品编码) from table2;-- 100
select count(distinct 品类) from table2;-- 7
select count(distinct 品牌) from table2;-- 50


create table table3(
dt date,
商品编码 varchar(10),
用户浏览ID varchar(20)
);

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/table3.csv"
into table table3
fields terminated by ','
ignore 1 lines;

select * from table3;
select count(*) from table3;-- 5309
select count(distinct dt) from table3;-- 36
select count(distinct 商品编码) from table3;-- 100
select count(distinct 用户浏览ID) from table3;-- 201


-- 所有产品名称中带荣耀的华为产品，将产品品牌更改为华为
update table2 set 品牌='华为' 
where 商品编码 in 
(select 商品编码 from (select table1.商品编码 from table1 
left join table2 on table1.商品编码=table2.商品编码
where 商品名称 like '%荣耀%') t);

select t1.品类,t1.品牌,19年销量,19年销额,19年访客量,18年销量,18年销额,18年访客量,
		round((19年销量-18年销量)/18年销量,2) 19年销量同比,
        round((19年销额-18年销额)/18年销额,2) 19年销额同比,
        round((19年访客量-18年访客量)/18年访客量,2) 19年访客量同比
from 
(select 品类,品牌,
		sum((year(dt)=2019)*(day(dt) between 1 and 15)*(if(品类='笔记本' and 销额/销量>=500,1,if(品类!='笔记本' and 销额/销量!=0,1,0))*销量)) 19年销量,
        sum((year(dt)=2019)*销额) 19年销额,
        sum((year(dt)=2018)*(day(dt) between 1 and 15)*(if(品类='笔记本' and 销额/销量>=500,1,if(品类!='笔记本' and 销额/销量!=0,1,0))*销量)) 18年销量,
        sum((year(dt)=2018)*销额) 18年销额
from table1 join table2 on table1.商品编码=table2.商品编码
where 商品名称 not like '%补差价%'
group by 品类,品牌) t1
join
(select 品类,品牌,count(distinct table3.dt,用户浏览ID) 19年访客量
from table1 
join table2 on table1.商品编码=table2.商品编码
join table3 on table2.商品编码=table3.商品编码
where 商品名称 not like '%补差价%' and year(table3.dt)=2019
group by 品类,品牌) t2 on t1.品类=t2.品类 and t1.品牌=t2.品牌
join 
(select 品类,品牌,count(distinct table3.dt,用户浏览ID) 18年访客量
from table1 
join table2 on table1.商品编码=table2.商品编码
join table3 on table2.商品编码=table3.商品编码
where 商品名称 not like '%补差价%' and year(table3.dt)=2018
group by 品类,品牌) t3 on t3.品类=t2.品类 and t3.品牌=t2.品牌
order by t1.品类,19年访客量 desc;