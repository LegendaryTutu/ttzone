create database if not exists m1;
use m1;

create table customer(
  c_id char(6) primary key not null,
  name varchar(30) not null,
  location varchar(30),
  salary decimal(8,2)
);

create table bank(
  b_id char(5) primary key not null,
  bank_name char(30) not null
);

create table deposite(
	d_id int primary key not null auto_increment,
    c_id char(6),
    b_id char(5),
    dep_date date,
    dep_type char(1),
    amount decimal(8,2),
    constraint fk_cid foreign key(c_id) references customer(c_id),
    constraint fk_bid foreign key(b_id) references bank(b_id)
);


insert into customer values('101001','孙杨','广州',1234);
insert into customer values('101002','郭海','南京',3526);
insert into customer values('101003','卢江','苏州',6892);
insert into customer values('101004','郭惠','济南',3492);
insert into customer values('101005','张三','北京',6324);

insert into bank values('B0001','工商银行');
insert into bank values('B0002','建设银行');
insert into bank values('B0003','中国银行');
insert into bank values('B0004','农业银行');

insert into deposite values(null,'101001','B0001','2011-04-05','3',42526);
insert into deposite values(null,'101002','B0003','2012-07-15','5',66500);
insert into deposite values(null,'101003','B0002','2010-11-24','1',42366);
insert into deposite values(null,'101004','B0004','2008-03-31','1',62362);
insert into deposite values(null,'101001','B0003','2002-02-07','3',56346);
insert into deposite values(null,'101002','B0001','2004-09-23','3',353626);
insert into deposite values(null,'101003','B0004','2003-12-14','5',36236);
insert into deposite values(null,'101004','B0002','2007-04-21','5',26267);
insert into deposite values(null,'101001','B0002','2011-02-11','1',435456);
insert into deposite values(null,'101002','B0004','2012-05-13','1',234626);
insert into deposite values(null,'101003','B0003','2001-01-24','5',26243);
insert into deposite values(null,'101004','B0001','2009-08-23','3',45671);

#更新customer表的salary属性，将salary低于5000的客户的salary变为原来的2倍.
select * from customer; 
set SQL_SAFE_UPDATES = 0;

update customer set salary=salary*2 where salary<5000;

#对deposite表进行统计，按银行统计存款总数，显示为b_id,total. 
select * from deposite;

select b_id,sum(amount) as total from deposite group by b_id;

#对deposite、customer、bank进行查询，查询条件为location在广州、苏州、济南的客户，
#存款在300000至500000之间的存款记录，显示客户姓名name、银行名称bank_name、存款金额amount. 
# 方法一
select c.name,c.location,b.bank_name,d.amount
from deposite d,customer c,bank b
where c.location in('广州','苏州','济南') 
and d.amount between 300000 and 500000 
and c.c_id=d.c_id and b.b_id=d.b_id;

# 方法二
select c.name,c.location,b.bank_name,d.amount
from customer c 
inner join deposite d on c.c_id=d.c_id
inner join bank b on d.b_id=b.b_id
where c.location in('广州','苏州','济南')
and d.amount between 300000 and 500000;



