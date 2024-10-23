CREATE TABLE Salaries (
    company_id INT, 
    employee_id INT, 
    employee_name VARCHAR(50), 
    salary INT
);


INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES
(1, 1, 'Tony', 2000),
(1, 2, 'Pronub', 21300),
(1, 3, 'Tyrrox', 10800),
(2, 1, 'Pam', 300),
(2, 7, 'Bassem', 450),
(2, 9, 'Hermione', 700),
(3, 7, 'Bocaben', 100),
(3, 2, 'Ognjen', 2200),
(3, 13, 'Nyancat', 3300),
(3, 15, 'Morninngcat', 7777);


SELECT * FROM SALARIES

/*(Problem
Write an SQL query to find the salaries of the employees after applying taxes.

The tax rate is calculated for each company based on the following criteria:

0% If the max salary of any employee in the company is less than 1000$.
24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive.
49% If the max salary of any employee in the company is greater than 10000$.
Return the result table in any order. Round the salary to the nearest integer.)
*/


--APPROACH

-- cte - max sal
-- each company -- max salary
-- group by c id max(salary)

--join salaries
-- max salary
-- case statement -- tax%
-- 2000 * (1 - 24/100)


WITH MAX_SAL AS
(SELECT COMPANY_ID,
		MAX(SALARY) AS MAX_SALARY
FROM SALARIES
GROUP BY 1),
SALARY_BEFORE_TAX AS
(SELECT S.COMPANY_ID,
		S.EMPLOYEE_ID,
		S.EMPLOYEE_NAME,
		S.SALARY,
		MS.MAX_SALARY,
	    CASE
			WHEN MS.MAX_SALARY < 1000 THEN 0
	        WHEN MS.MAX_SALARY BETWEEN 1000 AND 10000 THEN 24
	        ELSE 49
	    END AS TAX_SLAB
FROM SALARIES S
JOIN MAX_SAL MS
ON S.COMPANY_ID=MS.COMPANY_ID
)
SELECT COMPANY_ID,
      EMPLOYEE_ID,
      EMPLOYEE_NAME,
      ROUND((SALARY)*(1-TAX_SLAB::NUMERIC/100))AS SALARY_AFTER_TAX
FROM SALARY_BEFORE_TAX