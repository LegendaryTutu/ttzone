create database ds;

use ds;



-- 建表导数---------------------------------------
--  UserInfo table
create table userinfo(
	userid varchar(6) not null default '-',
    username varchar(20) not null default '-',
    userpassword varchar(100) not null default '-',    
    sex int not null default 0,
    usermoney int not null default 0,
    frozenmoney int not null default 0,
    addressid varchar(20) not null default '-',
    regtime varchar(20) not null default '-',
    lastlogin varchar(20) not null default '-',
    lasttime date not null
);

#导入数据
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/userinfo.csv"
	into table userinfo
    fields terminated by ','
	ignore 1 lines;

select * from userinfo limit 10; -- 检查数据信息
select count(*) from userinfo; -- 检查总行数1000
desc userinfo; -- 检查数据结构

set sql_safe_updates=0;-- 设置数据库的安全权限

alter table userinfo modify regtime datetime;-- 报错：表中regtime字段取值为时间戳，无法直接修改数据类型

-- 添加日期时间型的新字段
alter table userinfo add regtime_new datetime;
alter table userinfo add lastlogin_new datetime;

-- 将时间戳转换为时间格式，再赋值给新字段
update userinfo set regtime_new=from_unixtime(regtime);
update userinfo set lastlogin_new=from_unixtime(lastlogin);

-- drop table userinfo;

-- --------------regioninfo-------
create table regioninfo(
	regionid varchar(4) not null default '-',
    parentid varchar(4) not null default '-',
    regionname varchar(20) not null default '-',    
    regiontype int not null default 0,
    agencyid int not null default 0,
    pt varchar(11) not null default '-'
);

#导入数据
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/RegionInfo.csv"
	into table regioninfo
    fields terminated by ','
	ignore 1 lines;

select * from regioninfo limit 10;


-- 添加日期型的新字段
alter table regioninfo add pt_new date;

update regioninfo set pt_new=date_format(pt,'%Y-%m-%d');

-- 将字符串中提取的8个字符赋值给新字段
update regioninfo set pt_new=mid(pt,2,8);

-- drop table regioninfo;

-- --------------UserAddress-------
create table useraddress(
	addressid varchar(5) not null default '-',
    userid varchar(6) not null default '-',   
    consignee varchar(50) not null default '-',
    country varchar(1) not null default '-',
    province varchar(2) not null default '-',
    city varchar(4) not null default '-',
    district varchar(4) not null default '-',  
    address varchar(200) not null default '-',
    pt varchar(11) not null default '-'
);

#导入数据
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/UserAddress.csv"
	into table useraddress
    fields terminated by ','
	ignore 1 lines;
    

select * from useraddress limit 10;

-- 添加日期型的新字段
alter table useraddress add pt_new date;

-- 将字符串中提取的8个字符赋值给新字段
update useraddress set pt_new=mid(pt,2,8);

-- drop table useraddress;

-- ----GoodsInfo----
create table goodsinfo(
	goodsid varchar(6) not null default '-',
	typeid varchar(3) not null default '-',
	markid varchar(4) not null default '-',
	goodstag varchar(100) not null default '-',
	brandtag varchar(100) not null default '-',
	customtag varchar(100) not null default '-',
	goodsname varchar(100) not null default '-',
	clickcount int not null default 0,
	clickcr int not null default 0,
	goodsnumber int not null default 0,
	goodsweight int not null default 0,
	marketprice double not null default 0,
	shopprice double not null default 0,
	addtime varchar(20) not null default 0,
	isonsale int not null default 0,
	sales int not null default 0,
	realsales int not null default 0,
	extraprice double not null default 0,
	goodsno varchar(10) not null default '-'
);

#导入数据
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/goodsinfo.csv"
	into table goodsinfo
    fields terminated by ','
	ignore 1 lines;

select * from goodsinfo limit 10;

-- 添加日期时间型的新字段
alter table goodsinfo add addtime_new datetime;

-- 将时间戳转换为时间格式，再赋值给新字段
update goodsinfo set addtime_new=from_unixtime(addtime);

-- drop table goodsinfo;

-- ----GoodsBrand----
create table goodsbrand(
	SupplierID varchar(4) not null default '-',
	BrandType varchar(100) not null default '-',
	pt varchar(11) not null default '-'
);

#导入数据
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/GoodsBrand.csv"
	into table goodsbrand
    fields terminated by ','
	ignore 1 lines;

select * from goodsbrand limit 10;

-- 添加日期型的新字段
alter table goodsbrand add pt_new date;

-- 将字符串中提取的8个字符赋值给新字段
update goodsbrand set pt_new=mid(pt,2,8);

-- drop table goodsbrand;

-- ----GoodsColor----
create table goodscolor(
	ColorID varchar(4) not null default '-',
	ColorNote varchar(20) not null default '-',
	ColorSort int not null default 0,    
	pt varchar(11) not null default '-'
);

#导入数据
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/GoodsColor.csv"
	into table goodscolor
    fields terminated by ','
	ignore 1 lines;

select * from goodscolor limit 10;

-- 添加日期型的新字段
alter table goodscolor add pt_new date;

-- 将字符串中提取的8个字符赋值给新字段
update goodscolor set pt_new=mid(pt,2,8);

-- drop table goodscolor;

-- ----GoodsSize----
create table goodssize(
	SizeID varchar(4) not null default '-',
	SizeNote varchar(100) not null default '-',
	SizeSort int not null default 0,    
	pt varchar(11) not null default '-'
);

#导入数据
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/GoodsSize.csv"
	into table goodssize
    fields terminated by ','
	ignore 1 lines;

select * from goodssize limit 10;

-- 添加日期型的新字段
alter table goodssize add pt_new date;

-- 将字符串中提取的8个字符赋值给新字段
update goodssize set pt_new=mid(pt,2,8);

-- drop table goodssize;

-- ----OrderInfo----
create table OrderInfo(
	OrderID varchar(6) not null default '-',
	UserID varchar(10) not null default '-',
	OrderState int not null default 0,
	PayState int not null default 0,
    AllotStatus int not null default 0,
	Consignee varchar(100) not null default '-',
    Country int not null default 0,
    Province int not null default 0,
    City int not null default 0,
    District int not null default 0,
    Address varchar(100) not null default '-',
    GoodsAmount double not null default 0,
    OrderAmount double not null default 0,
    ShippingFee int not null default 0,
    RealShippingFee int not null default 0,
    PayTool int not null default 0,
    IsBalancePay int not null default 0,
    BalancePay double not null default 0,
    OtherPay double not null default 0,
    PayTime varchar(20),
    AddTime varchar(20) not null default '-'
);



#导入数据
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orderinfo.csv"
	into table OrderInfo
    fields terminated by ','
	ignore 1 lines;

select * from OrderInfo limit 10;

-- 添加日期时间型的新字段
alter table OrderInfo add paytime_new datetime;
alter table OrderInfo add addtime_new datetime;

-- 将时间戳转换为时间格式，再赋值给新字段
update OrderInfo set paytime_new=from_unixtime(paytime) where paytime<>0;
update OrderInfo set addtime_new=from_unixtime(addtime);

-- update OrderInfo set paytime=null where paytime=0;
-- update OrderInfo set paytime_new=from_unixtime(paytime);


-- drop table OrderInfo;

-- ----OrderDetail----
create table OrderDetail(
	RecID varchar(7) not null default '-',
	OrderID varchar(6) not null default '-',
	UserID varchar(6) not null default '-',
	SpecialID varchar(6) not null default '-',
	GoodsID varchar(6) not null default '-',
    GoodsPrice double not null default 0,
    ColorID varchar(4) not null default '-',
    SizeID varchar(4) not null default '-',
    Amount int not null default 0
);

#导入数据
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/OrderDetail.csv"
	into table OrderDetail
    fields terminated by ','
	ignore 1 lines;
    
select * from OrderDetail limit 10;

select count(*) from OrderDetail;

-- drop table orderdetail;


-- 查询导入表的行数
select count(*) from userinfo; -- 1000
select count(*) from RegionInfo; -- 3415
select count(*) from useraddress; -- 10000
select count(*) from goodsinfo; -- 10000
select count(*) from goodsbrand; -- 64
select count(*) from goodscolor; -- 2641
select count(*) from goodssize; -- 289
select count(*) from orderinfo; -- 3711
select count(*) from orderdetail; -- 10000



-- 不同时段的登陆用户数
select hour(lastlogin_new) 时段,count(userid) 登陆用户数
from userinfo
group by hour(lastlogin_new)
order by hour(lastlogin_new);

-- 不同时段的订单量和累计订单量
select hour(addtime_new) 时段,count(orderid) 订单量,sum(count(orderid)) over(order by hour(addtime_new)) 累计订单量
from orderinfo
group by hour(addtime_new);

-- GMV(未付款订单金额+待发货订单金额+已发货订单金额+已取消订单金额)
select orderstate,sum(orderamount) 订单金额
from orderinfo
group by orderstate
with rollup;

-- 各省市订单金额:省份、城市、订单金额
select r1.regionname 省份,r2.regionname 城市,round(sum(orderamount),2) 订单金额
from orderinfo
join regioninfo r1 on province=r1.regionid
join regioninfo r2 on city=r2.regionid
group by province,city
order by province,city;

-- 不同支付方式的订单量
select paytool,count(orderid) 订单量
from orderinfo
group by paytool;

-- 哪种支付方式可能导致用户支付不成功而取消订单
select paytool,count(orderid) 未支付取消订单量
from orderinfo
where orderstate=3 and paystate=0
group by paytool;

select t1.paytool,未支付取消订单量,订单量,ifnull(未支付取消订单量/订单量,0) 占比
from 
(select paytool,count(orderid) 订单量
from orderinfo
group by paytool) t1
left join 
(select paytool,count(orderid) 未支付取消订单量
from orderinfo
where orderstate=3 and paystate=0
group by paytool) t2 
on t1.paytool=t2.paytool;

-- 不同品牌的总销量
select goodsinfo.typeid,brandtype,sum(amount) 总销量
from orderdetail
left join goodsinfo on orderdetail.goodsid=goodsinfo.goodsid
left join goodsbrand on goodsinfo.typeid=goodsbrand.supplierid
group by goodsinfo.typeid;

-- 不同品牌的复购用户数
select t.typeid,brandtype,count(t.userid) 复购用户数
from 
(select goodsinfo.typeid,brandtype,userid,count(distinct orderid) 下单次数
from orderdetail
left join goodsinfo on orderdetail.goodsid=goodsinfo.goodsid
left join goodsbrand on goodsinfo.typeid=goodsbrand.supplierid
group by goodsinfo.typeid,userid
having	count(distinct orderid)>1) t
group by t.typeid;



create table t as
select r1.regionname 省份,r2.regionname 城市,round(sum(orderamount),2) 订单金额
from orderinfo
join regioninfo r1 on province=r1.regionid
join regioninfo r2 on city=r2.regionid
group by province,city
order by province,city;

select * from t;


select r1.regionname 省份,r2.regionname 城市,round(sum(orderamount),2) 订单金额
from orderinfo
join regioninfo r1 on province=r1.regionid
join regioninfo r2 on city=r2.regionid
group by province,city
order by province,city
into outfile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/t.scv';


