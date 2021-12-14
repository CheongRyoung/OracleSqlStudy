-- 1.ROLLBACK: DELETE, UPDATE, INSERT등 테이블에서 수정된 행들을, 수정되기 이전 상태로 원래상태로 복귀
--           COMMIT 이후의 수정된 행들을 원복
CREATE TABLE DEPT01 AS SELECT * FROM DEPT;
SELECT * FROM DEPT01;
DELETE FROM DEPT01;
ROLLBACK;
DELETE FROM DEPT01 WHERE deptno=20;

-- 2.COMMIT: INSERT, UPDATE, DELETE등으로 수정된 테이블 행들 데이터 값을 확정
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
SELECT * FROM DEPT03;

DELETE FROM DEPT02 WHERE DEPTNO=10;

CREATE TABLE DEPT04 AS SELECT * FROM DEPT;
Truncate table DEPT03; -- Truncate table 명령어는 Create table 명령어와 같은 DDL로 내부적으로 COMMIT명령어를 무조건 실행함
Rollback;

-- DELETE 명령어와 TRUNCATE명령어의 차이점
-- 1) DLELTE: DML의 명령어이고 ROLLBACK에 의해 원상복귀 가능
-- 2) TRUNCATE: DDL의 명령어이고 내부적으로 COMMIT을 실행하여 원상복귀 안됨
-- 3) TRUNCATE가 DELETE보다 수행 속도가 빨라 만약 TABLE의 전체 행을 삭제할 경우 TRUNCATE 사용 권장
--    DELETE가 속도가 느린 이유는 ROLLBACK을 대비해서 데이터를 별도로 SAVE하여 관리하기 때문

-- 3. SAVEPOINT: 중간단계 저장
SELECT *FROM DEPT01;
DELETE FROM DEPT01 WHERE DEPTNO=40;
COMMIT; ROLLBACK;
DELETE FROM DEPT01 WHERE DEPTNO=30;

SAVEPOINT c1;  -- c1전에 DELETE 등 DDL명령어의 수행결과를 임시 저장(1차 commit)
DELETE FROM DEPT01 WHERE DEPTNO=20;
SAVEPOINT c2; 
DELETE FROM DEPT01 WHERE DEPTNO=10;
ROLLBACK TO c2;  -- savepoint c2까지 원복(rollback)
ROLLBACK TO c1;
ROLLBACK;        -- COMMIT이후 최초단계까지 원복
SELECT *FROM DEPT01;

