-- 1) Customer Table의 모든 행 정보 가져오기
SELECT * FROM customer;
-- 2) Customer Table에서 name이 김연아인 row(행)을 가져오기 (selection), where 조건문에서 실행
SELECT * FROM customer where name='김연아';
-- 3) Customer Table에서 name이 김연아인 row(행)에서 전화번호 정보만 가져오기
SELECT phone
FROM customer
WHERE name='김연아';

select bookname, price from book;
select price, bookname from book;
select bookid, bookname, publisher, price from book;
select * from book;   -- '*' 는 릴레이션의 모든 속성을 가져오라는 의미

select publisher from book;
-- distinct 속성 값의 중복 제거
select distinct publisher from book;

-- where 절 조건 (어디에 있는 튜플이 조건에 맞나~)
select * from book where price<20000;
-- where 속성명 between a and b (a보다 크거나 같고, b보다 작거나 같은 범위)
select * from book where price between 10000 and 20000;
select * from book where price >= 10000 and price <= 20000;
-- where 속성명 IN('A', 'B'); (속성명의 값이 A또는 B인 튜플만 반환)
-- ('A', 'B') => 집합
-- where조건문에서 행(row)이 선택되는 기준 => 행마다 where 조건문의 결과가 true이면 결과를 보여줌
select * from book where publisher in('굿스포츠', '대한미디어', '삼성당');
select * from book where publisher = '굿스포츠' or publisher = '대한미디어';
-- where 속성명 NOT IN('A', 'B'); (속성명의 값이 A또는 B가 아닌 튜플만 반환)
select * from book where publisher not in('굿스포츠', '대한미디어');
-- where 속성명 like 'A' (속성명의 값이 A인 튜플만 반환)
select bookname, publisher from book where bookname Like '축구의 역사';
-- where 속성명 like '%A%' (속성명의 값에 A가 포함된 튜플만 반환)
-- '%': %에 어떠한 글자가 와도 된다는 의미 ('%' 하나에 0개 이상의 글자)
select bookname, publisher from book where bookname like '%축구%';
select bookname, publisher from book where bookname like '%야구%';
-- where 속성명 like '_A%' (속성명의 값 두번째 글자가 A인 튜플만 반환)
-- '_': '_'에 어떠한 글자가 와도 된다는 의미 ('_' 하나에 한글자)
select * from book where bookname like '_의%';
-- equal과 like의 차이 equal은 같은 값을 가져오고, like는 와일드 문자를 사용해 비슷한 문자를 가져올 수 있다.

select * from book where bookname like '%축구%' and price >= 20000;
select * from book where publisher ='굿스포츠' or publisher = '대한미디어';

-- ORDER BY 속성명; (속성명의 값을 오름차순 기준으로 반환)
-- ORDER BY A, B; (A 속성값 기준으로 오름차순, 같은 경우 B속성값 기준으로 정렬)
select * from book order by price;
select * from book order by price, publisher;
-- DESC(DESCENDING ORDER):내림차순, ASC(ASCENDING ORDER):오름차순
-- ASC가 기본, 생략 가능
select * from book order by price DESC, publisher ASC;
select * from book order by price DESC, publisher;

-- 집계함수 sum(속성명): 전체 행의 값을 모두 합한 값
select sum(salesprice) from orders;
-- sum(disinct 속성명): 속성명 값의 중복을 제외한 집계함수 결과를 반환
select sum(distinct salesprice) from orders;
-- sum(속성명)은 속성명의 타입이 숫자만 올 수 있다.
select sum(orderdate) from orders;  -- 에러 date 타입 사용 불가--
-- 출력 되는 열이름을 변경하고 싶으면 AS 키워드 사용
select sum(salesprice) as "총 매출" from orders; -- 띄어쓰기 할려면 "A A" 로 묶기
-- where 조건을 포함한 총 합 계산 가능
select sum(salesprice) as "총 매출" from orders where custid=2;
select sum(salesprice) as "총 매출",  -- 총합을 구하는 집계함수
        avg(salesprice) as "총 평균", -- 평균값 구하는 집계함수
        min(salesprice) as "최소 매출건", -- 최소값 구하는 집계함수
        max(salesprice) as "최대 매출건"  -- 최대값 구하는 집계함수
from orders;

select count(*) as "총 개수" from orders; -- 행의 갯수 구하는 집계함수

-- 2021-12-08 --
-- SQL 실행에러 원인: custid는 4개이상의 행이 필요한데, count, sum은 한 개의 행만 생성하기 때문
-- select 문에서 속성으로 집계함수를 사용할 할 때, 일반 속성과 함께 사용하면 안된다.
-- 단, group by로 지정된 속성은 집계함수와 같이 사용할 수 있음
select custid, count(*) as 도서수량, sum(salesprice) as "총 액" from orders;
-- 특정 속성 내의 값 별로 집계함수를 사용하기 위해서는 'group by 특정속성' 을 통해 반환
select custid, count(*) as 도서수량, sum(salesprice) as "총 액" from orders group by custid;
-- group by + 속성이름: 속성이름으로 그룹핑, 집계함수와 같이 많이 사용
-- having: group by 결과 행들에 대하여 where 처럼 행들을 선택할때 사용, group by 키워드 없이 단독 사용 불가
select custid, count(*) as "도서수량" from orders where salesprice >= 8000 group by custid having COUNT(*)>=2;

-- cartesian product, join
select * from customer, orders;
select * from customer, orders where orders.custid = customer.custid;
select * from customer, orders where orders.custid = customer.custid order by customer.custid;
select name, salesprice from customer, orders WHERE orders.custid = customer.custid;
select customer.custid, customer.name, sum(salesprice) as "총 판매액" from customer,orders where orders.custid = customer.custid group by customer.custid, customer.name order by customer.custid;
-- group by에서 속성이름이 여러개 나올 경우의 의미: 첫번째 속성으로 그룹핑하고, 그룹핑 결과내에서 두번째 속성으로 다시 소그룹으로 그룹핑함

select name, bookname from customer, orders, book where orders.custid = customer.custid and orders.bookid = book.bookid;
select name, bookname from customer, orders, book where orders.custid = customer.custid and orders.bookid = book.bookid and book.price = 20000;

-- ANSI JOIN, OUTER JOIN: 자연조인시 조인에 실패한 투플을 모두 보여주되 값이 없는 대응 속성에는 NULL값을 채워서 반환
-- LEFT OUTER JOIN
SELECT name, salesprice from customer LEFT OUTER join orders on orders.custid = customer.custid; 
SELECT customer.name, salesprice FROM customer, orders where customer.custid = orders.custide(+);
-- RIGHT OUTER JOIN
SELECT name, salesprice from customer right outer join orders on orders.custid = customer.custid;
SELECT customer.name, salesprice FROM customer, orders where customer.custid(+) = orders.custide;
-- FULL OUTER JOIN
SELECT name, salesprice from customer FULL OUTER JOIN orders ON orders.custid = customer.custid;
SELECT customer.name, salesprice FROM customer, orders where customer.custid = orders.custide;

-- 부속질의 (sub query): SELECT안에 SELECT문을 사용하는 경우, 포함된 SELECT문을 말함, 사용: SELECT, FROM, WHERE 모두 사용 가능
SELECT bookname FROM book WHERE price = (SELECT MAX(price) from book);
-- (SELECT MAX(price) from book)은 35000과 같음
SELECT * FROM book;
SELECT name FROM customer where custid in(select custid from orders where bookid in(select bookid from book where publisher = '대한미디어'));
SELECT name FROM customer, book, orders where customer.custid=orders.custid and orders.bookid = book.bookid and book.publisher = '대한미디어';

-- 상관 부속질의
-- b1, b2: book의 별명(alias)
select b1.bookname , b1.publisher
from book b1 
where b1.price > (select avg(b2.price) from book b2 where b2.publisher = b1.publisher); 

-- 차집합
select name from customer minus select name from customer where custid in(select custid from orders);

-- EXISTS: 뒤 문항이 존재하면 가져오고 존재하지 않으면 가져오지 않음
select name, address from customer cs where exists (select * from orders od where cs.custid = od.custid);
select name, address from customer where custid in(select custid from orders);