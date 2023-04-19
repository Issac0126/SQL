
SELECT *
FROM employees;


/*
문제 1.
-EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 데이터를 출력 하세요 ( AVG(컬럼) 사용)
-EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 수를 출력하세요
-EMPLOYEES 테이블에서 job_id가 IT_PROG인 사원들의 평균급여보다 높은 사원들을 데이터를 출력하세요*/
SELECT -- 1
    *
FROM employees
WHERE salary > (SELECT
                AVG(salary)
                FROM employees);
SELECT -- 2
    COUNT(*) || '명'
FROM employees
WHERE salary > (SELECT
                AVG(salary)
                FROM employees);

SELECT -- 3
    *
FROM employees
WHERE salary > (SELECT
                AVG(salary)
                FROM employees
                WHERE job_id = 'IT_PROG'
                );

/*
문제 2.
-DEPARTMENTS테이블에서 manager_id가 100인 사람의 department_id와
EMPLOYEES테이블에서 department_id가 일치하는 모든 사원의 정보를 검색하세요.*/
SELECT *
FROM employees
WHERE department_id IN (SELECT 
                            department_id
                        FROM departments 
                        WHERE manager_id = 100
                        );

/*
문제 3.
-EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 출력하세요
-EMPLOYEES테이블에서 “James”(2명)들의 manager_id와 같은 모든 사원의 데이터를 출력하세요.*/
SELECT * -- 1
FROM employees
WHERE manager_id > (
                    SELECT manager_id
                    FROM employees
                    WHERE first_name = 'Pat'
                );

SELECT * -- 2
FROM employees
WHERE manager_id IN (
                    SELECT manager_id
                    FROM employees
                    WHERE first_name = 'James'
                    );

/*
문제 4.
-EMPLOYEES테이블 에서 first_name기준으로 내림차순 정렬하고, 
41~50번째 데이터의 행 번호, 이름을 출력하세요*/

SELECT rn, first_name
FROM
    (
    SELECT ROWNUM AS rn, e.*
    FROM (SELECT *
            FROM employees
            ORDER BY first_name DESC) e
    )
WHERE rn > '40' AND rn <= '50';

/*
문제 5.
-EMPLOYEES테이블에서 hire_date기준으로 오름차순 정렬하고, 
31~40번째 데이터의 행 번호, 사원id, 이름, 번호, 입사일을 출력하세요.*/
SELECT rn, employee_id, first_name, phone_number, hire_date
FROM
    (
    SELECT ROWNUM AS rn, e.*
    FROM (SELECT *
            FROM employees
            ORDER BY hire_date ASC) e
    )
WHERE rn > '30' AND rn <= '40';

/*
문제 6.
employees테이블 departments테이블을 left 조인하세요
조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
조건) 직원아이디 기준 오름차순 정렬*/
SELECT 
    e.employee_id, e.first_name || ' ' || e.last_name AS 이름,
    e.department_id, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY employee_id;


/*
문제 7.
문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요*/
SELECT 
    e.employee_id, e.first_name || ' ' || e.last_name AS 이름,
    e.department_id,
    (SELECT
        d.department_name
    FROM departments d
    WHERE e.department_id = d.department_id
    ) AS 부서명
FROM employees e
ORDER BY employee_id;


/*
문제 8.
departments테이블 locations테이블을 left 조인하세요
조건) 부서아이디, 부서이름, 매니저아이디, 로케이션아이디, 
    스트릿_어드레스, 포스트 코드, 시티 만 출력합니다
조건) 부서아이디 기준 오름차순 정렬*/
SELECT 
    d.department_id, d.department_name, d.manager_id, d.location_id,
    l.street_address, l.postal_code, l.city
FROM departments d
LEFT JOIN locations l
ON d.location_id = l.location_id
ORDER BY d.department_id ASC;

/*
문제 9.
문제 8의 결과를 (스칼라 쿼리)로 동일하게 조회하세요*/
SELECT 
    d.department_id, d.department_name, d.manager_id, d.location_id,
    (SELECT l.street_address FROM locations l 
        WHERE d.location_id = l.location_id) AS 스트릿어드레스,
    (SELECT l.postal_code FROM locations l 
        WHERE d.location_id = l.location_id) AS 포스트코드,
    (SELECT l.city FROM locations l 
        WHERE d.location_id = l.location_id) AS 시티
FROM departments d
ORDER BY d.department_id ASC;




/*
문제 10.
locations테이블 countries 테이블을 left 조인하세요
조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
조건) country_name기준 오름차순 정렬*/
SELECT 
    l.location_id, l.street_address AS 주소, l.city, l.country_id, c.country_name
FROM locations l
LEFT JOIN countries c
ON l.country_id = c.country_id
ORDER BY country_name ASC;


SELECT * --데이터 확인용
FROM employees;
SELECT * --데이터 확인용
FROM countries;
SELECT *
FROM locations;

/*
문제 11.
문제 10의 결과를 (스칼라 쿼리)로 동일하게 조회하세요*/
SELECT 
    l.location_id, l.street_address AS 주소, l.city, l.country_id, 
    (SELECT c.country_name
    FROM countries c
    WHERE l.country_id = c.country_id
    ) AS 나라이름
FROM locations l
ORDER BY 나라이름 ASC;


/*
문제 12. 
employees테이블, departments테이블을 left조인 hire_date를
오름차순 기준으로 1-10번째 데이터만 출력합니다
조건) rownum을 적용하여 번호(rownum), 직원아이디, 이름, 전화번호, 입사일, 부서아이디,
    부서이름 을 출력합니다.
조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다.
    rownum이 틀어지면 안됩니다. */

SELECT * FROM 
    (SELECT
    ROWNUM AS rn, e.*
    FROM   (SELECT
                e.employee_id, e.first_name, e.phone_number,
                e.hire_date, e.department_id, d.department_name
            FROM employees e
            LEFT JOIN departments d
            ON e.department_id = d.department_id
            ORDER BY e.hire_date ASC) e)
WHERE rn > 0 AND rn <= 10;


/*
문제 13. 
--EMPLOYEES 과 DEPARTMENTS 테이블에서 JOB_ID가 SA_MAN 사원의 정보의
LAST_NAME, JOB_ID, DEPARTMENT_ID,DEPARTMENT_NAME을 출력하세요.*/
SELECT e.LAST_NAME, e.JOB_ID, e.DEPARTMENT_ID,d.DEPARTMENT_NAME
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE e.job_id = 'SA_MAN';


/*
문제 14
--DEPARTMENT테이블에서 각 부서의 ID, NAME, MANAGER_ID와 부서에 속한 인원수를 출력하세요.
--인원수 기준 내림차순 정렬하세요.
--사람이 없는 부서는 출력하지 뽑지 않습니다.*/
SELECT d.department_id, d.department_name, d.manager_id, a.인원수
FROM (SELECT department_id, COUNT(*) AS 인원수
    FROM employees
    GROUP BY department_id) a
LEFT JOIN departments d
ON a.department_id = d.department_id
--WHERE 인원수 is not null  --사실 이미 COUNT에서 걸러짐
ORDER BY a.인원수 DESC;


/*
문제 15
--부서에 대한 정보 전부와, 주소, 우편번호, 부서별 평균 연봉을 구해서 출력하세요.
--부서별 평균이 없으면 0으로 출력하세요. */
SELECT 
    d.*, l.street_address, l.state_province, 
    NVL(result, 0) AS 부서별평균급여
FROM departments d
JOIN locations l
ON d.location_id = l.location_id
LEFT JOIN (
    SELECT 
       TRUNC(AVG(salary)) AS result, department_id
    FROM employees e
    GROUP BY department_id
    ) tbl
ON d.department_id = tbl.department_id;


/*
문제 16
-문제 15 결과에 대해 DEPARTMENT_ID기준으로 내림차순 정렬해서
ROWNUM을 붙여 1-10데이터 까지만 출력하세요.*/
SELECT outoutTbl.*
FROM
    (
    SELECT ROWNUM AS rn, outTbl.* 
    FROM 
        (
        SELECT 
            d.*, l.street_address, l.state_province, 
            NVL(result, 0) AS 부서별평균급여
        FROM departments d
        JOIN locations l
        ON d.location_id = l.location_id
        LEFT JOIN (
            SELECT 
               TRUNC(AVG(salary)) AS result, department_id
            FROM employees e
            GROUP BY department_id
            ) tbl
        ON d.department_id = tbl.department_id
        ORDER BY d.department_id DESC
        ) outTbl
    ) outoutTbl
    WHERE rn > 0 AND rn <= 10;


























