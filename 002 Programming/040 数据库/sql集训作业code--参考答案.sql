create database cda;
use cda;

create table product(
product varchar(10),
category varchar(10),
color varchar (10),
weight decimal(10,2),
Price int);

insert into product
values ('producta','categorya','yellow',5.6,100),
('productb','categorya','red',3.7,200),
('productc','categoryb','blue',10.3,300),
('productd','categoryb','black',7.8,400);

##################################################
create table orders(
orderid int,
cname varchar(10),
orderdate date,
store varchar(10),
product varchar(10),
quantity int,
amount int);

insert into orders
values(1,'customera','2018-01-01','storea','producta',1,100),
(1,'customera','2018-01-01','storea','productb',1,200),
(1,'customera','2018-01-01','storea','productc',1,300),
(2,'customerb','2018-01-12','storeb','productb',1,200),
(2,'customerb','2018-01-12','storeb','productd',1,400),
(3,'customerc','2018-01-12','storec','productb',1,200),
(3,'customerc','2018-01-12','storec','productc',1,300),
(3,'customerc','2018-01-12','storec','productd',1,400),
(4,'customera','2018-01-01','stored','productd',2,800),
(5,'customerb','2018-01-23','storeb','producta',1,100);

###########################################################
create table store(
store varchar(10),
city varchar(10)
);

insert into store
values('storea','citya'),
('storeb','citya'),
('storec','cityb'),
('stored','cityc'),
('storee','cityd'),
('storef','cityb');

select * from product;
select * from orders;
select * from store;

##################################################################

-- 查找符合下列要求的产品，并按照产品价格降序排列：category为categorya且颜色为yellow，或者weight大于5
select * 
from product
where category='categorya' and color='category' or weight>5
order by price desc;

-- 计算每一位客人的总购买金额(amount)，总购买订单数，总购买产品件数(quantity)，
-- 同一个客人同一天的订单算做一单，并筛选出总购买金额大于等于800的客人，按金额降序排列
select cname,sum(amount) 总购买金额,count(distinct orderid) 总购买订单数,sum(quantity) 总购买产品件数 
from orders
group by cname
having sum(amount)>=800
order by sum(amount) desc;

-- 给出每个城市(city)的总店铺数，总购买人数和总购买金额(amount)，包含无购买记录的城市
select city,count(distinct store.store) 总店铺数,count(distinct cname) 总购买人数,ifnull(sum(amount),0) 总购买金额
from store left join orders on store.store=orders.store
group by city;

-- 查找购买过categorya产品的客人，并计算每一位客人的平均订单金额(amount)，一个订单编号(orderid)算做一单
select cname,sum(amount)/count(distinct orderid) 平均订单金额 
from orders
group by cname
having cname in (select distinct cname
				 from orders left join product on product.product=orders.product
				 where category='categorya');
                 
-- 查找每个城市(city)购买金额排名第二的客人，列出其购买城市，姓名和购买金额
select *
from 
(select city,cname,sum(amount),dense_rank() over(partition by city order by sum(amount) desc) 排名
from Orders left join Store on Orders.store=Store.store
group by city,cname) t
where 排名=2;

