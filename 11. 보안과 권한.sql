-- 정보 보안(Information Security)
-- 핵심 키워드
-- 1)Authentication(시스템 사용 인증, login ID와 password로 관리)
-- 2)Authorization(시스템 사용 권한) => 사용자마다 시스템을 사용할 수 있는 화면, 권한이 다 틀림
--   예로, 사원의 가족 정보 등 인사정보를 수정할 수 있는 권한은 인사팀의 특정 몇몇 사람들에게만 부여

-- oracle
-- 1) Authentication: madang user가 있으면 password를 madang으로 입력해야지만 madang DB사용 가능
-- 2) Authorization: Table마다 insert, update, select emd 개별 커맨드 사용 권한을 부여 가능

-- 1. 사용자 생성하기 전에 table space 생성하기
-- sys 또는 system에서 table space 생성가능
-- md_tbs: table space이름
-- Oracle이 설치되어 있는 서브 디렉토리에 database로 사용할 file을 신규 생성
CREATE TABLESPACE MD_TBS
    DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\md_tbs_data01.dbf'
    SIZE 10M;
-- 구글에 oracle tablespace 생성 검색하면 자료 획득
CREATE TABLESPACE MD_TEST
    DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\md_TEST_data01.dbf'
    SIZE 10M;
-- Tablespace data 삭제
DROP TABLESPACE md_test INCLUDING CONTENTS AND DATAFILES;

-- user 생성하기
drop user mdguest;
Create user mdguest IDENTIFIED BY mdguest;
Create user mdguest2 identified by mdguest2 default tablespace md_tbs;
-- mdguest에 오라클에 로그인 할 수 있는 권한(connect), 테이블 등 생성권한(resorce) 부여
-- 권한: authorization
-- SYS가 mdguest 사용자에게 connect, resource 권한을 부여
GRANT CONNECT, RESOURCE TO MDGUEST;
GRANT CONNECT, RESOURCE TO MDGUEST2;

-- SQL명령어: DDL(CREATE, ALTER, TRUNCATE, DROP), DML(INSERT, UPDATE, DELETE, SELECT), DCL
-- DCL (DATA CONTROL LANGUAGE): GRANT(부여), REVOKE(취소)

-- MADANG 사용자로 변경
-- madang 사용자가 mdguest 사용자에게 book 테이블의 select 명령어만 사용할 수 있는 권한을 부여
GRANT SELECT ON BOOK TO mdguest;
-- madang 사용자가 mdguest 사용자에게 customer 테이블의 select, update 명령어만 사용할 수 있는 권한을 부여
GRANT SELECT, UPDATE ON CUSTOMER TO MDGUEST WITH GRANT OPTION;

select * from madang.book;
select * from madang.orders;

-- MDGUEST가 MADANG으로 부여받은 BOOK TABLE의 SELECT 권한을 MDGUEST2에 줄때 권한 부족으로 에러 발생
GRANT SELECT ON MADANG.BOOK TO MDGUEST2;
-- 에러발생: 01031. 00000 -  "insufficient privileges"

-- MDGUEST가 MADANG으로 부터 부여받은 CUSTOMER TABLE의 SELECT권한을 MDGUEST2에 부여 가능
GRANT SELECT ON MADANG.CUSTOMER TO MDGUEST2;
-- MDGUEST에게 CUSTOMER TABLE 권한을 부여할 때 'WITH GRANT OPTION' 추가했기 때문.
-- GRANT SELECT, UPDATE ON CUSTOMER TO MDGUEST WITH GRANT OPTION; 

-- MADANG사용자가 모든 권한을 부여
GRANT SELECT ON ORDERS TO PUBLIC;

-- REVOKE: 권한 철회
-- MADANG이 MDGUEST에게 BOOK테이블의 SELECT 사용 권한을 철회
REVOKE SELECT ON BOOK FROM MDGUEST;
-- WITH GRANT OPTION를 부여 받은 USER가 다른 USER에게 GRANT를 했던 권한도 모두 철회된다.
REVOKE SELECT ON CUSTOMER FROM MDGUEST;

-- ORACLE DATABASE 사용자를 GROUPING이 가능함
-- 예를 들면, DBA, IT개발자, POWER USER, 일반사용자
-- DBA: 모든 권한을 부여(1사람에게 부여)
-- IT개발자: DATA BASE 생성, 등 몇가지 권한을 제외한 모든 권한 부여
-- POWER USER: 일부 테이블만 UPDATE 가능, 특정 몇개 테이블을 제외한 모든 테이블에 SELECT 권한 부여
-- 일반 사용자: 몇 개의 테이블에 대해서만 SELECT 권한 부여

-- SYS또는 SYSTEM 계정으로 이동
-- ROLE 생성하는 것은 SYS또는 SYSTEM에서만 가능
CREATE ROLE PROGRAMMER;
-- ROLE PROGRAMMER에게 TABLE, VIEW 생성권한 부여
GRANT CREATE ANY TABLE, CREATE ANY VIEW TO PROGRAMMER;
-- MDGUEST 사용자에게 PROGRAMMER 역할(ROLE)을 부여
GRANT PROGRAMMER TO MDGUEST;

        -- MDGUEST2 사용자에 속하는 NEWTABLE이라는 이름의 테이블을 생성
        CREATE TABLE MDGUEST2.NEWTABLE(
            MYNAME VARCHAR2(40),
            MYPHONE VARCHAR2(20)
        );
GRANT SELECT, INSERT ON MDGUEST2.NEWTABLE TO PROGRAMMER;  -- ROLE에 해당 테이블 권한 부여
INSERT INTO MDGUEST2.NEWTABLE(MYNAME, MYPHONE) VALUES('홍길동','000-000-0100');
        -- 본인이 속한 TABLE 생성은 당연히 가능
        CREATE TABLE NEWTABLE(
            MYNAME VARCHAR2(40),
            MYPHONE VARCHAR2(20)
        );
        
-- ROLE 삭제
DROP ROLE PROGRAMMER;