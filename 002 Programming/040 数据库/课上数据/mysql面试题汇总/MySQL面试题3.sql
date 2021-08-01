 CREATE DATABASE DB1;
 USE DB1;
 
 create table a1(LOAN_NO INT,
                ID_NO INT,
                ACTV_DT DATE);


create table a2(LOAN_NO INT,
                OD_DAYS INT);
    
create table a3(ID_NO INT,
                LIM INT,
                OUTSTANDING INT);

 insert into a1 values(1000114260,1,'2011-06-07'),
					  (1000143723,2,'2011-09-21'),
                      (1000162024,3,'2011-12-09'),
                      (1000174934,4,'2012-03-23'),
                      (1000182256,5,'2012-05-15');
                      
 insert into a2 values(1000114260,90),
                      (1000174934,16),
                      (1000182256,0),
					  (1000143723,45),
                      (1000162024,3);

insert into a3 values( 5,30000,25110),
                     (2,40000,40000),
                     (2,60000,56000),
                     (2,45000,45000),
                     (1,15000,6378),
                     (1,80000,60395),
                     (3,60000,57773),
                     (4,30000,28656),
                     (4,30000,10000);
                     
select a1.LOAN_NO,a1.ID_NO,ACTV_DT,OD_DAYS,
       IF(OD_DAYS=0,'CURRENT',IF(OD_DAYS>=90,'CHRGO','MIDDLE')) AS TYPE,
       SUM(LIM),OUTSTANDING FROM a1 left join a2 on a1.LOAN_NO = a2.LOAN_NO
	   left join a3 on a1.ID_NO = a3.ID_NO
       GROUP BY a1.LOAN_NO;

