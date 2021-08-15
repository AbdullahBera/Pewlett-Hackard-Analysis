SELECT * FROM employees
-- Retirement Titles
SELECT e.emp_no,
		e.first_name, 
		  e.last_name, 
	tl.title, 
		tl.from_date,
			tl.to_date
INTO retirement_titles
FROM employees AS e 
LEFT JOIN titles AS tl 
	ON (e.emp_no = tl.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');


SELECT * FROM retirement_titles;

-- Unique Titles
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
	rt.last_name,
		rt.title

INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;

SELECT * FROM unique_titles; 

-- Retiring Titles
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title 
ORDER BY COUNT DESC;

-- Mentorship Eligibilty
SELECT DISTINCT ON (e.emp_no) e.emp_no ,
		e.first_name,
		  e.last_name,
		  	e.birth_date,
		de.from_date,
			de.to_date, 
		tl.title
INTO mentorship_eligibilty
FROM employees AS e
LEFT JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
LEFT JOIN titles AS tl 
	ON (e.emp_no = tl.emp_no)
WHERE (de.to_date = ('9999-01-01'))
	  AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31');


-- Mentorship Titile
SELECT * FROM mentorship_eligibilty;

SELECT COUNT (me.emp_no), me.title
INTO mentorship_titles
FROM mentorship_eligibilty AS me
GROUP BY me.title
ORDER BY COUNT DESC;


-- Vacant Positions
SELECT (rt.count - me.count) AS COUNT, rt.title
INTO vacant_positions
FROM retiring_titles AS rt
LEFT JOIN mentorship_eligibilty AS me
	ON (rt.title = me.title)
GROUP BY rt.count, rt.title
ORDER BY COUNT DESC;