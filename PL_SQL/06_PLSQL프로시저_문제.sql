
/*
----문제 1번
프로시저명 guguProc
구구단 을 전달받아 해당 단수를 출력하는 procedure을 생성하세요. 
*/

CREATE OR REPLACE PROCEDURE gugudan
    (gu_num IN NUMBER)  
IS
BEGIN
    FOR i in 1..9
    LOOP
        dbms_output.put_line(gu_num||'x'||i||'='||gu_num*i);
    END LOOP;
END;

EXEC gugudan(14);



/*
----문제 2번
부서번호, 부서명, 작업 flag(I: insert, U:update, D:delete)을 매개변수로 받아 
depts 테이블에 
각각 INSERT, UPDATE, DELETE 하는 depts_proc 란 이름의 프로시저를 만들어보자.
그리고 정상종료라면 commit, 예외라면 롤백 처리하도록 처리하세요.
*/
SELECT * FROM depts;

ALTER TABLE depts ADD CONSTRAINT depts_pk PRIMARY KEY(department_id);


CREATE OR REPLACE PROCEDURE depts_proc
    (d_num IN depts.department_id%TYPE,
     d_title IN depts.department_name%TYPE,
     flag IN VARCHAR2
    )
IS
    v_cnt NUMBER := 0;
BEGIN

    SELECT COUNT(*)
    INTO v_cnt
    FROM depts
    WHERE department_id = d_num;
    
    IF flag = 'I' THEN
        INSERT INTO depts
            (department_id, department_name)
        VALUES (d_num, d_title);
    ELSIF flag = 'U' THEN
        UPDATE depts  
        SET department_name = d_title
        WHERE department_id = d_num;
    ELSIF flag = 'D' THEN
        IF v_cnt = 0 THEN 
            dbms_output.put_line('해당 부서는 존재하지 않습니다.');
            return;
            END IF;
        DELETE depts
        WHERE department_id = d_num;
    ELSE 
        dbms_output.put_line('지원하지 않는 기능입니다. 입력한 값을 확인해 주십시오.');
    END IF;
    
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN 
        dbms_output.put_line('오류가 발생하여 롤백합니다.');
        ROLLBACK;
END;

EXEC depts_proc(280, '마케팅부서', 'I');
EXEC depts_proc(2560, '오락부', 'D');
SELECT * FROM depts;



/*
----문제 3번
employee_id를 입력받아 employees에 존재하면,
근속년수를 out하는 프로시저를 작성하세요. (익명블록에서 프로시저를 실행)
없다면 exception처리하세요
*/


CREATE OR REPLACE PROCEDURE hire_out
    (emp_id IN employees.employee_id%TYPE,
     emp_hire OUT employees.hire_date%TYPE
    )
IS
    cou NUMBER := 0;
BEGIN
    SELECT COUNT(*) 
        INTO cou
    FROM employees
    WHERE employee_id = emp_id;
    
    IF cou >= 1 THEN
        SELECT hire_date
            INTO  emp_hire
        FROM employees
        WHERE employee_id = emp_id;
    END IF;
    
--    emp_hire := TRUNC((sysdate - v_hire_date) / 365);
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('해당 ID는 존재하지 않는 ID입니다.');
END;



DECLARE
    str employees.hire_date%TYPE;
BEGIN
    hire_out(100, str);
    dbms_output.put_line(str);
END;

SELECT * FROM employees;



/*
프로시저명 - new_emp_proc
employees 테이블의 복사 테이블 emps를 생성합니다.
employee_id, last_name, email, hire_date, job_id를 입력받아
존재하면 이름, 이메일, 입사일, 직업을 update, 
없다면 insert하는 merge문을 작성하세요

머지를 할 타겟 테이블 -> emps
병합시킬 데이터 -> 프로시저로 전달받은 employee_id를 dual에 select 때려서 비교.
*/

CREATE OR REPLACE PROCEDURE new_emp_proc
    (new_id emps.employee_id%TYPE,
     new_last emps.last_name%TYPE,
     new_email emps.email%TYPE,
     new_hire emps.hire_date%TYPE,
     new_jobid emps.job_id%TYPE
    )
IS
BEGIN
--    INSERT INTO dual 
--        (employee_id, last_name, email, hire_date, job_id)
--    VALUES (new_id, new_last, new_email, new_hire, new_jobid);

    MERGE INTO emps a
        USING
            (SELECT * FROM dual) b
        ON 
            (a.employee_id = new_id)
    WHEN MATCHED THEN
        UPDATE
        SET a.last_name = new_last,
            a.email = new_email,
            a.hire_date = new_hire,
            a.job_id = new_jobid            
        
    WHEN NOT MATCHED THEN
        INSERT
            (a.employee_id, a.last_name, a.email, a.hire_date, a.job_id)
        VALUES (new_id, new_last, new_email, new_hire, new_jobid);
END;

SELECT * FROM dual;
SELECT * FROM emps;

EXEC new_emp_proc(100, 'lee', 'Issac2795', sysdate, 'CEO');



























