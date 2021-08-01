create database cda;
use cda;

create table a_user(
userid varchar(10),
tel varchar(10)
);

create table b_order(
userid varchar(10),
end_time datetime
);

insert into a_user values('A1','123456789'),
						 ('A2','134577432'),
                         ('A3','677389494'),
                         ('A5','832526477'),
                         ('A6','432728448');
                         
insert into b_order values('A1','2019-5-1 12:00'),
						  ('A2','2019-3-2 13:00'),
                          ('A2','2019-5-3 10:00'),
                          ('A3','2019-5-2 11:00'),
                          ('A4','2019-5-1 17:00'),
                          ('A5','2019-5-9 14:00'),
                          ('A1','2019-5-6 15:00'),
                          ('A5','2019-5-8 16:00'),
                          ('A2','2019-5-4 13:00'),
                          ('A4','2019-5-5 18:00'),
                          ('A3','2019-5-7 13:00');
                          
select * from a_user;
select * from b_order;
 
-- 出现在表a却不在表b的userid


-- 每个userid的最新结束时间


-- 用户结束时间在3月份的userid及tel