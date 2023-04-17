
/*
# 서브쿼리

- 서브쿼리의 사용방법은 () 안에 명시함.
 서브쿼리절의 리턴행은 1줄 이하여야 한다.
- 서브쿼리 절에는 비교할 대상이 하나 반드시 들어가야 한다.
- 해석할 때는 서브쿼리절부터 먼저 해석하면 된다.
*/

-- 'Nancy'의 급여보다 급여가 많은 사람을 검색하는 문장

SELECT salary FROM employees WHERE first_name = 'Nancy'; 
--낸시의 급여: 12008

SELECT * FROM employees
WHERE salary > 12008;  --12008 이라는 값을 사전에 구해야만 함.

SELECT * FROM employees
WHERE salary > (SELECT salary
                FROM employees
                WHERE first_name = 'Nancy');













