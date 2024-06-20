-- 1. List the employee number, last name, first name, sex, and salary of each employee
SELECT 
    e.emp_no as "Employee Number",
    e.last_name as "Last Name",
    e.first_name as "First Name",
    e.sex as "Sex",
    s.salary as "Salary"
FROM employees e
INNER JOIN salaries s
ON e.emp_no = s.emp_no;

-- 2. List the first name, last name, and hire date for employees who were hired in 1986
SELECT
    e.first_name as "First Name",
    e.last_name as "Last Name",
    e.hire_date as "Hired Date"
FROM employees e
WHERE e.hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name
SELECT
    e.first_name || ' ' ||e.last_name as "Manager Name",
    d.dept_name as "Department Name",
    d.dept_no as "Department Number",
    e.first_name as "First Name",
    e.last_name as "Last Name"
FROM departments d
INNER JOIN dept_emp de
ON d.dept_no = de.dept_no
INNER JOIN employees e
ON de.emp_no = e.emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name
SELECT
    d.dept_no as "Department Number",
    e.emp_no as "Employee Number",
    e.last_name as "Last Name",
    e.first_name as "First Name",
    d.dept_name as "Department Name"
FROM employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON de.dept_no = d.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
SELECT
    e.first_name as "First Name",
    e.last_name as "Last Name",
    e.sex as "Sex"
FROM employees e
WHERE e.first_name = 'Hercules' AND e.last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name
/* NOTE: This answer could be done in three different ways, using a subquery, using the WITH clause, or using a JOIN. 
The subquery is not the most efficient way as it would execute the subquery for every row on the main query. 
Therefore, the most efficient way to get the resultset is by using the WITH clause as it stores the resultset in a temporary table and reuses it as many times as needed, 
or with a JOIN clause.
*/
SELECT
    e.emp_no as "Employee Number",
    e.first_name as "First Name",
    e.last_name as "Last Name"
FROM employees e
WHERE e.emp_no IN (
        SELECT 
            emp_no 
        FROM dept_emp 
        INNER JOIN departments
        ON dept_emp.dept_no = departments.dept_no
        WHERE departments.dept_name = 'Sales');

WITH sales_department AS (
    SELECT 
        emp_no 
    FROM dept_emp 
    INNER JOIN departments
    ON dept_emp.dept_no = departments.dept_no
    WHERE departments.dept_name = 'Sales'
)
SELECT
    e.emp_no as "Employee Number",
    e.first_name as "First Name",
    e.last_name as "Last Name"
FROM employees e
WHERE e.emp_no IN (SELECT emp_no FROM sales_department);

SELECT
    e.emp_no as "Employee Number",
    e.first_name as "First Name",
    e.last_name as "Last Name"
FROM employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
-- NOTE: To simplify the response, we will only show the WITH clause as the most efficient way to get the resultset.
WITH sales_development_department AS (
    SELECT 
        emp_no 
    FROM dept_emp 
    INNER JOIN departments
    ON dept_emp.dept_no = departments.dept_no
    WHERE departments.dept_name in ('Sales', 'Development')
)
SELECT
    e.emp_no as "Employee Number",
    e.first_name as "First Name",
    e.last_name as "Last Name",
    d.dept_name as "Department Name"
FROM employees e
INNER JOIN dept_emp de
ON e.emp_no = de.emp_no
INNER JOIN departments d
ON de.dept_no = d.dept_no
WHERE e.emp_no IN (SELECT emp_no FROM sales_development_department);

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
SELECT
    e.last_name as "Last Name",
    COUNT(e.last_name) as "Number of last names"
FROM employees e
GROUP BY e.last_name
ORDER BY COUNT(e.last_name) DESC;