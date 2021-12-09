SELECT * from emp;

SELECT empno, ename, sal from emp;
SELECT empno, ename, sal FROM emp where sal>3000;
SELECT empno, ename, sal FROM emp where sal<=3000;
SELECT empno, ename, SAL FROM emp where sal<>3000;

SELECT * FROM emp WHERE DEPTNO=10;

SELECT empno, ename, sal from emp where sal <= 1500;

SELECT empno, ename, sal from emp where ename = 'SCOTT';

SELECT * FROM emp where hiredate <= '82@01@01'; -- 구분자 임의로 가능

SELECT * FROM emp where deptno=10 AND job ='MANAGER';
SELECT * FROM emp where deptno=10 OR job ='MANAGER';
SELECT * FROM emp where NOT deptno = 10;

SELECT ename FROM emp where sal >= 2000 AND sal <=3000;

SELECT ename FROM emp where comm = 300 OR comm = 1400 OR comm = 500;

SELECT empno, sal FROM emp where empno=7521 OR empno=7654 OR empno=7844;

SELECT * FROM emp WHERE sal BETWEEN 2000 AND 3000;
SELECT * FROM emp WHERE sal NOT BETWEEN 2000 AND 3000;

SELECT * FROM EMP WHERE comm in(300, 500, 1400);
SELECT * FROM EMP WHERE empno in(7521, 7654, 7844);

SELECT * FROM EMP WHERE COMM NOT IN(300, 500, 1400);

-- WHERE에서 영문자를 검색할 때 대소문자를 구분한다.
SELECT * FROM EMP WHERE ename LIKE 'F%';
SELECT * FROM EMP WHERE ename LIKE 'J%';
SELECT * FROM EMP WHERE ename LIKE '%A%';
SELECT * FROM EMP WHERE ename LIKE '%N';
SELECT * FROM EMP WHERE ename LIKE 'K%';
SELECT * FROM EMP WHERE ename LIKE '%K%';
SELECT * FROM EMP WHERE ename LIKE '%K';

SELECT * FROM EMP WHERE ename NOT LIKE '%A%';

SELECT * FROM EMP WHERE comm is null;
SELECT * FROM EMP WHERE comm is not null;
SELECT * FROM EMP WHERE mgr is null;

SELECT * FROM EMP ORDER BY comm;
SELECT * FROM EMP order by comm desc;
SELECT * FROM EMP ORDER BY empno;
SELECT * FROM EMP ORDER BY ename;
SELECT * FROM EMP ORDER BY hiredate DESC;
SELECT * FROM EMP ORDER BY sal DESC, ename ASC;

SELECT * FROM EMP ORDER BY deptno, empno, hiredate DESC, ename, sal; 

---------------------------------------------------------------------

-- SQL 주요 함수
-- DESC + table 이름 => table의 상세 정보를 화면에 출력
-- DESC: DESCRIBE (표기하다, 표현하다.)
DESC DUAL;  -- DUAL 테이블은 DUMMY라는 단 하나의 컬럼에 X라는 단 하나의 로우만을 저장하고 있으나 이 값은 아무런 의미가 없습니다. 
DESC EMP;
-- 단순 연산
SELECT 30*50 FROM dual;
-- SYSDATE는 오늘 날짜를 구하는 키워드
SELECT SYSDATE FROM dual;

SELECT -10, ABS(-10) FROM dual;   -- 절대 값
SELECT 34.5678, FLOOR(34.5678) FROM DUAL; -- FLOOR: 실수에서 소숫점 자리를 전부 제거한 수를 결과값으로 RETURN
SELECT 34.5678, CEIL (34.5678) FROM DUAL; -- CEIL: 실수에서 소수점 자리의 최대값은 정수 값에 34에 +1한 값 리턴
SELECT 34.5678, ROUND(34.5678, 1) FROM DUAL; -- ROUND: 실수 값을 반올림하는 함수, 반올림 자리 지정 가능(음수는 소수점이상, 양수는 소수점이하)
SELECT trunc(34.5678, 2), TRUNC(34.5678, -1),  TRUNC(34.5678) FROM DUAL; -- TRUNC: 자리수 이하 절삭(TRUNCATE)

-- 나머지 구하는 함수 : MOD(A, B) => A%B
SELECT MOD(27,2), MOD(27,5), MOD(27,7) FROM DUAL;
SELECT * FROM EMP WHERE MOD(empno,2) = 1;

-- 문자처리함수
SELECT 'Welcome to Oracle', UPPER('Welcome to Oracle') FROM DUAL; -- UPPER: 모든 소문자를 대문자로 변환
SELECT * FROM emp where LOWER(ename) = 'miller';  -- LOWER: 모든 대문자를 소문자로 변환
SELECT LENGTH('Oracle'), LENGTH('오라클') FROM DUAL; -- LENGTH: 문자열길이 (단어 갯수 의미)
SELECT LENGTHB('Oracle'), LENGTHB('오라클') FROM DUAL; -- LENGTHB: BYTE 길이(한글 1글자 = 3BYTE)
SELECT SUBSTR('WELCOME TO ORACL',4,3) FROM DUAL; -- SUBSTR(문자열, 시작위치, 갯수): 시작위치(인덱스 x)에서 갯수만큼 문자열 가져옴
SELECT SUBSTR('WELCOME TO ORACL',-4,3) FROM DUAL; -- 시작 위치가 음수이면 뒤에서 부터 센다.

SELECT * FROM EMP WHERE hiredate LIKE '___09%';
SELECT SUBSTR(hiredate, 1, 2) 년, SUBSTR(hiredate, 4, 2) 월, SUBSTR(hiredate, 7, 2) 일 FROM emp;
SELECT * FROM EMP WHERE SUBSTR(hiredate, 4, 2) IN(09);
SELECT * FROM EMP WHERE SUBSTR(hiredate, 1, 2)=81;
SELECT * FROM EMP WHERE LOWER(SUBSTR(ename, -1, 1))='e';

SELECT INSTR('WELCOME TO ORACLE', 'O', 6, 2) FROM DUAL; -- INSTR(문자열, 찾고자하는 문자, , 검색시작 위치, 몇번쨰검색결과): 찾고자하는 문자의 위치를 RETURN
SELECT * FROM EMP WHERE ename LIKE '%T__';
SELECT * FROM EMP WHERE INSTR(ename, 'R')=3;

SELECT LPAD('oracle', 20, '#') from dual; -- LPAD(문자열, 전체자리수, 전체자리 중 빈공간 채우는 문자): 특정 기호로 채우는 LPAD/RPAD
SELECT RPAD('oracle', 20, '#') from dual;

SELECT LTRIM('  oracle   ') FROM DUAL; -- LTRIM/RTIM(문자열): 공백제거

-- 날짜 함수
SELECT SYSDATE FROM DUAL;

SELECT SYSDATE - 1 어제, SYSDATE 오늘, SYSDATE + 1 내일 FROM DUAL; 
SELECT ROUND((SYSDATE-hiredate), 2) as "근무일수" FROM emp;

SELECT hiredate, ROUND(hiredate, 'month') from emp;
SELECT hiredate, TRUNC(hiredate, 'mm') from emp;

SELECT ename, sysdate, hiredate, MONTHS_BETWEEN(sysdate, hiredate) from emp;

SELECT sysdate, next_day(sysdate, '수요일') from dual;
SELECT hiredate, last_day(hiredate) from emp;

-- TO_CHAR
SELECT hiredate, TO_CHAR(hiredate, 'yyyy/mm/dd day') from emp;  -- 1980/12/17 수요일
SELECT hiredate, TO_CHAR(hiredate, 'yy/mm/dd dy') from emp; --80/12/17 수
SELECT TO_CHAR(sysdate, 'yyyy/mm/dd, hh24 : mi : ss') from dual; -- 2021/12/09, 12 : 22 : 08
SELECT TO_CHAR(1230000) from dual; -- 숫자를 문자열로 변환
SELECT ename, sal, TO_CHAR(sal, 'L999,999'), TO_CHAR(sal, 'L000,000') FROM emp; -- '0' 자리수가 맞지 않으면 0으로 채움, '9'는 채우지 않음, 'L' 각지열별 통화

-- TO_DATE 많이쓰임
SELECT ename, hiredate FROM emp WHERE hiredate=TO_DATE(19810220, 'yyyymmdd'); -- 숫자로 이루어진 날짜를 문자로 반환

-- TO_NUMBER
SELECT TO_NUMBER('20,000', '99,999') - To_NUMBER('10,000', '99,999') FROM DUAL; -- 특정문자를 숫자로 변환

SELECT * FROM emp;

-- 숫자와 null에 대하여 산술연산하면 결과값이 null이 나옴
SELECT ename, sal, comm, sal*12+NVL(comm, 0) 연봉 FROM EMP; -- NVL 함수: null value의 약어로 null일때 default 값 설정

-------------------------------------------------------------
-- 그룹함수
SELECT SUM(comm) FROM EMP;  -- SUM: 속성 값의 총 합, NULL인 경우 0으로 변환 후 계산
SELECT TRUNC(AVG(sal), 2) FROM EMP; -- AVG: 속성 값의 평균 구하기
SELECT MAX(comm) FROM EMP;  -- MAX: 속성 값중 최대값 구하기
SELECT MIN(comm) FROM emp;  -- MIN: 속성 값 중 최소값 구하기
SELECT COUNT(comm) FROM EMP; -- COUNT: 속성값이 NULL을 제외한 속성의 개수, 중복 포함
SELECT COUNT(job), COUNT(DISTINCT job) FROM emp;
SELECT MAX(hiredate) 최근입사일자, MIN(hiredate) 최초입사일자 FROM emp; -- DATE타입에도 집계함수 사용 가능

-- GROUP BY
SELECT deptno FROM EMP GROUP BY deptno;
SELECT deptno, TRUNC(avg(sal), 2) FROM EMP GROUP BY deptno;
SELECT ename, deptno, TRUNC(avg(sal), 2) FROM EMP GROUP BY deptno; -- 안됨, 나타내고자 하는 행의 갯수가 속성별로 다르기 때문
SELECT deptno, TRUNC(avg(sal), 2), MAX(sal), MIN(sal), COUNT(*) FROM EMP GROUP BY deptno; -- 집계함수를 여러개 사용 가능
SELECT deptno, TRUNC(avg(sal), 2) FROM emp GROUP BY deptno HAVING AVG(sal) >= 2000;
SELECT deptno, MAX(sal), MIN(sal) FROM emp GROUP BY deptno HAVING MAX(sal) >= 2900;

---------------------------------------------------------------------------
-- JOIN
SELECT dept.dname from dept, emp where dept.deptno=emp.deptno AND emp.ename ='SCOTT';
SELECT dname FROM emp e FULL OUTER JOIN dept d ON e.deptno = d.deptno where e.ename ='SCOTT';

SELECT E.ename, D.dname, E.deptno, D.deptno FROM emp E, dept D WHERE E.deptno= D.deptno;   -- 테이블 약어

SELECT e.ename, e.sal FROM emp e FULL OUTER JOIN dept d ON d.deptno = e.deptno WHERE d.loc='NEW YORK';
SELECT e.ename, e.hiredate FROM emp e FULL OUTER JOIN dept d ON d.deptno = e.deptno WHERE d.dname='ACCOUNTING';
SELECT e.ename, d.dname FROM emp e FULL OUTER JOIN dept d ON d.deptno = e.deptno WHERE e.job='MANAGER';

SELECT * FROM salgrade;
SELECT ename, sal, grade FROM emp, salgrade where sal between losal AND hisal;
SELECT ename, dname, sal, grade FROM emp, dept, salgrade where emp.deptno=dept.deptno AND sal between losal AND hisal;

-- SELF JOIN: 본인 table을 본인이 join하는 것
SELECT e.ename || '의 매니저는 ' || m.ename || '입니다.' FROM emp e, emp m WHERE e.mgr=m.empno;
SELECT * FROM emp e, emp m WHERE e.mgr = m.empno;
-- 매니저가 KING인 사원들의 이름과 직급을 출력하시오.
SELECT e.ename, e.job, e.mgr FROM emp e, emp m WHERE e.mgr = m.empno  AND m.ename = 'KING';
-- SCOTT과 동일한 근무지에서 근무하는 사원의 이름을 출력하시오.
SELECT m.ename FROM emp e, emp m WHERE e.deptno = m.deptno AND e.ename='SCOTT' AND e.ename <> m.ename;

-- LEFT OUTER JOIN
SELECT e.ename || '의 매니저는 ' || m.ename || '입니다.' FROM emp e, emp m WHERE e.mgr=m.empno(+);
SELECT e.ename || '의 매니저는 ' || m.ename || '입니다.' FROM emp e LEFT OUTER JOIN emp m ON e.mgr=m.empno;

-- ANSI JOIN 예제
-- 1. CROSS JOIN (Cartesian Product)
SELECT * FROM emp CROSS JOIN dept;
-- 2. INNER JOIN (EUQI-JOIN 과 같다)
SELECT * FROM emp INNER JOIN dept ON emp.deptno=dept.deptno WHERE emp.ename='SCOTT';
SELECT * FROM emp INNER JOIN dept USING (deptno) WHERE emp.ename='SCOTT';
-- 3. Natural Join (동일한 속성을 찾아 EUQI JOIN의 결과로 나타내고 두개인 DEPTNO 속성을 한개로 줄여서 나타냄)
SELECT * FROM emp NATURAL JOIN dept;
