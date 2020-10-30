create OR REPLACE PROCEDURE InsertEnroll(sStudentId IN VARCHAR2,
sCourseId IN NUMBER,
nCourseIdNo IN NUMBER,
result OUT VARCHAR2)
IS
too_many_sumCourseUnit EXCEPTION; /*최대학점초과*/
duplicate_courses EXCEPTION; /*동일한과목신청*/
too_many_students EXCEPTION; /*수강신청인원초과*/
duplicate_time EXCEPTION; /*수업시간중복*/

nYear NUMBER;
nSemester NUMBER;

nSumCourseUnit NUMBER;
nCourseUnit NUMBER;
nCnt NUMBER;
nTeachMax NUMBER;

BEGIN
result := '';
DBMS_OUTPUT.put_line('#');
DBMS_OUTPUT.put_line(sStudentId || '님이 과목번호 ' || TO_CHAR(sCourseId) ||
', 분반 ' || TO_CHAR(nCourseIdNo) || '의 수강 등록을 요청하였습니다.'); 


nYear := Date2EnrollYear(SYSDATE);
nSemester := Date2EnrollSemester(SYSDATE);

/* 에러 처리 1 : 최대학점 초과여부 */
SELECT SUM(c.c_unit)
INTO nSumCourseUnit
FROM course c, enroll e
WHERE e.s_id = sStudentId and e.c_id = c.c_id and e.c_id_no = c.c_id_no and e_year =nYear and e_semester= nSemester;

SELECT c.c_unit
INTO nCourseUnit
FROM course c
WHERE c_id = sCourseId and c_id_no = nCourseIdNo;
IF (nSumCourseUnit + nCourseUnit > 13)
THEN
RAISE too_many_sumCourseUnit;
END IF;

/* 에러 처리 2 : 동일한 과목 신청 여부 */
SELECT COUNT(*)
INTO nCnt
FROM enroll
WHERE s_id = sStudentId and c_id = sCourseId and e_year = nYear and e_semester = nSemester;
IF (nCnt > 0)
THEN
RAISE duplicate_courses;
END IF;

/* 에러 처리 3 : 수강신청 인원 초과 여부 */
SELECT c_max
INTO nTeachMax
FROM course
WHERE c_id = sCourseId and c_id_no= nCourseIdNo;

SELECT COUNT(*)
INTO nCnt
FROM enroll
WHERE c_id = sCourseId and c_id_no = nCourseIdNo and e_year = nYear and e_semester = nSemester;

IF (nCnt >= nTeachMax)
THEN
RAISE too_many_students;
END IF;

/* 에러 처리 4 : 중복시간여부 */
SELECT COUNT(*)
INTO nCnt
FROM
(SELECT c_day, c_time
FROM course
WHERE c_id = sCourseId and c_id_no = nCourseIdNo
INTERSECT
SELECT c.c_day, c.c_time
FROM course c, enroll e
WHERE e.s_id=sStudentId and
e.c_id=c.c_id and e.c_id_no=c.c_id_no and e.e_year = nYear and e.e_semester = nSemester
);

IF (nCnt > 0)
THEN
RAISE duplicate_time;
END IF;

/* 수강 신청 등록 */

INSERT INTO enroll(s_id, c_id, c_id_no, e_year, e_semester)
VALUES (sStudentId, sCourseId, nCourseIdNo, nYear, nSemester);
COMMIT;
result := '수강신청 등록이 완료되었습니다.';

EXCEPTION
WHEN too_many_sumCourseUnit THEN
result := '최대학점을 초과하였습니다';
WHEN duplicate_courses THEN
result := '이미 등록된 과목을 신청하였습니다';
WHEN too_many_students THEN
result := '수강신청 인원이 초과되어 등록이 불가능합니다';
WHEN duplicate_time THEN
result := '이미 등록된 과목 중 중복되는 시간이 존재합니다';
WHEN OTHERS THEN
ROLLBACK;
result := SQLCODE;
END;
/
