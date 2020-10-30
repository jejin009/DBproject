CREATE OR REPLACE PROCEDURE InsertPick(sStudentId IN VARCHAR2,
sCourseId IN NUMBER,
nCourseIdNo IN NUMBER,
result OUT VARCHAR2)
IS
duplicate_courses EXCEPTION; /*동일한과목장바구니넣기*/
inserted_courses EXCEPTION; /*이미수강신청한과목장바구니넣기*/

nYear NUMBER;
nSemester NUMBER;

nCnt NUMBER;
nCntt NUMBER;

BEGIN
result := '';
DBMS_OUTPUT.put_line('#');
DBMS_OUTPUT.put_line(sStudentId || '님이 과목번호 ' || TO_CHAR(sCourseId) ||
', 분반 ' || TO_CHAR(nCourseIdNo) || '의 장바구니 넣기를 요청하였습니다.'); 

nYear := Date2EnrollYear(SYSDATE);
nSemester := Date2EnrollSemester(SYSDATE);

/* 에러 처리 1 :  이미 수강신청한 과목 장바구니넣기 */
SELECT COUNT(*)
INTO nCnt
FROM enroll
WHERE s_id = sStudentId and c_id = sCourseId and e_year = nYear and e_semester = nSemester;
IF (nCnt > 0)
THEN
RAISE inserted_courses;
END IF;

/* 에러 처리 2 : 동일한 과목 장바구니넣기 */
SELECT COUNT(*)
INTO nCntt
FROM pick
WHERE s_id = sStudentId and c_id = sCourseId and e_year = nYear and e_semester = nSemester;
IF (nCnt > 0)
THEN
RAISE duplicate_courses;
END IF;


/* 장바구니넣기 등록 */

INSERT INTO pick(s_id, c_id, c_id_no, e_year, e_semester)
VALUES (sStudentId, sCourseId, nCourseIdNo, nYear, nSemester);
COMMIT;
result := '장바구니넣기가 완료되었습니다.';

EXCEPTION
WHEN duplicate_courses THEN
result := '이미 장바구니에 등록된 과목을 장바구니넣기 신청하였습니다';
WHEN inserted_courses THEN
result := '이미 수강신청이 완료된 과목을 장바구니넣기 신청하였습니다.';
WHEN OTHERS THEN
ROLLBACK;
result := SQLCODE;
END;
/