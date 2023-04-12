
-- 숫자 함수


-- ROUND (반올림)
-- 원하는 반올림 위치를 매개값으로 지정. 음수를 주는 것도 가능.
SELECT
    round(3.1415, 3), round(45.923, 0), round(45.923, -1)
FROM dual;


-- TRUNC(절사) (내림?)
-- 정해진 소수점 자리수까지 잘라낸다.
SELECT
    Trunc(3.1415, 3), Trunc(45.923, 0), Trunc(45.923, -1)
FROM dual;


-- ABS (절대값) (그 값이 가지고 있는 총량)
SELECT
    ABS(-34), ABS(-34.541)
FROM dual;

-- CEIL (올림), FLOOR (내림)
SELECT 
    CEIL(3.14), 
    floor(3.14) 
FROM dual;

-- MOD(나머지)
SELECT 
    10 / 4, MOD(10, 4)
FROM dual;



-- 날짜 함수
SELECT sysdate FROM dual;
SELECT systimestamp FROM dual;

-- 날짜도 연산이 가능하다.
SELECT sysdate + 1 FROM dual;

SELECT 
    first_name, 
    hire_date,
    Floor((sysdate - hire_date) / 7) AS WEEK,
    TRUNC((sysdate - hire_date) / 365, 0) AS YEAR
FROM employees;


-- 날짜 반올림, 절사
SELECT ROUND(sysdate) FROM dual; -- 정오를 기준으로 반올림
SELECT ROUND(sysdate, 'year') FROM dual; -- 년(6월 말)을 기준으로 반올림
SELECT ROUND(sysdate, 'month') FROM dual; -- 월(15~16일)을 기준으로 반올림
SELECT ROUND(sysdate, 'day') FROM dual; --일주일(수요일)을 기준으로 반올림 (일요일 시작 기준)

SELECT TRUNC(sysdate) FROM dual; -- 정오를 기준으로 절사
SELECT TRUNC(sysdate, 'year') FROM dual; -- 년(6월 말)을 기준으로 절사
SELECT TRUNC(sysdate, 'month') FROM dual; -- 월(15~16일)을 기준으로 절사
SELECT TRUNC(sysdate, 'day') FROM dual; --일주일(수요일)을 기준으로 절사 (일요일 시작 기준)







