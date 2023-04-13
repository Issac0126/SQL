
-- 집합 연산자
-- UNION (합집합 중복x), UNION ALL(합집합 중복 o), INTERSECT(교집합), MINUS(차집합)
-- 위 아래 column 개수와 데이터 타입이 정확히 일치해야 한다.

SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION --합집합(중복X)
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20;
-----------------------------------------
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
UNION ALL --합집합(중복O)
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20;
------------------------------------------
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
INTERSECT --교집합
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20;
------------------------------------------
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%'
MINUS --차집합
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20;

SELECT
    employee_id, first_name
FROM employees
WHERE department_id = 20
MINUS --차집합
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date LIKE '04%';















