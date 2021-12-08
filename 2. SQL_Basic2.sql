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
