CREATE OR REPLACE PROCEDURE InsertPick(sStudentId IN VARCHAR2,
sCourseId IN NUMBER,
nCourseIdNo IN NUMBER,
result OUT VARCHAR2)
IS
duplicate_courses EXCEPTION; /*�����Ѱ�����ٱ��ϳֱ�*/
inserted_courses EXCEPTION; /*�̹̼�����û�Ѱ�����ٱ��ϳֱ�*/

nYear NUMBER;
nSemester NUMBER;

nCnt NUMBER;
nCntt NUMBER;

BEGIN
result := '';
DBMS_OUTPUT.put_line('#');
DBMS_OUTPUT.put_line(sStudentId || '���� �����ȣ ' || TO_CHAR(sCourseId) ||
', �й� ' || TO_CHAR(nCourseIdNo) || '�� ��ٱ��� �ֱ⸦ ��û�Ͽ����ϴ�.'); 

nYear := Date2EnrollYear(SYSDATE);
nSemester := Date2EnrollSemester(SYSDATE);

/* ���� ó�� 1 :  �̹� ������û�� ���� ��ٱ��ϳֱ� */
SELECT COUNT(*)
INTO nCnt
FROM enroll
WHERE s_id = sStudentId and c_id = sCourseId and e_year = nYear and e_semester = nSemester;
IF (nCnt > 0)
THEN
RAISE inserted_courses;
END IF;

/* ���� ó�� 2 : ������ ���� ��ٱ��ϳֱ� */
SELECT COUNT(*)
INTO nCntt
FROM pick
WHERE s_id = sStudentId and c_id = sCourseId and e_year = nYear and e_semester = nSemester;
IF (nCnt > 0)
THEN
RAISE duplicate_courses;
END IF;


/* ��ٱ��ϳֱ� ��� */

INSERT INTO pick(s_id, c_id, c_id_no, e_year, e_semester)
VALUES (sStudentId, sCourseId, nCourseIdNo, nYear, nSemester);
COMMIT;
result := '��ٱ��ϳֱⰡ �Ϸ�Ǿ����ϴ�.';

EXCEPTION
WHEN duplicate_courses THEN
result := '�̹� ��ٱ��Ͽ� ��ϵ� ������ ��ٱ��ϳֱ� ��û�Ͽ����ϴ�';
WHEN inserted_courses THEN
result := '�̹� ������û�� �Ϸ�� ������ ��ٱ��ϳֱ� ��û�Ͽ����ϴ�.';
WHEN OTHERS THEN
ROLLBACK;
result := SQLCODE;
END;
/