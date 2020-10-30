CREATE OR REPLACE PROCEDURE countStudent
(cCourseId IN NUMBER,
cClass IN NUMBER,
nYear IN NUMBER,
nSemester IN NUMBER,
sStudent OUT NUMBER)
IS
	CURSOR enroll_student IS
		select s_name, s_id, s_major, s_grade, s_tel
		from student 
		where s_id IN(select s_id
		 			  from enroll
		 			  where e_year =nYear 
		 			  and e_semester = nSemester
		 			  and c_id = cCourseId 
                      and c_id_no = cClass) order by s_name;		
BEGIN
	sStudent := 0;
	FOR enroll_list IN enroll_student LOOP
		sStudent := sStudent + 1;
	END LOOP;
END;
/