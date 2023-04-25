
/*
 trigger는 테이블에 부착된 형태로써, INSERT, UPDATE, DELETE 작업이 수행될 때
특정 코드가 작동되도록 하는 구문이다. 
 VIEW에는 부착이 불가능하다.
 
 트리거를 만들 때엔 범위를 지정하고 F5 버튼으로 부분실행해야 한다.
 하나의 구문으로 인식되어 정상 동작하지 않는다. 
*/
CREATE TABLE tbl_test(
    id NUMBER(10),
    text VARCHAR2(20)
);

CREATE OR REPLACE TRIGGER trg_test
    AFTER DELETE OR UPDATE  --트리거의 발생 시점 (삭제 or 수정 이후에 동작)
    ON tbl_test --트리거를 부탁할 테이블
    FOR EACH ROW --각 행에 모두 적용. (생략 가능. 생략 시 한번만 실행)
-- DECLARE는 생략 가능
BEGIN
    dbms_output.put_line('트리거가 동작함!');
END;


INSERT INTO tbl_test VALUES(1,'김철수');

UPDATE tbl_test 
SET text = '김뽀삐' 
WHERE id=1;

DELETE FROM tbl_test 
WHERE id=1;

SELECT * FROM tbl_test;












































