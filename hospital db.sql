CREATE TABLESPACE HOSPT_TBS
    DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\HOSPT_TBS.dbf'
    SIZE 20M;
DROP TABLESPACE HOSPT_TBS INCLUDING CONTENTS AND DATAFILES;

CREATE USER U_HOSPITAL IDENTIFIED BY U_HOSPITAL DEFAULT TABLESPACE HOSPT_TBS;
GRANT CONNECT, RESOURCE TO U_HOSPITAL;
CONNECT U_HOSPITAL/U_HOSPITAL;
GRANT CREATE ANY EDITION, DROP ANY EDITION to U_HOSPITAL;

CREATE TABLE DOCTORS (
    DOC_ID NUMBER(10) NOT NULL,
    MAJOR_TREAT VARCHAR2(25) NOT NULL,
    DOC_NAME VARCHAR2(20) NOT NULL,
    DOC_GEN CHAR(1) NOT NULL,
    DOC_PHONE VARCHAR2(15),
    DOC_EMAIL VARCHAR2(50) UNIQUE,
    DOC_POSITION VARCHAR2(20) NOT NULL
    );
 ALTER TABLE DOCTORS ADD CONSTRAINT  DOC_ID_PK PRIMARY KEY(DOC_ID); -- 튜플 CONSTRAINT 추가
 ALTER TABLE DOCTORS MODIFY DOC_ID CONSTRAINT DOC_ID_PK PRIMARY KEY;  -- 튜플 CONSTRANIT 수정

CREATE TABLE NURSES(
    NUR_ID NUMBER(10) NOT NULL,
    MAJOR_JOB VARCHAR2(25) NOT NULL,
    NUR_NAME VARCHAR2(20) NOT NULL,
    NUR_GEN CHAR(1) NOT NULL,
    NUR_PHONE VARCHAR2(15),
    NUR_EMAIL VARCHAR2(50) UNIQUE,
    NUR_POSITION VARCHAR2(20) NOT NULL
);
ALTER TABLE NURSES MODIFY NUR_ID CONSTRAINT NUR_ID_PK PRIMARY KEY;

CREATE TABLE PATIENTS(
    PAT_ID NUMBER(10) NOT NULL,
    NUR_ID NUMBER(10) REFERENCES NURSES(NUR_ID),
    DOC_ID NUMBER(10) NOT NULL,
    PAT_NAME VARCHAR2(20) NOT NULL,
    PAT_GEN CHAR(1) NOT NULL,
    PAT_JUMIN VARCHAR2(14) NOT NULL,
    PAT_ADDR VARCHAR2(100) NOT NULL,
    PAT_PHONE VARCHAR2(15),
    PAT_EMAIL VARCHAR2(50) UNIQUE,
    PAT_JOB VARCHAR2(20) NOT NULL
);
ALTER TABLE PATIENTS ADD CONSTRAINT PAT_ID_PK PRIMARY KEY(PAT_ID);
ALTER TABLE PATIENTS ADD CONSTRAINT PATIENTS_DOC_ID_FK FOREIGN KEY(DOC_ID) REFERENCES DOCTORS(DOC_ID);  --참조키 추가,변경
ALTER TABLE PATIENTS MODIFY NUR_ID CONSTRAINT PATIENTS_NUR_ID_FK REFERENCES NURSES(NUR_ID);   -- 참조키 추가,변경

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS;   -- 제약확인
ALTER TABLE PATIENTS DROP CONSTRAINT SYS_C007134;   -- CONSTRAINT_NAME으로 삭제할 수 있다

CREATE TABLE TREATMENTS(
    TREAT_ID NUMBER(15) NOT NULL,
    PAT_ID NUMBER(10) NOT NULL,
    DOC_ID NUMBER(10) NOT NULL,
    TREAT_CONTENTS VARCHAR2(1000) NOT NULL,
    TREAT_DATE DATE NOT NULL
);
ALTER TABLE TREATMENTS ADD CONSTRAINT TREATMENTS_PK PRIMARY KEY(TREAT_ID, PAT_ID, DOC_ID);
ALTER TABLE TREATMENTS ADD CONSTRAINT TREATMENTS_PAT_FK FOREIGN KEY (PAT_ID) REFERENCES PATIENTS(PAT_ID);
ALTER TABLE TREATMENTS ADD CONSTRAINT TREATMENTS_DOC_FK FOREIGN KEY(DOC_ID) REFERENCES DOCTORS(DOC_ID);

CREATE TABLE CHARTS(
    CHART_ID VARCHAR2(20) NOT NULL,
    TREAT_ID NUMBER(15) NOT NULL,
    DOC_ID NUMBER(10) NOT NULL,
    PAT_ID NUMBER(10) NOT NULL,
    NUR_ID NUMBER(10) NOT NULL,
    CHART_CONTENTS VARCHAR2(1000) NOT NULL
);
ALTER TABLE CHARTS ADD CONSTRAINT CHARTS_PK PRIMARY KEY(CHART_ID, TREAT_ID, DOC_ID, PAT_ID);
ALTER TABLE CHARTS ADD CONSTRAINT C_T_ID_FK FOREIGN KEY(TREAT_ID, PAT_ID, DOC_ID) REFERENCES TREATMENTS(TREAT_ID, PAT_ID, DOC_ID);
-- 복합 기본 키일 경우에는 참조키로 선택시 하나가 아닌 전체를 넣어 주어야한다.
ALTER TABLE CHARTS ADD CONSTRAINT C_N_ID_FK FOREIGN KEY(NUR_ID) REFERENCES NURSES(NUR_ID);

SELECT * FROM doctors;
INSERT INTO DOCTORS values(980312, '소아과', '이태정', 'M', '010-333-1340', 'ltj@hambh.com', '과장');
INSERT INTO doctors values(000601, '내과', '안성기', 'M', '011-222-0987', 'ask@hambh.com', '과장');
INSERT INTO doctors values(001208, '외과', '김민종', 'M', '010-333-8743', 'kmj@hambh.com', '과장');
INSERT INTO doctors values(020403, '피부과', '이태서', 'M', '019-777-3764', 'lts@hambh.com', '과장');
INSERT INTO doctors values(050900, '소아과', '김연아', 'F', '010-555-3746', 'kya@hambh.com', '전문의');
INSERT INTO doctors values(050101, '내과', '차태현', 'M', '011-222-7643', 'cth@hambh.com', '전문의');
INSERT INTO doctors values(062019, '소아과', '전지현', 'F', '010-999-1265', 'jih@hambh.com', '전문의');
INSERT INTO doctors values(070576, '피부과', '홍길동', 'M', '016-333-7263', 'hgd@hambh.com', '전문의');
INSERT INTO doctors values(080543, '방사선과', '유재석', 'M', '010-222-1263', 'yjs@hambh.com', '과장');
INSERT INTO doctors values(091001, '외과', '김병만', 'M', '010-555-3542', 'kbm@hambh.com', '전문의');

SELECT * FROM nurses;
INSERT INTO nurses VALUES(050302, '소아과', '김은영', 'F', '010-555-8751', 'key@hambh.com', '수간호사');
INSERT INTO nurses VALUES(050021, '내과', '윤성애', 'F', '016-333-8745', 'yas@hambh.com', '수간호사');
INSERT INTO nurses VALUES(040089, '피부과', '신지원', 'M', '010-666-7646', 'sjw@hambh.com', '주임');
INSERT INTO nurses VALUES(070605, '방사선과', '유정화', 'F', '010-333-4588', 'yjh@hambh.com', '주임');
INSERT INTO nurses VALUES(070804, '내과', '라하나', 'F', '010-222-1340', 'rhn@hambh.com', '주임');
INSERT INTO nurses VALUES(071018, '소아과', '김화경', 'F', '019-888-4116', 'khk@hambh.com', '주임');
INSERT INTO nurses VALUES(100356, '소아과', '이선용', 'M', '010-777-1234', 'lsy@hambh.com', '간호사');
INSERT INTO nurses VALUES(104145, '외과', '김현', 'M', '010-999-8520', 'kh@hambh.com', '간호사' );
INSERT INTO nurses VALUES(120309, '피부과', '박성완', 'M', '010-777-4996', 'psw@hambh.com', '간호사');
INSERT INTO nurses VALUES(130211, '외과', '이서연', 'F', '010-222-3214', 'lsy2@hambh.com', '간호사');

SELECT * FROM PATIENTS;
INSERT INTO PATIENTS VALUES(2345, 050302, 980312, '안상건', 'M', 232345, '서울', '010-555-7845', 'ask@hambh.com', '회사원');
INSERT INTO PATIENTS VALUES(3545, 040089, 020403, '김성룡', 'M', 543545, '서울', '010-333-7812', 'ksr@hambh.com', '자영업');
INSERT INTO PATIENTS VALUES(3424, 070605, 080543, '이종진', 'M', 433424, '부산', '019-888-4859', 'ijj@hambh.com', '회사원');
INSERT INTO PATIENTS VALUES(7675, 100356, 050900, '최광석', 'M', 677675, '당진', '010-222-4847', 'cks@hambh.com', '회사원');
INSERT INTO PATIENTS VALUES(4533, 070804, 000601, '정한경', 'M', 744533, '강릉', '010-777-9630', 'jhk@hambh.com', '교수');
INSERT INTO PATIENTS VALUES(5546, 120309, 070576, '유원현', 'M', 765546, '대구', '016-777-0214', 'ywh@hambh.com', '자영업');
INSERT INTO PATIENTS VALUES(4543, 070804, 050101, '최재정', 'M', 454543, '부산', '010-555-4187', 'cjj@hambh.com', '회사원');
INSERT INTO PATIENTS VALUES(9768, 130211, 091001, '이진희', 'F', 119768, '서울', '010-888-3675', 'ljh@hambh.com', '교수');
INSERT INTO PATIENTS VALUES(4234, 130211, 091001, '오나미', 'F', 234234, '속초', '010-999-6541', 'onm@hambh.com', '학생');
INSERT INTO PATIENTS VALUES(7643, 071018, 062019, '송성묵', 'M', 987643, '서울', '010-222-5874', 'ssm@hambh.com', '학생');
DELETE FROM PATIENTS WHERE pat_id = 3425; 

select * from treatments;
INSERT INTO TREATMENTS VALUES(130516023, 2345, 980312, '감기몸살', '2013-05-16');
INSERT INTO TREATMENTS VALUES(130628100, 3545, 020403, '피부 트러블 치료', '2013-06-28');
INSERT INTO TREATMENTS VALUES(131205056, 3424, 080543, '목 디스크로 MRI 촬영', '2013-12-05');
INSERT INTO TREATMENTS VALUES(131218024, 7675, 050900, '중이염', '2013-12-18');
INSERT INTO TREATMENTS VALUES(131224012, 4533, 000601, '장염', '2013-12-24');
INSERT INTO TREATMENTS VALUES(140103001, 5546, 070576, '여드름 치료', '2014-01-03');
INSERT INTO TREATMENTS VALUES(140109026, 4543, 050101, '위염', '2014-01-09');
INSERT INTO TREATMENTS VALUES(140226102, 9768, 091001, '화상치료', '2014-02-26');
INSERT INTO TREATMENTS VALUES(140303003, 4234, 091001, '교통사고 외상치료', '2014-03-03');
INSERT INTO TREATMENTS VALUES(140308087, 7643, 062019, '장염', '2014-03-08');
delete from treatments where treat_id = 130109026;

select * from charts;
INSERT INTO CHARTS VALUES('p_130516023', 130516023, 980312, 2345, 050302, '감기주사 및 약 처방');
INSERT INTO CHARTS VALUES('d_130628100', 130628100, 020403, 3545, 040089, '피부 감염 방지 주사');
INSERT INTO CHARTS VALUES('r_131205056', 131205056, 080543, 3424, 070605, '주사 처방');
INSERT INTO CHARTS VALUES('p_131218024', 131218024, 050900, 7675, 100356, '귓속청소 및 약 처방');
INSERT INTO CHARTS VALUES('i_131224012', 131224012, 000601, 4533, 070804, '장염 입원치료');
INSERT INTO CHARTS VALUES('d_140103001', 140103001, 070576, 5546, 120309, '여드름 치료약 처방');
INSERT INTO CHARTS VALUES('i_140109026', 140109026, 050101, 4543, 070804, '위내시경');
INSERT INTO CHARTS VALUES('s_140226102', 140226102, 091001, 9768, 130211, '화상 크림약 처방');
INSERT INTO CHARTS VALUES('s_140303003', 140303003, 091001, 4234, 130211, '입원치료');
INSERT INTO CHARTS VALUES('p_140308087', 140308087, 062019, 7643, 071018, '장염 입원치료');

UPDATE doctors SET major_treat = '소아과' where doc_name = '홍길동';

alter table patients drop constraint PATIENTS_NUR_ID_FK;  -- 제약제거
alter table patients add constraint PATIENTS_NUR_ID_FK foreign key (nur_id) references nurses(nur_id) on DELETE set null;  -- 기본키 제거시 참조키 null값 변경

update patients set nur_id = 070605 where nur_id = 050302; -- 기본키 혹은 참조키인 값들을 변경
update charts set nur_id = 070605 where nur_id = 050302;  -- 기본키 혹은 참조키인 값들을 변경
delete from nurses where nur_name='김은영';

select * from doctors where major_treat = '소아과';
select * from patients, doctors where patients.doc_id = doctors.doc_id and doc_name='홍길동';
select * from treatments NATURAL JOIN patients where treatments.treat_date between '2013-12-01' and '2013-12-31' order by treatments.treat_date;
select * from nurses where nur_id like '5%';
