CREATE TABLE PICK(
	s_id VARCHAR(30),
	c_id VARCHAR(30),
	c_id_no VARCHAR(30),
	e_year VARCHAR(30),
	e_semester VARCHAR(30),
	PRIMARY KEY(s_id, c_id, c_id_no, e_year, e_semester),
	FOREIGN KEY(s_id) REFERENCES student(s_id),
	FOREIGN KEY(c_id, c_id_no) REFERENCES course(c_id, c_id_no)
);