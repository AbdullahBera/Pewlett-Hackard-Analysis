CREATE TABLE titles(
		emp_no INT NOT NULL, 
		title VARCHAR NOT NULL,
		from_date DATE NOT NULL,
		to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

DROP TABLE titles; 

SELECT * FROM titles; 

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';


SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name 
INTO retirement_info 
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31'); 

-- Check retirement info 
SELECT * FROM retirement_info


-- Joining departments and dept_manager tables 
SELECT departments.dept_name, 
	dept_manager.emp_no, 
	dept_manager.from_date,
	dept_manager.to_date
FROM departments 
INNER JOIN dept_manager 
ON departments.dept_no = dept_manager.dept_no;

SELECT dd.dept_name, 
	dm.emp_no, 
	dm.from_date,
	dm.to_date
FROM departments AS dd
INNER JOIN dept_manager AS dm
ON dd.dept_no = dm.dept_no;
	
-- Joining retirement_info and dept_emp

SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	dept_emp.to_date 
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no; 


SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date 
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no; 


SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date 
INTO current_emp
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01'); 

SELECT * FROM current_emp;


SELECT COUNT(ce.emp_no), de.dept_no
INTO count_department
FROM current_emp AS ce 
LEFT JOIN dept_emp AS de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM count_department;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no, 
	first_name, 
last_name, 
	gender
INTO emp_info 
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31'); 

DROP TABLE emp_info;

SELECT e.emp_no,
	e.first_name,
e.last_name, 
	e.gender,
	s.salary,
	de.to_date 
INTO emp_info
FROM employees as e
INNER JOIN salaries as s 
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01'); 
	
SELECT dm.dept_no,
	d.dept_name,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp as ce
		ON (dm.emp_no = ce.emp_no);
	
SELECT ce.emp_no,
	ce.first_name,
ce.last_name,
	d.dept_no
INTO dept_info
FROM current_emp AS ce
	INNER JOIN dept_emp AS de 
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no);

SELECT * FROM retirement_info;

DROP TABLE sales_team;

SELECT ri.emp_no,
	ri.first_name,
ri.last_name, 
	d.dept_name
INTO sales_team 
FROM retirement_info AS ri 
	INNER JOIN dept_emp AS de 
		ON (ri.emp_no = de.emp_no)
	INNER JOIN departments AS d 
		ON (d.dept_no = de.dept_no)
WHERE d.dept_name = 'Sales';


SELECT ri.emp_no,
	ri.first_name,
ri.last_name, 
	d.dept_name
INTO sales_development_team 
FROM retirement_info AS ri 
	INNER JOIN dept_emp AS de 
		ON (ri.emp_no = de.emp_no)
	INNER JOIN departments AS d 
		ON (d.dept_no = de.dept_no)
WHERE dept_name  IN ('Development', 'Sales');


SELECT * FROM sales_development_team;