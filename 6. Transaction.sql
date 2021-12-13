-- ROLLBACK: DELETE, UPDATE, INSERT등 테이블에서 수정된 행들을, 수정되기 이전 상태로 원래상태로 복귀
--           COMMIT 이후의 수정된 행들을 원복
CREATE TABLE DEPT01 AS SELECT * FROM DEPT;
SELECT * FROM DEPT01;
DELETE FROM DEPT01;
ROLLBACK;
DELETE FROM DEPT01 WHERE deptno=20;

-- COMMIT: INSERT, UPDATE, DELETE등으로 수정된 테이블 행들 데이터 값을 확정
--         commit 명령어를 실행한 후에 rollback을 하더라도 최초상태로 복귀하지 않음
-- 1) CREATE TABLE등 TABLE 생성 명령어를 사용하면 내부적으로  COMMIT명령어를 실행하여, 이후 ROLLBACK을 하여도 복귀 못함
-- 2) CREATE TABLE SQL 문법이 틀려 에러가 나더라도 CREATE TABLE을 수행하면 내부적으로 COMMIT명령어를 수행해버려 ROLLBACK안됨
CREATE TABLE DEPT02 AS SELECT * FROM DEPT;
SELECT * FROM DEPT02;
DELETE FROM DEPT02 WHERE deptno=20;
commit;
ROLLBACK; -- COMMIT 실행한 후에 ROLLBACK명령어 실행해도 효과 없음

SELECT * FROM DEPT02;
DELETE FROM DEPT02 WHERE DEPTno=40;

CREATE TABLE DEPT03 AS SELECT * FROM DEPT;
SELECT *FROM DEPT03;
ROLLBACK; -- CREATE TABLE을 사용시 COMMIT이 같이 되 ROLLBACK 동작 안함.
SELECT * FROM DEPT02;

DELETE FROM DEPT02 WHERE DEPTNO=10;

CREATE TABLE DEPT04 AS SELECT * FROM DEPT;
