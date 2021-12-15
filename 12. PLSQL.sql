-- PL/SQL : Oracle's Procedural Language extension to SQL
-- Procedural Language : 절차 언어는 통상 C 언어를 의미 (Java : Object Oriented Language)
-- SQL명령어를 사용해서 if/while 제어문, 변수 선언등을 사용하여 코딩을 할 수 있다는 의미임

-- 오라클 PL/SQL로 짠 프로그램 결과값을 CONSOLE에게 출력하라고 설정하는 명령어
SET SERVEROUTPUT ON

BEGIN
--  DBMS_OUTPUT.PUT_LINE : System.out.println과 같은 기능
--  명령어 마다 끝에 ; 을 붙여야만 함
    DBMS_OUTPUT.PUT_LINE('HELLO, PLSQL');
END;
/
-- / : PL/SQL 프로그램이 종료된다는 기호

-- 2번째 프로그램 : 변수 선언하여 사용하기
-- DECLARE : 변수 선언할 때 사용하는 키워드
DECLARE
--  변수이름 변수데이터타입
    VEMPNO NUMBER(4);
    VENAME VARCHAR2(10);
BEGIN
    VEMPNO := 7788;
    VENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('사번  /  이름');
    DBMS_OUTPUT.PUT_LINE('--------------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME);
END;
/

-- SELECT 문을 사용하여 사번과 이름 검색 하기
-- EMP.EMPNO%TYPE => VEMPNO의 데이터 타입을 선언
DECLARE
    VEMPNO EMP.EMPNO%TYPE;
    VENAME EMP.ENAME%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('사번  /  이름');
    DBMS_OUTPUT.PUT_LINE('--------------------');
    SELECT EMPNO, ENAME INTO VEMPNO, VENAME 
        FROM EMP 
        WHERE ENAME='SCOTT';
    DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME);
END;
/

