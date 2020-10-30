CREATE TABLE TEACH(
	p_id VARCHAR(30),
	c_id VARCHAR(30),
	c_id_no VARCHAR(30), 
	t_year VARCHAR(30),
	t_semester VARCHAR(30),
	
	PRIMARY KEY(p_id, c_id, c_id_no, t_year, t_semester),
	FOREIGN KEY(p_id) REFERENCES professor(p_id),
	FOREIGN KEY(c_id, c_id_no) REFERENCES course(c_id, c_id_no)
);

insert into teach values('12001','1300','1','2019','1');
insert into teach values('12003','1300','2','2019','1');
insert into teach values('12000','1301','1','2019','1');
insert into teach values('12000','1302','1','2019','1');
insert into teach values('12013','1303','1','2019','1');
insert into teach values('12009','1303','2','2019','1');
insert into teach values('12005','1304','1','2019','1');
insert into teach values('12010','1305','1','2019','1');
insert into teach values('12010','1305','2','2019','1');
insert into teach values('12002','1306','1','2019','1');
insert into teach values('12006','1307','1','2019','1');
insert into teach values('12004','1308','1','2019','1');
insert into teach values('12004','1309','1','2019','2');

insert into teach values('12001','1310','1','2019','1');
insert into teach values('12001','1310','2','2019','1');
insert into teach values('12003','1311','1','2019','1');
insert into teach values('12004','1312','1','2019','1');
insert into teach values('12013','1313','1','2019','2');
insert into teach values('12009','1313','2','2019','2');
insert into teach values('12011','1314','1','2019','1');
insert into teach values('12008','1315','1','2019','1');
insert into teach values('12008','1301','2','2019','1');
insert into teach values('12007','1301','1','2019','1');
insert into teach values('12008','1317','1','2019','1');
insert into teach values('12004','1318','1','2019','2');
insert into teach values('12013','1303','3','2019','1');

