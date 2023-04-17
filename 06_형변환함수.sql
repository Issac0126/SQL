
-- 형 변환함수  TO_CHAR, TO_NUMBER, TO_DATE


-- 날짜를 문자로 TO_CHAR(값, 형식)

SELECT TO_CHAR(sysdate) FROM dual; --현재 시간
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD HH:MI:SS') FROM dual; 
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD DY DAY PM HH:MI:SS') AS 출력,
        'YYYY-MM-DD DY DAY PM HH:MI:SS' AS 표기 FROM dual; 
SELECT TO_CHAR(sysdate, 'YY-MM-DD HH24:MI:SS') FROM dual; 

-- 사용하고 싶은 문자를 ""로 묶어 전달한다.
SELECT first_name, TO_CHAR(hire_date, 'YYYY"년" MM"월" DD"일"')
FROM employees;

-- 숫자를 문자로 TO_CHAR(값, 형식)
SELECT TO_CHAR(20000, '99999') FROM dual;
-- 주어진 자릿수에 숫자를 모두 표기할 수 없어서 모두 #으로 표기된다.
SELECT TO_CHAR(20000, '9999') FROM dual; -- 결과: #####
SELECT TO_CHAR(20000.28, '99999.9') FROM dual; -- 결과: 20000.3 (반올림해줌)
SELECT TO_CHAR(7451300, '9,999,999') FROM dual; -- 결과: 7,451,300

SELECT TO_CHAR(salary, '99,999L') AS sakary
FROM employees;


-------------------------------------------
--문자를 숫자로 TO_NUMBER(값, 형식)
SELECT '2000'+2000 FROM dual; --자동 형변환 문자-< 
SELECT TO_NUMBER('2000')+2000 FROM dual;
SELECT '$3, 300' + 2000 FROM dual; --에러
SELECT TO_NUMBER('$3,300', '$9,999') FROM dual; 
--어디에 숫자가 있는지 알려줘야 한다.


-----------------------------------------------
-- 문자를 날짜로 변환하는 함수 TO_DATE(값, 형식)
SELECT TO_DATE('2023-04-13') FROM dual;
SELECT sysdate - TO_DATE('2021-03-26') FROM dual; --날짜 연산시 반드시 날짜변경
SELECT TO_DATE('2020/12/25', 'YY-MM-DD') FROM dual; -- 결과: 20/12/25
-- 반드시 주어진 문자열을 모두 변환해야 한다.
SELECT TO_DATE('2021/03/31 12:23:50', 'YY/MM/DD HH:MI:SS') FROM dual; 



-- QUIZ. xxxx년 xx월 xx일 문자열 형식으로 변환해 보세요.
-- 조회 컬럼명은 dateInfo 라고 하겠습니다.
SELECT 
    TO_CHAR(TO_DATE('20050102', 'YYYYMMDD'), 'YYYY"년" MM"월" DD"일"') AS dateInfo
FROM dual;


-- NULL 제거 함수 NVL(컬럼, 변환할 타겟값)
SELECT null FROM dual;
SELECT NVL(null, 0)
FROM dual;
SELECT NVL(commission_pct, 0) AS comm_pct
FROM employees;

-- NULL 제거 함수 NVL2(컬럼, null이 아닐 경우, null일 경우)
SELECT
    NVL2(null, '널이 아님', '널이다')
FROM dual;
SELECT
    first_name,
    NVL2(commission_pct, 'true', 'false')
FROM employees;

SELECT
    first_name,
    commission_pct,
    NVL2(commission_pct, 
    salary + (salary*commission_pct), salary) AS real_salary
FROM employees;


-- DECODE(컬럼 혹은 표현식, 항목1, 결과1, 항목2, 결과2 ....... default) 
-- switch랑 비슷한 느낌. 
SELECT
    DECODE('F',
    'A', 'A입니다.', 'B', 'B입니다.', 'C', 'C입니다.', 'F', '당신은 F입니다.',
    '모르겠는데용')
FROM dual;

SELECT
    job_id,
    salary,
    DECODE(
        job_id, --기준
        'IT_PROG', salary*1.1,
        'FI_MGR', salary*1.2,
        'AD_VP', salary*1.3,
        salary
    ) AS DECODE
FROM employees;

--CASE WHEN THEN END
SELECT
    first_name,
    job_id,
    salary,
    (CASE job_id
        WHEN 'IT_PROG' THEN salary*1.1
        WHEN 'FI_MGR' THEN salary*1.2
        WHEN 'AD_VP' THEN salary*1.3
        WHEN 'FI_ACCOUNT' THEN salary*1.4
        ELSE salary
        END
    ) AS CASE
FROM employees;


-- QUiz
/*
문제 1.
현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서
근속년수가 17년 이상인 사원을 다음과 같은 형태의 결과를 출력하도록
쿼리를 작성해 보세요. 
조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다
*/
SELECT *
FROM employees;

SELECT
    EMPLOYEE_ID AS 사원번호,
    first_name || last_name AS 사원명,
    hire_date AS 입사일자,
    FLOOR((sysdate - hire_date) / 365) AS 근속년수
FROM employees
WHERE ((sysdate - hire_date) / 365) >= 17 
--식은 FROM -> WHERE -> SELECT -> ORDER 순서대로 진행된다. 별칭을 못씀.
ORDER BY 근속년수 DESC;


/*
문제 2.
EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
100이라면 ‘사원’, 
120이라면 ‘주임’
121이라면 ‘대리’
122라면 ‘과장’
나머지는 ‘임원’ 으로 출력합니다.
조건 1) DEPARTMENT_ID가 50인 사람들을 대상으로만 조회합니다
*/
SELECT
    first_name,
    manager_id,
    DECODE(
        manager_id,
        '100', '사원',
        '120', '주임',
        '121', '대리',
        '122', '과장',
        '임원'
    ) AS 직급
FROM employees
WHERE DEPARTMENT_ID = '50';

------------------------------------------

SELECT
    salary,
    employee_id,
    first_name,
    DECODE(
        TRUNC(salary/1000),
        4, 'A',
        3, 'B',
        2, 'C',
        1, 'D',
        'E'
    ) AS grade_DECODE,
    
    (CASE
        WHEN salary BETWEEN 4000 AND 4999 THEN 'A'
        WHEN salary BETWEEN 3000 AND 3999 THEN 'B'
        WHEN salary BETWEEN 2000 AND 2999 THEN 'C'
        WHEN salary BETWEEN 1000 AND 1999 THEN 'D'
        ELSE 'E'
        END
    ) AS grade_CASE
FROM employees
ORDER BY salary DESC;





