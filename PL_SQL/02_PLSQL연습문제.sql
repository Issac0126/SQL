
DROP TABLE emps;
CREATE TABLE emps AS (SELECT * FROM employees WHERE 1=2);



-- 1. 구구단 중 3단을 출력하는 익명 블록을 만들어 보자. (출력문 9개를 복사해서 쓰세요)
DECLARE
BEGIN
    dbms_output.put_line('3x1='||3*1);
    dbms_output.put_line('3x2='||3*2);
    dbms_output.put_line('3x3='||3*3);
    dbms_output.put_line('3x4='||3*4);
    dbms_output.put_line('3x5='||3*5); 
    dbms_output.put_line('3x6='||3*6);
    dbms_output.put_line('3x7='||3*7);
    dbms_output.put_line('3x8='||3*8);
    dbms_output.put_line('3x9='||3*9);
END;



-- 2. employees 테이블에서 201번 사원의 이름과 이메일 주소를 출력하는
-- 익명블록을 만들어 보자. (변수에 담아서 출력하세요.)
DECLARE
    emp_name employees.first_name%TYPE;
    emp_email employees.email%TYPE;
BEGIN
    SELECT first_name, email
    INTO emp_name, emp_email
    FROM employees 
    WHERE employee_id = 201;
    
    dbms_output.put_line('201번 사원의 이름: ' || emp_name
    || '   이메일: ' || emp_email);
END;



-- 3. employees 테이블에서 사원번호가 제일 큰 사원을 찾아낸 뒤 ()MAX 함수 사용
-- 이 번호 + 1번으로 아래의 사원을 emps 테이블에
-- employee_id, last_name, email, hire_date, job_id를 신규 삽입하는 익명 블록을 만드세요.
-- SELECT절 이후에 INSERT문 사용이 가능합니다.
-- 나머지 => 사원명: steven / 이메일: stevenjobs / 입사일자: 오늘날짜 / job_id: CEO

DECLARE
    emp_max employees.employee_id%TYPE;
BEGIN
    SELECT MAX(employee_id)
    INTO emp_max
    FROM employees;
    
    INSERT INTO emps
        (employee_id, first_name, last_name, email, hire_date, job_id)
    VALUES (emp_max+1, 'steven', '라스트', 'stevenjobs@gmail.com', sysdate, 'CEO');
END;


SELECT * FROM employees;
SELECT * FROM emps;
































