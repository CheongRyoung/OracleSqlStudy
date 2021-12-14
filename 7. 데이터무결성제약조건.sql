-- 1. PRIMARY KEY의 NOT NULL 제약조건 확인
INSERT INTO DEPT01 VALUES(10, 'TEST', 'SEOUL');
-- 에러 발생: unique constraint
INSERT INTO DEPT01 VALUES(NULL, 'TEST', 'SEOUL');
-- 에러 발생: cannot insert NULL into

-- USER_CONSTRAINTS(ALL_CONSTRAINTS, DBA_CONSTRAINTS VIEW TABLE도 존재함)
DESC USER_CONSTRAINTS;
-- P: PRIMARY KEY, R: FOREIGN KEY, C:CHECK와 NOT NULL을 의미, U: UNIQUE
SELECT CONSTRAINT_NAME, constraint_TYPE, TABLE_NAME FROM USER_CONSTRAINTS;

-- DEPTNO에 PRIMARY KEY가 지정되어 있지 않음
-- DEPT0에 INSERT, UPDATE 등을 통해 중복된 행들이 추가할 가능성이 높아 DEPT01 테이블의 데이터 신뢰도 낮아짐
DROP TABLE DEPT01;
CREATE TABLE DEPT01 AS SELECT * FROM DEPT;
DESC DEPT01;
INSERT INTO DEPT01 VALUES(10, 'TEST', 'SEOUL');
INSERT INTO DEPT01 VALUES(NULL, 'TEST', 'SEOUL');
SELECT * FROM DEPT01;

------------------------------------------------------------
-- EMP01: EMPNO, ENAME에 대하여 NOT NULL만 설정
CREATE TABLE EMP01(
    empno NUMBER(4) NOT NULL,
    ename VARCHAR(10) NOT NULL,
    job VARCHAR2(9),
    deptno NUMBER(2)
);
DESC EMP01;
-- ORA-01400: cannot insert NULL into ("SCOTT"."EMP01"."EMPNO")
-- empno, ename이 not null로 선언되어 있어서 null로 insert하면 에러발생
INSERT INTO EMP01 VALUES(NULL, NULL, 'SALESMAN', 10);
INSERT INTO EMP01 VALUES(NULL, 'SCOTT', 'SALESMAN', 10);
INSERT INTO EMP01 VALUES(7499, 'ALLEN', 'SALESMAN', 10);
-- empno가 중복된 것을 새로 INSERT해도 됨(DEPTNO가 NOT NULL이지만 UNIQUE가 아니기 때문임)
INSERT INTO EMP01 VALUES(7499, 'SCOTT', 'SALESMAN', 10);

-- UNIQUE 실습
DROP TABLE EMP03;
CREATE TABLE EMP03(
    empno NUMBER(4) UNIQUE,
    ename VARCHAR(10) NOT NULL,
    job VARCHAR2(9),
    deptno NUMBER(2)
);
INSERT INTO EMP03 VALUES(7499, 'ALLEN', 'SALESMAN', 10);
-- ORA-00001: unique constraint (SCOTT.SYS_C007056) violated
-- EMPNO가 UMIQUE로 선언되어 있어서 중복값을 INSERT하면 에러 발생
INSERT INTO EMP03 VALUES(7499, 'ALLEN', 'SALESMAN', 10);
-- UNIQUE로 선언된 경우에 NULL을 여러번 INSERT해도 중복체크하지 않음
-- NULL의 의미가 정해지지 않은 수
INSERT INTO EMP03 VALUES(NULL, 'SCOTT', 'SALESMAN', 10);
INSERT INTO EMP03 VALUES(NULL, 'JOHNS', 'SALESMAN', 10);

-- CONSTRAINT NAME 지정방법(지정하면, 어디서 왜 발생했는지를 알려줄수 있다.)
-- CONSTRANIT + CONSTRANIT이름(예: CONSTRAINT EMP04_ENAME_NN, EMP04_ENAME_NN은 이름)
DROP TABLE EMP04;
CREATE TABLE EMP04(
    empno NUMBER(4) CONSTRAINT EMP04_EMPNO_UK UNIQUE,
    ename VARCHAR2(10) CONSTRAINT EMP04_ENAME_NN NOT NULL,
    job VARCHAR2(9),
    deptno NUMBER(2)
);
INSERT INTO EMP04 VALUES(7499, 'ALLEN', 'SALESMAN', 10);
INSERT INTO EMP04 VALUES(7499, 'SCOTT', 'MANAGER', 20);
-- ORA-00001: unique constraint (SCOTT.EMP04_EMPNO_UK) violated
INSERT INTO EMP04 VALUES(7455, NULL, 'MANAGER', 20);

-- PRIMARY KEY 사용
DROP TABLE EMP05;
-- PRIMARY KEY = UNIQUE + NOT NULL
CREATE TABLE EMP05(
    empno NUMBER(4) CONSTRAINT EMP05_empno_pk PRIMARY key,
    ename VARCHAR2(10) CONSTRAINT EMP05_ename_NN NOT NULL,
    job VARCHAR2(9),
    deptno NUMBER(2)
    );
INSERT INTO EMP05 VALUES(7499, 'ALLEN', 'SALESMAN', 10);
-- UNIQUE ERROR (PRIMARY KEY)
INSERT INTO EMP05 VALUES(7499, 'SCOTT', 'MANAGER', 20);
-- NOT NULL ERROR (PRIMARY KEY)
INSERT INTO EMP05 VALUES(NULL, 'SCOTT', 'MANAGER', 20);

-- FOREIGN KEY 사용하기
SELECT * FROM DEPT;
SELECT * FROM EMP;

-- ORA-02291: integrity constraint (SCOTT.FK_DEPTNO) violated - parent key not found
-- FOREIGN KEY값 50은 DEPT 테이블의 DEPTNO에 없어서 FOREIGN KEY 에러 발생
INSERT INTO EMP(empno, ename, deptno) Values(8000, 'TEST', 50);
DROP TABLE EMP06;
CREATE TABLE EMP06(
    empno NUMBER(4) CONSTRAINT emp06_empno_pk primary key,
    ename VARCHAR2(10) CONSTRAINT emp06_ename_nn not null,
    job VARCHAR2(9),
    deptno NUMBER(2) CONSTRAINT emp06_deptno_FK REFERENCES dept(deptno)
    );
INSERT INTO EMP06 VALUES(7499, 'ALLEN', 'SALESMAN', 10);
INSERT INTO EMP06 VALUES(7566, 'SCOTT', 'MANAGER', 50);
INSERT INTO EMP06 VALUES(NULL, 'SCOTT', 'MANAGER', 20);

-- CHECK 사용법
DROP TABLE EMP07;
CREATE TABLE EMP07(
    empno NUMBER(4) CONSTRAINT emp07_empno_pk primary key,
    ename VARCHAR2(10) CONSTRAINT emp07_ename_nn not null,
    sal number(7, 2) CONSTRAINT emp07_sal_ck check(sal between 500 AND 5000),
    gender VARCHAR2(1) CONSTRAINT emp07_gender_ck check(gender in('M', 'F'))
);

INSERT INTO EMP07 VALUES(7899, 'ALLEN', 3000, 'M');
INSERT INTO EMP07 VALUES(7899, 'ALLEN', 3000, 'F');
INSERT INTO EMP07 VALUES(7899, 'ALLEN', 3000, 'Q');
INSERT INTO EMP07 VALUES(7899, 'ALLEN', 3000, 'f');

-- DEFUALT 사용하기
-- INSERT문을 사용하여 행을 생성할 때, DEFAULT로 선언된 속성에 대한 값을 명시적으로 주지 않으면
-- DEFAULT로 설정된 값으로 생성됨
DROP TABLE DEPT01;
CREATE TABLE DEPT01(
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13) DEFAULT 'SEOUL'
    );
SELECT * FROM dept01;

INSERT INTO DEPT01(deptno, dname) VALUES(10, 'ACCOUNTING');

-- 테이블 레벨 방식으로 constraint 조건 지정하기
DROP TABLE EMP02;
CREATE TABLE emp02(
    empno number(4) primary key,
    ename VARCHAR2(10) not null,
    job VARCHAR2(9) unique,
    deptno number(4) REFERENCES dept(deptno)
);
    -- TABLE LEVEL CONSTRAINT 지정
CREATE TABLE emp02(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10) NOT NULL,
    JOB VARCHAR2(9),
    DEPTNO NUMBER(4),
    PRIMARY KEY(EMPNO),
    UNIQUE(JOB),
    FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO)
); 
DROP TABLE EMP03;
-- TABLE LEVEL로 지정 가능한 CONSTRAINT: PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK
CREATE TABLE EMP03(
    empno number(4) ,
    -- not null은 column(속성) level만 constraint 지정 가능
    ename VARCHAR2(10) CONSTRAINT emp03_empno_nn not null,
    job VARCHAR2(9),
    deptno number(4),
    CONSTRAINT emp03_empno_pk primary key(empno),
    CONSTRAINT emp03_job_UK unique(job),
    CONSTRAINT emp03_deptno_fk FOREIGN key(deptno) references dept(deptno)
);

-- 복합키를 기본키로 지정 (TABLE LEVEL로 CONSTRAINT 지정)
CREATE TABLE member01(
    name varchar2(10),
    hphone varchar2(16),
    address varchar2(30),
    -- 복합키를 TABLE LEVEL로 CONSTRAINT 지정
    CONSTRAINT member01_combo_pk primary key(name, hphone)
    );

SELECT constraint_name, constraint_type, table_name from user_constraints;
SELECT * FROM user_cons_columns where table_name = 'MEMBER01';

-- TABLE 생성후 CONSTRAINT 추가하기
DROP TABLE emp01;
CREATE TABLE emp01(
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    deptno number(4)
);
-- TABLE 생성후 CONSTRAINT 추가 SQL문법 예
-- TABLE LEVEL로 CONSTRAINT가 추가가 됨
ALTER TABLE EMP01 add constraint emp01_empno_pk primary key(empno);
ALTER TABLE emp01 add constraint emp01_deptno_fk FOREIGN key(deptno) references dept(deptno);
-- TABLE 생성후 column level에서 constraint 추가
ALTER TABLE EMP01 modify ename constraint emp01_ename_nn not null;

-- table에 설정된 constraint 제거하기
SELECT constraint_name, constraint_type, table_name from user_constraints where table_name='EMP05';
-- primary key constraint 삭제
alter table emp05 drop constraint emp05_empno_pk;
alter table emp05 drop constraint EMP05_ENAME_NN;
SELECT * FROM EMP05;
INSERT INTO EMP05 VALUES(7499, 'MARY', 'ANALYST', 20);
INSERT INTO EMP05 VALUES(7499, null, 'CLERK', 30);
