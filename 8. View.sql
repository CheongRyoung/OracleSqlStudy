-- View: 가상(VIRTUAL) TABLE
-- VIEW TABLE을 생성한 후에는 TABLE에서 사용 가능한 SElECT
CREATE TABLE DEPT_COPY AS SELECT * FROM DEPT;
SELECT * FROM DEPT_COPY;

CREATE TABLE EMP_COPY AS SELECT * FROM EMP;
SELECT * FROM EMP_COPY;

-- VIEW TABLE 생성
CREATE VIEW EMP_VIEW30 as SELECT empno, ename, deptno from emp_copy where deptno=30;
select * FROM emp_view30;
desc emp_view30;
CREATE VIEW EMP_VIEW20 as SELECT empno, ename, deptno from emp_copy where deptno=20;
select *from emp_view20;