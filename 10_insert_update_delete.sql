-- insert
-- 테이블 구조 확인
DESC departments;


SELECT * FROM departments; -- 전체 확인용
ROLLBACK; -- 실행 시점을 다시 뒤로 되돌리는 키워드

-- INSERT의 첫번째 방법 (모든 컬럼 데이터를 한 번에 지정)
INSERT INTO departments
VALUES(290, '영업부', 100, 2300); 


-- INSERT의 두 번째 방법 (직접 컬럼을 지정하고 저장, NOT NULL 확인 필수!
INSERT INTO departments
    (department_id, department_name, location_id)
VALUES
    (280, '개발자', 1700); --not null을 채워주지 않으면 들어가지 않으니 주의




-- 사본 테이블 생성
-- 사본 테이블을 생성할 때 그냥 생성하면 -> 조회된 데이터까지 모두 복사
-- WHERE절에 false값 (1=2) 지정하면 -> 테이블의 구조만 복사. 데이터는 X
CREATE TABLE managers AS
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1 = 2); 
-- 해석: managers라는 테이블을 만들건데 employees에서 이것들을 떼서 만들 것이다. 


SELECT * FROM managers;
DROP TABLE managers;


-- INSERT (서브쿼리)
INSERT INTO managers
(SELECT employee_id, first_name, job_id, hire_date
FROM employees); 



-----------------------------------------------------------------

-- UPDATE
CREATE TABLE emps AS (SELECT * FROM employees);
SELECT * FROM emps; --조회하기

/*
CTAS를 사용하면 제약 조건은 NOT NULL 말고는 복사되지 않는다.
구조&데이터&NOT NULL -> 복사.

제약조건은 업무 규칙을 지키는 데이터만 저장하고, 
그렇지 않은 것들이 DB에 저장되는 것을 방지하는 목적으로 사용한다.
*/
















