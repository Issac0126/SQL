
/*
view는 제한적인 자료만 보기 위해 사용하는 가상 테이블의 개념.
뷰는 기본 테이블로 유도된 가상 테이블이기 때문에
필요한 컬럼만 저장해 두면 관리가 용이해진다.

뷰는 가상테이블로 실제 데이터가 물리적으로 저장된 형태는 아니다.
뷰를 통해서 데이터에 접근하면 원본 데이터는 안전하게 보호될 수 있다.
*/

SELECT * FROM user_sys_privs; --권한 확인

-- 단순 뷰
-- 뷰의 컬럼 이름으로 함수 같은 가상표현식은 불가능하다.
SELECT 
    employee_id,
    first_name || ' ' || last_name,
    job_id,
    salary
FROM employees
WHERE department_id = 60;


CREATE VIEW view_emp AS ( 
    SELECT 
    employee_id,
    first_name || ' ' || last_name AS fullname,
    job_id,
    salary
FROM employees
WHERE department_id = 60
);

SELECT * FROM view_emp;


-- 복합 뷰
-- 여러 테이블을 조인하여 필요한 데이터만 저장하고 빠른 확인을 위해 사용
CREATE VIEW view_emp_dept_jobs AS (
    SELECT 
        e.employee_id,
        e.first_name || ' ' || last_name AS fullname,
        d.department_name,
        j.job_title
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

SELECT * FROM view_emp_dept_jobs;


-- 뷰의 수정 (CREATE OR REPLACE VIEW 구문)
-- 동일 이름으로 해당 구문을 사용하면 데이터가 변경되면서 새롭게 생성된다.
CREATE OR REPLACE VIEW view_emp_dept_jobs AS (
    SELECT 
        e.employee_id,
        e.first_name || ' ' || last_name AS fullname,
        d.department_name,
        j.job_title,
        e.salary -- 추가
    FROM employees e
    LEFT JOIN departments d
    ON e.department_id = d.department_id
    LEFT JOIN jobs j
    ON e.job_id = j.job_id
)
ORDER BY employee_id ASC;

SELECT
    job_title,
    AVG(salary)
FROM view_emp_dept_jobs
GROUP BY job_title
ORDER BY AVG(salary) DESC; -- SQL 구문이 확실히 짧아짐.


-- 뷰의 삭제
DROP VIEW view_emp;


/*
VIEW에 INSERT가 일어나는 경우 실제 테이블에도 반영이 된다.
그래서 VIEW의 INSERT, UPDATE, DELETE는 많은 제약사항이 따른다.
원본 테이블이 NOT NULL인 경우 VIEW에 INSERT가 불가능하다.
VIEW에서 사용하는 컬럼이 가상열인 경우에도 불가능.
*/

-- 두 번째 컬럼인 'fullname'은 가상열(virtual column)이기 떄문에 INSERT가 안 된다.
INSERT INTO view_emp_dept_jobs
VALUES(300, 'fullname','test','jobtitle',10000);

-- 그렇다면 가상열 빼고 하자!
-- 복합뷰(JOIN된 뷰)의 경우 한 번에 수정할 수 없다. 
INSERT INTO view_emp_dept_jobs 
    (employee_id, department_name, job_title, salary)
VALUES(300, 'test','jobtitle',10000);


-- 그렇다면 단일뷰 수정하자!
-- 원본 테이블의 null을 허용하지 않는 컬럼 때문에 들어갈 수 없다. 
-- 그냥 웬만하면 INSERT는 하지 말자......
INSERT INTO view_emp 
    (employee_id, job_id, salary)
VALUES(300, 'jobid', 10000);


-- WITH CHECK OPTION -> 조건 제약 컬럼
-- 조건에 사용되어진 컬럼값은 뷰를 통해서 변경할 수 없게 해주는 키워드
CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
        employee_id, first_name, last_name, email, 
        hire_date, job_id, department_id
    FROM employees
    WHERE department_id = 60
)
WITH CHECK OPTION CONSTRAINT view_emp_test_ck;

SELECT * FROM view_emp_test;
SELECT * FROM employees;

UPDATE view_emp_test
SET department_id = 100
WHERE employee_id = 106;


-- 읽기 전용 뷰 -> WITH READ ONLY
CREATE OR REPLACE VIEW view_emp_test AS (
    SELECT
        employee_id, first_name, last_name, email, 
        hire_date, job_id, department_id
    FROM employees
    WHERE department_id = 60
)
WITH READ ONLY;


UPDATE view_emp_test
SET job_id = 'test'
WHERE employee_id = 106;















