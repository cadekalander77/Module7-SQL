-- DELIVERABLE 1
--Create a non-unique list, employees show duplicates from promotions and title changes
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles LIMIT 10;

--Create the unique list using the DISTINCT ON() to remove duplicates
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles LIMIT 10;

SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY ut.count DESC;

SELECT * FROM retiring_titles;

---DELIVERABLE 2
--create a mentorship-eligibility table that holds the current employees who were born between January 1, 1965 and December 31, 1965.

SELECT DISTINCT ON(e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
    e.birth_date,
    de.to_date,
	de.from_date,
    t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibility LIMIT 10;