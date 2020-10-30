CREATE OR REPLACE PROCEDURE InsertPick(sStudentId IN VARCHAR2,
sCourseId IN NUMBER,
nCourseIdNo IN NUMBER,
result OUT VARCHAR2)

IS
inserted_courses EXCEPTION; /*�̹̼�����û�Ѱ�����*/
duplicate_courses EXCEPTION; /*�����Ѱ�����*/

nYear NUMBER;
nSemester NUMBER;

nCnt NUMBER;

BEGIN
result := '';
DBMS_OUTPUT.put_line('#');
DBMS_OUTPUT.put_line(sStudentId || '���� �����ȣ ' || TO_CHAR(sCourseId) ||
', �й� ' || TO_CHAR(nCourseIdNo) || '�� ���� ��û�Ͽ����ϴ�.'); 

nYear := Date2EnrollYear(SYSDATE);
nSemester := Date2EnrollSemester(SYSDATE);

/* ���� ó�� 1 :  �̹� ������û�� ���� �� */
SELECT COUNT(*)
INTO nCnt
FROM enroll
WHERE s_id = sStudentId and c_id = sCourseId and e_year = nYear and e_semester = nSemester;
IF (nCnt > 0)
THEN
RAISE inserted_courses;
END IF;

/* ���� ó�� 2 : ������ ���� �� */
SELECT COUNT(*)
INTO nCnt
FROM pick
WHERE s_id = sStudentId and c_id = sCourseId and e_year = nYear and e_semester = nSemester;
IF (nCnt > 0)
THEN
RAISE duplicate_courses;
END IF;


/* �� ��� */

INSERT INTO pick(s_id, c_id, c_c_id_no, e_year, e_semester)
VALUES (sStudentId, sCourseId, nCourseIdNo, nYear, nSemester);
COMMIT;
result := '�� ����� �Ϸ�Ǿ����ϴ�.';

EXCEPTION
WHEN duplicate_courses THEN
result := '�̹� �� ��ϵ� ������ �� ��û�Ͽ����ϴ�';
WHEN inserted_courses THEN
result := '�̹� ������û�� �Ϸ�� ������ �� ��û�Ͽ����ϴ�.';
WHEN OTHERS THEN
ROLLBACK;
result := SQLCODE;
END;
/