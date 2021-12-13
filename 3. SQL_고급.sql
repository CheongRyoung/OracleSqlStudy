-- 부속질의
-- 박지성에 대한 group by를 적용한 효과
SELECT SUM(salesprice) FROM orders WHERE custid = (
    SELECT custid FROM customer WHERE customer.name='박지성');

-- 1) Select에서 사용하는 부속질의(Scalar 부속질의)
-- group by 결과로 나온 각행들에 대하여 select문에서 부속질의를 실행하여 이름을 가져옴
-- equi-join으로 name을 가져올 수도 있음
SELECT custid, (SELECT name FROM customer cs WHERE cs.custid=od.custid), SUM(salesprice) FROM orders od GROUP BY custid;

-- 2) Inline view (from에서 부속질의를 사용하여 table처럼 보이기 때문에 inline view라고 함)
SELECT cs.name, SUM(od.salesprice) "total" From(SELECT custid, name From customer WHERE custid <=2) cs, orders od
WHERE cs.custid = od.custid
GROUP BY cs.name;

-- 중첩질의
SELECT orderid, salesprice From orders WHERE salesprice <= (SELECT avg(salesprice) from orders);
SELECT orderid, custid, salesprice From orders WHERE salesprice > (SELECT avg(salesprice) from orders);

-- ALL (속성값중에 최대값보다 크면)
-- 예제) salesprice > ALL (속성값1, 속성값2, 속성값3, ..) -> salesprice가 집합()안에 있는 모든 속성값보다 크면 true
-- SOME(ANY): SOME, ANY는 똑같은 의미이고 IN과 동일한 기능 (속성값중 최소값보다 크면)
SELECT orderid, salesprice FROM orders WHERE salesprice > ALL(SELECT salesprice FROM orders  WHERE custid='3');
SELECT orderid, salesprice FROM orders WHERE salesprice > (SELECT max(salesprice) FROM orders  WHERE custid='3');

SELECT orderid, salesprice FROM orders WHERE salesprice > ANY(SELECT salesprice FROM orders  WHERE custid='3');
SELECT orderid, salesprice FROM orders WHERE salesprice > (SELECT min(salesprice) FROM orders  WHERE custid='3');

-- EXISTS, NOT EXISTS
-- 1) 사용문법 WHERE EXISTS (subquery), WHERE NOT EXISTS (subquery)
-- 2) 해당 행이 존재하면 true
-- 3) 기능은 IN, ANY(SOME)와 동일
SELECT SUM(salesprice) "total" FROM orders od WHERE EXISTS (SELECT * FROM customer cs WHERE address LIKE '%대한민국%' AND cs.custid=od.custid);

-- ROWNUM: Oracle에서 table 생성후, row를 insert할 때 마다 내부적으로 관리하는 순차 번호
SELECT ROWNUM "순번", custid, name, phone FROM customer WHERE ROWNUM <=2;

-- book table에서 price가 가장 작은 2개의 책을 선택하고 싶음
SELECT rownum, book.* FROM book;
-- 1) order by를 적용해서 오름차순으로 sorting했지만, price가 가장 작은 2개 책을 선택 불가능
SELECT rownum, book.* FROM book ORDER BY price;

SELECT * FROM (SELECT * FROM BOOK ORDER BY price) b WHERE ROWNUM <= 2;
-- from 다음에 select를 사용하여 새로운 inline view table을 생성하면 rownum이 view table기준으로 새로 생성됨
SELECT rownum, b.* FROM (SELECT * FROM BOOK ORDER BY price) b;

-- 책값(price)이 가장 큰 1~3위 까지의 행을 선택하시오.
SELECT * FROM (SELECT * FROM book order by price desc) WHERE rownum <= 3;