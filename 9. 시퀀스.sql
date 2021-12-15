-- SEQUENCE: 일렬번호 생성하기

SELECT * FROM BOOK;
-- 새로운 책을 book table에 등록할 때 마다 insert명령어로 bookid번호를 순차적으로 넣지 못할 때 발생
-- (예, 최종 bookid가 2000일 때 다음 bookid가 2001이 아닌 2002로 등록시 발생
INSERT INTO BOOK VALUES(11, 'TEST', 'PBI', 30000);

-- SEQUENCE 생성하기
CREATE SEQUENCE dept_deptno_seq INCREMENT BY 10 START WITH 10;
-- 생성된 SEQUENCE 객체 dept_deptno_seq 사용하기
-- NEXTVAL(next value), CURRCAL(current value) 명령어 사용
SELECT dept_deptno_seq.nextval from dual;
SELECT dept_deptno_seq.currval from dual;

-- 실제 사용 예
CREATE SEQUENCE EMP_SEQ INCREMENT BY 1 START WITH 1 MAXVALUE 100000;
DROP TABLE EMP01;
CREATE TABLE EMP01(
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(10),
    HIREDATE DATE);
INSERT INTO EMP01 VALUES(EMP_SEQ.NEXTVAL, 'MARY', SYSDATE);
SELECT * FROM EMP01;

-- SEQUENCE 삭제하기
DROP SEQUENCE dept_deptno_seq;