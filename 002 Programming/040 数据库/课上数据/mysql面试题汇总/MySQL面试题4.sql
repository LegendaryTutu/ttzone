create database mianshi5;
use mianshi5;
create table  boys(
	boy_id int not null,
    boy varchar(10),
    toy_id int);

create table toys(
	toy_id int primary key not null,
    toy varchar(10));
 
create table drink(
	名称 varchar(5),
    价格 decimal(8,2),
    碳水化合物 decimal(8,2),
    颜色 varchar(20),
    加冰 varchar(10),
    卡路里 int);
    
insert into boys values
	(1,"Tony",3),
    (2,"Andy",2),   
    (3,"Frank",1), 
    (4,"Only",2), 
    (4,"Only",3), 
    (5,"Terrance",4), 
    (5,"Terrance",6);
    
insert into toys values
	(1,"ToyA"),
    (2,"ToyB"),
    (3,"ToyC"),
    (4,"ToyD"),
    (5,"ToyE");
    
    
insert into drink values
	("A",1,8.4,"Yellow","N",33),
    ("B",2.5,3.2,"Blue","N",12),
    ("C",3.5,8.8,"Orange","Y",35),
    ("D",2.5,5.4,"Green","Y",24),
    ("E",5.5,42.5,"Purple","Y",171);


#请用left join写出查询语句，找出每个男孩买了哪个玩具，并写出输出结果集
select * from boys left join toys on boys.toy_id=toys.toy_id order by boy_id;

#找出既买过“ToyB”也买过”ToyC”的男孩
 select boy from boys where toy_id in
(select Toy_id  from  toys where toy in("ToyB","ToyC")) group by boy_id having count(boy_id)>1;

#列出加冰，且颜色为yellow，且卡路里大于30的饮料名称和价格
select 名称,价格 from drink where 颜色="yellow" and 加冰="Y" and 卡路里>30;

#列出碳水化合物小于4，或者加冰的饮料名称和颜色
select 名称,颜色 from drink where 碳水化合物<4 or 加冰="Y";

#所有卡路里小于100的饮料各一杯，需要多少钱
select sum(价格) from drink where 卡路里<100;


