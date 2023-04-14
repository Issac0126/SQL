
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


/*
문제 1.
사원 테이블에서 JOB_ID별 사원 수를 구하세요.
사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요
*/
SELECT
    job_id || ': ' || COUNT(*) as 사원수,
    AVG(salary) AS 평균월급
FROM employees
Group By job_id
ORDER By 평균월급 DESC;

/*
문제 2.
사원 테이블에서 입사 년도 별 사원 수를 구하세요.  
Hint: TO_CHAR() 함수를 이용해서 년도만 변환합니다. 그리고 그것을 그룹화 합니다.
*/
SELECT
    TO_CHAR(hire_date, 'YYYY') as 입사년도,
    count(*)
FROM employees
Group by TO_CHAR(hire_date, 'YYYY')
ORDER BY TO_CHAR(hire_date, 'YYYY') ASC;

SELECT
    *
FROM employees;

/*
문제 3.
급여가 5000 이상인 사원들의 부서별 평균 급여를 출력하세요.
단 부서 평균 급여가 7000이상인 부서만 출력
*/
SELECT
    department_id,
    Floor(AVG(salary)) as 평균급여
FROM employees
WHERE salary >= 5000
Group By department_id
HAVING AVG(salary) >= 7000;

/*
문제 4.
사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
조건 2) 평균은 소수 2째 자리에서 절삭 하세요
*/
SELECT
    department_id,
    trunc(AVG(salary + (salary*commission_pct)), 2) as 평균,
    SUM(salary + (salary*commission_pct)) as 합계,
    COUNT(*) as 카운트
FROM employees
WHERE commission_pct is not null
Group by department_id;













