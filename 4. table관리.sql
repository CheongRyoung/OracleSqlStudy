-- Table 생성, 수정, 삭제
-- 개발 프로젝트 진행하는 동안에 주로 table 생성, 삭제를 위주로 사용
-- 어플리케이션이 개발 완료된 후에 시스템을 운영할 때는 table 수정 작업이 일부 존재
-- 시스템이 운영되면 table에 데이터(행들)가 생성되기 때문에, 함부로 table을 수정, 삭제하기 어려움
-- => 이유: data migration(데이터 이관) 작업이 추가로 발생되어 매우 신중하게 처리해야 함

-- DDL(Data Definition Langugage): Table Create(생성), ALTER(수정), DROP(삭제)

-- CHAR(10): 메모리에 무조건 10개 문자를 할당(2개 문자가 입력되더라도 메모리에 10개 문자 자리를 잡음)
-- VARCHAR2(10): 입력된 문자 객수만큼 메모리에 자리를 잡음(2개문자가 입력되면 메모리에 2개 문자 자리만 잡음)

-- NUMBER(p, s): p는 소숫점.을 제외한 전체 자리수, s는 소숫점 이하 자리수를 의미

-- rowid: oracle에서 관리하는 해당 행의 data 위치를 표현
SELECT rowid, empno, ename FROM emp;

-- 테이블 생성
CREATE TABLE EMP02(
    EMPNO NUMBER(4),
    ENAME VARCHAR(20),
    SAL NUMBER(7,2)
);

SELECT * FROM EMP02;

DESC EMP02;

-- SUBQUERY로 TABLE 생성하기, 원본 TABLE SCHEMA뿐만 아니라, 데이터 전체 모두 복사
CREATE TABLE EMP01 AS SELECT * FROM EMP;
SELECT * FROM EMP01;

-- SUBQUERY로 

CREATE TABLE EMP04 AS SELECT empno, ename, sal FROM emp;
SELECT * FROM emp04;

CREATE TABLE EMP05 AS SELECT * FROM emp WHERE DEPTNO=10;
SELECT * FROM emp05;

CREATE TABLE DEPT02 AS SELECT * FROM dept WHERE 1=0;
SELECT * FROM DEPT02;

-- TABLE 수정, 속성 추가 (ALTER TABLE 명령어 사용)
DESC EMP02;

ALTER TABLE EMP02 ADD(JOB VARCHAR2(9));

ALTER TABLE DEPT02 ADD(DMGR NUMBER(4));

DESC DEPT02;

-- 기존 칼럼 속성 변경하기(요게 문제가 됨)
-- MODIFY(TABLE 속성 데이터 타입, 자리수를 변경)
-- 유의 사항
-- 1. 해당 컬럼(속성)에 데이터가 없는 경우: 속성의 데이터 타입, 속성 크기 모두 변경 가능
-- 2. 해당 컬럼(속성)에 데이터가 있는 경우: 속성 데이터타입 변경 불가, 속성 크기를 늘리는 경우만 가능
--    (기존 데이터가 존재하면, 데이터 타입을 변경하거나, 속성크기를 줄이면 데이터 유실이 됨)
DESC EMP02;
SELECT * FROM EMP02;
ALTER TABLE EMP02 MODIFY(JOB VARCHAR2(30));

DESC DEPT02;
ALTER TABLE DEPT02 MODIFY(DMGR VARCHAR2(4));
ALTER TABLE DEPT02 MODIFY(DMGR NUMBER(4));

-- 기존 컬럼(속성) 삭제하기
DESC EMP02;
ALTER TABLE EMP02 DROP COLUMN job;

-- 속성 삭제할 때 예상문제:
-- 1. 몇십만건 이상 속성 데이터를 삭제하면, 시간이 많이 소요되고,
-- 2. 삭제중인 데이터를 사용하는 어플리케이션을 사용하는 USER가 있다면, 시스템이 멈추는 등 문제가 발생 소지 많음
--    속성 삭제할 경우에는 사용자가 사용하지 않는 날짜를 정해서 삭제
ALTER TABLE DEPT01 DROP COLUMN DMGR;

-- SET UNUSED: 실제 속성을 삭제하지 않고, 삭제한 효과를 내는 명령어
-- 장점: 실제 속성을 삭제하는 시간보다 SET UNUSED 실행 속도가 엄청 빠름
-- 실제 삭제할 경우에는 DROP COLUMN 사용하여 삭제

DESC EMP01;
SELECT * FROM EMP01;

ALTER TABLE EMP01 SET UNUSED(JOB);
ALTER TABLE EMP01 DROP UNUSED COLUMNS;  -- SET UNUSED로 된 속성들을 일괄 삭제하는 명령어

-- TABLE 삭제
DROP TABLE EMP06; -- DROP TABLE
-- TRUNCATE: TABLE의 데이터만 삭제할 경우(스키마는 살아있음)
TRUNCATE TABLE EMP05;
-- RENAME: TABLE 이름 변경
RENAME emp02 TO TEST;

-- DATA DICTIONARY(데이터 사전): ORACLE이 생성/수정/삭제 등을 하는 시스템 테이블
-- 사용자가 만든 DATABASE, TABLE등의 정보를 관리하는 시스템 테이블
-- (예를 들면 SCOTT, MADANG등의 사용자와 해당 테이블들의 정보를 관리)
-- VIEW: TABLE은 아니고, 테이블처럼 SELECT등의 명령어를 사용 가능
DESC USER_TABLES;
SHOW USER;
-- SCOTT에서 생성된 모든 TABLE 조회
SELECT TABLE_NAME FROM USER_TABLES ORDER BY TABLE_NAME DESC;
-- ALL_TABLES
DESC ALL_TABLES;
SELECT OWNER, TABLE_NAME FROM ALL_TABLES;

-- DBA_TABLES: DBA, 즉 SYSTEM이나 SYS에서 사용 가능
SELECT TABLE_NAME, OWNER FROM DBA_TABLES;