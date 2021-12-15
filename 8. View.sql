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

-- VIEW TABLE의 내부구조 살펴보기
DESC USER_VIEWS;

-- VIEW_NAME: CREATE VIEW로 생성한 VIEW NAME의미
-- TEXT: CREATE VIEW에서 AS 다음에 나오는 SUBQUERY의미
SELECT VIEW_NAME, TEXT FROM USER_VIEWS;

-- VIEW TABLE인 EMP_VIEW30에 대하여 SELECT를 실행하면, Oracle내부적으로 TEXT에 있는 SUBQUERY를 실행함
-- 즉, 실제적으로는 VIEW TABLE의 원본테이블인 EMP_COPY의 SELECT문 실행함
SELECT * FROM EMP_VIEW30;

-- VIEW TABLE에 INSERT 명령어 실행
-- 명령어 실행시, 실제 데이터는 VIEW TABLE의 원본 TABLE인 EMP_COPY에 저장됨
INSERT INTO EMP_VIEW30 VALUES(1111, 'AAAA', 30);
SELECT *FROM EMP_copy;

-- 단순 VIEW의 컬럼에  ALIAS(별칭) 부여하기
-- CREATE OR REPLACE VIEW: VIEW TABLE이 없으면 CREATE하고, VIEW TABLE이 기존에 있으면 REPLACE
-- VIEW를 삭제한 후 다시 생성시 DROP VIEW, CREATE VIEW명령어를 사용해야함
-- CREATE OR REPLACE VIEW 사용시 명령어 한번만 사용할 수 있음
CREATE OR REPLACE VIEW EMP_VIEW (사원번호, 사원명, 급여, 부서번호)
AS SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP_COPY;

-- 복합 VIEW 만들기
CREATE OR REPLACE VIEW EMP_VIEW_DEPT
AS SELECT e.empno, e.ename, e.sal, e.deptno, d.dname, d.loc
    FROM emp e, dept d
        WHERE e.deptno=d.deptno
            ORDER BY empno desc;
            
-- VIEW 삭제
DROP VIEW EMP_VIEW;

-- 조건 컬럼값을 변경하지 못하게 막는 WITH CHECK OPTION 사용하기
SELECT * FROM EMP_VIEW30;
UPDATE EMP_VIEW30 SET deptno=20 WHERE empno=1111;   -- with check option이 없어 수정 가능
INSERT INTO VIEW_CHK30 VALUES(2222, 'BBBB', 20);    -- 추가 가능

CREATE OR REPLACE VIEW VIEW_CHK30
AS SELECT empno, ename, sal, comm, deptno
    FROM emp_copy
        WHERE deptno=30 WITH CHECK OPTION;

SELECT * FROM VIEW_CHK30;
UPDATE VIEW_CHK30 SET deptno=20 WHERE empno=7900; -- with check option이 있어 수정 불가
INSERT INTO VIEW_CHK30 VALUES(2222, 'BBBB', 20);  -- deptno가 30이외로는 수정 불가 다른건 변경 가능

-- VIEW를 통해 기본 테이블 변경을 막는 WITH READ ONLY (많이 사용 **)
CREATE OR REPLACE VIEW VIEW_READ30
AS SELECT empno, ename, sal, comm, deptno
    FROM emp_copy
        WHERE deptno=30 WITH READ ONLY;
        
SELECT * FROM VIEW_READ30;
UPDATE VIEW_READ30 SET comm=5000;   -- 속성 모두 수정 불가 읽기만 가능

-- ROWNUM(임시속성 순서): INLINE VIEW(FROM (SELECT * FROM EMP ORDER BY SAL DESC))
SELECT * FROM EMP;
SELECT ROWNUM, emp.* FROM EMP;
SELECT * FROM (SELECT * FROM EMP ORDER BY SAL DESC);

-- SAL이 상위 3명을 가져와라
SELECT * FROM (SELECT * FROM EMP ORDER BY SAL DESC) WHERE rownum <= 3;

CREATE OR REPLACE VIEW VIEW_HIRE
AS SELECT empno, ename, hiredate
    FROM emp
        ORDER BY hiredate;
-- VIEW TABLE을 새로 만들면, SUBQUERY 결과에 따라 rownum이 새로 생성됨
SELECT rownum, empno, ename, hiredate from view_hire;

-- 입사일자가 가장 빠른 3명은?
SELECT * FROM view_hire WHERE rownum <= 3;
