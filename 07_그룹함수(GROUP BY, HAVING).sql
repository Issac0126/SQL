
-- 그룹 함수 AVG, MAX, MIN, SUM, COUNT 
-- 위의 함수는 모두 그룹이 필요하다. 

--SELECT 
--    AVG(salary), 
--    MAX(salary),
--    MIN(salary),
--    SUM(salary),
--    COUNT(salary)
--FROM employees;

SELECT COUNT(*) FROM employees; -- 총 행 데이터의 수
SELECT COUNT(first_name) FROM employees;
SELECT COUNT(commission_pct) FROM employees; --null이 아닌 행의 수
SELECT COUNT(manager_id) FROM employees; --null이 아닌 행의 수


--부서별로 그룹화, 그룹함수의 사용

SELECT
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id;

--주의할 점
--그룹 합수는 일반 컬럼과 동시에 그냥 출력할 수는 없다.
--또한, GROUP BY절을 사용할 때, GROUP절에 묶이지 않으면 다른 컬럼을 조회할 수 없다.
SELECT
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id; --에러


-- GROUP BY절 두 번 실행하기
SELECT
    job_id,
    department_id,
    AVG(salary)
FROM employees
GROUP BY department_id, job_id --에러
ORDER BY department_id;

-- GROUP BY를 통해 그룹화를 할 때 조건을 걸 경우 HAVING을 사용
SELECT
    department_id,
    AVG(salary),
    SUM(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 100000; --월급의 합이 100,000이 넘는 부서만 그룹화

SELECT
    job_id,
    COUNT(*)
FROM employees
GROUP BY job_id
HAVING COUNT(*) >= 5; --직업을 가진 사람이 20명 이상인 직업만 출력

-- 부서 아이디가 50 이상인 것들을 그룹화 시키고, 그룹 월급 평균이 5000 이상만 조회
-- 그룹화 전에 미리 부서 아이디 50을 거르고, (WHERE)
-- 그룹화 이후에 월급 평균이 5000이상을 조회한다. (HAVING)
SELECT
    department_id,
    AVG(salary) AS 평균
FROM employees
WHERE department_id >= 50
GROUP BY department_id
HAVING AVG(salary) >= 5000
ORDER BY department_id DESC;
















