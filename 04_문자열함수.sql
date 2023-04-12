-- lower(소문자), initcap(앞글자만 대문자), upper(대문자)

SELECT * FROM dual;

/*
dual이라는 테이블은 sys가 소유하는 오라클의 표준 테이블로서,
오직 한 행에 한 컬럼만 담고 있는 더미 테이블이다.
주로 일시적인 산술 연산이나 날짜 연산 등에 주로 사용한다.
모든 사용자가 접근할 수 있다.
*/
SELECT 'abcDEF', lower('abcDEF'), upper('abcDEF')
FROM dual;

SELECT last_name, lower(last_name), INITCAP(last_name), upper(last_name)
FROM employees;


SELECT last_name 
FROM employees
WHERE lower(last_name) = 'austin'; --대/소문자 여부를 몰라도 확인 가능



-- length(길이), instr(문자 찾기, 없으면 e를 반환, 있으면 인덱스 값을 반환)
SELECT 'abcdef', length('abcdef'), instr('abcdef', 'a')
FROM dual; -- n번째 값인지 반환해준다.

SELECT 
    first_name, length(first_name), instr(first_name, 'l')
FROM employees;


--substr(문자열 자르기), concat(문장 연결) 1부터 시작 주의.
SELECT 
    'abcdef' AS ex,
    SUBSTR('abcdef', 1, 4), --1번째부터 4번째까지 
    concat('abc', 'def') --여러개는 불가능!! 매개값 2개까지만 가능
FROM dual;

SELECT 
    first_name, 
    SUBSTR(first_name, 1, 3),
    CONCAT(first_name, last_name)
FROM employees;


-- LPAD, RPAD (좌, 우측을 지정문자열로 채우기)
SELECT 
    LPAD('adc', 10, '*'),
    RPAD('adc', 10, '*')
FROM dual;


-- LTRIM(), RTRIM(), TRIM() 공백제거
-- LTRIM(param1, param2) -> param2의 값을 param1에서 찾아서 제거 (왼쪽부터)
-- RTRIM(param1, param2) -> param2의 값을 param1에서 찾아서 제거 (오른쪽부터)
SELECT 
    LTRIM('javascript_java', 'java'),
    RTRIM('javascript_java', 'java'),
    TRIM('          java      ')
FROM dual;


-- replace()
-- replace(기준문자열, 바꾸기 전 문자열, 대체할 문자열)
SELECT 
    Replace('My dream is a president', 'president', 'programmer'),
    Replace('My dream is a president', ' ', ''),
    
    REPLACE(Replace('My dream is a president', 'president', 'programmer'), ' ', ''),
    upper(Replace('My dream is a president', ' ', ''))
FROM dual;    


SELECT
    REPLACE(CONCAT('hello', ' world!'), '!', '?') AS 흠
FROM dual;



/*
문제 1.
EMPLOYEES 테이블 에서 이름, 입사일자 컬럼으로 변경해서 이름순으로 오름차순 출력 합니다.
조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다.
*/
SELECT 
    CONCAT(first_name, last_name) AS 이름,
    REPLACE(hire_date, '/', '')
FROM employees
ORDER BY 이름 ASC;

SELECT *
FROM employees;



/*
문제 2.
EMPLOYEES 테이블 에서 phone_numbe컬럼은 ###.###.####형태로 저장되어 있다
여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 전화 번호를 출력하도록 쿼리를 작성하세요.
(CONCAT, SUBSTR, LENGTH 사용)
*/

SELECT
    CONCAT('(02)', SUBSTR(phone_number, 5, length(phone_number))) AS 전화번호
FROM employees;



/*
문제 3. 
EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
*/
SELECT
    Rpad(SUBSTR(first_name, 1, 3), length(first_name), '*') AS name,
    LPAD(salary, 10, '*') AS salary
FROM employees
WHERE LOWER(job_id) = 'it_prog';











