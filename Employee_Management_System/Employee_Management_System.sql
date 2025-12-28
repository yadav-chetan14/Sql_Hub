CREATE DATABASE employee_management;

USE employee_management;

CREATE TABLE job_department (
    job_ID INT PRIMARY KEY,
    job_dept VARCHAR(50),
    name VARCHAR(50),
    description TEXT,
    salary_range VARCHAR(30)
);

CREATE TABLE employee (
    emp_ID INT PRIMARY KEY,
    fname VARCHAR(30),
    lname VARCHAR(30),
    gender VARCHAR(10),
    age INT,
    contact_add VARCHAR(100),
    emp_email VARCHAR(50),
    emp_pass VARCHAR(50)
);


CREATE TABLE salary_bonus (
    salary_ID INT PRIMARY KEY,
    job_ID INT,
    amount DECIMAL(10,2),
    annual BOOLEAN,
    bonus DECIMAL(10,2),
    FOREIGN KEY (job_ID) REFERENCES job_department(job_ID)
);

CREATE TABLE leave_table (
    leave_ID INT PRIMARY KEY,
    emp_ID INT,
    date DATE,
    reason VARCHAR(100),
    FOREIGN KEY (emp_ID) REFERENCES employee(emp_ID)
);

CREATE TABLE payroll (
    payroll_ID INT PRIMARY KEY,
    emp_ID INT,
    job_ID INT,
    salary_ID INT,
    leave_ID INT,
    date DATE,
    report VARCHAR(100),
    total_amount DECIMAL(10,2),
    FOREIGN KEY (emp_ID) REFERENCES employee(emp_ID),
    FOREIGN KEY (job_ID) REFERENCES job_department(job_ID),
    FOREIGN KEY (salary_ID) REFERENCES salary_bonus(salary_ID),
    FOREIGN KEY (leave_ID) REFERENCES leave_table(leave_ID)
);

INSERT INTO job_department VALUES
(1,'IT','Developer','Software development','40k-80k'),
(2,'HR','HR Executive','Employee handling','30k-60k'),
(3,'Finance','Accountant','Accounts handling','35k-70k'),
(4,'Sales','Sales Exec','Sales activities','25k-55k'),
(5,'Support','Support Eng','Customer support','20k-45k'),
(6,'Admin','Admin','Office admin','25k-50k'),
(7,'Marketing','Analyst','Marketing analysis','30k-65k');

INSERT INTO employee VALUES
(101,'Rahul','Sharma','Male',25,'Bangalore','rahul@gmail.com','rahul123'),
(102,'Anita','Verma','Female',28,'Delhi','anita@gmail.com','anita123'),
(103,'Amit','Patel','Male',32,'Ahmedabad','amit@gmail.com','amit123'),
(104,'Sneha','Rao','Female',26,'Hyderabad','sneha@gmail.com','sneha123'),
(105,'Ravi','Kumar','Male',35,'Chennai','ravi@gmail.com','ravi123'),
(106,'Priya','Singh','Female',29,'Mumbai','priya@gmail.com','priya123'),
(107,'Karan','Mehta','Male',31,'Pune','karan@gmail.com','karan123');

INSERT INTO salary_bonus VALUES
(201,1,50000,TRUE,5000),
(202,2,40000,TRUE,3000),
(203,3,55000,TRUE,6000),
(204,4,35000,TRUE,2500),
(205,5,30000,TRUE,2000),
(206,6,32000,TRUE,2200),
(207,7,45000,TRUE,4000);

INSERT INTO leave_table VALUES
(301,101,'2025-01-05','Sick Leave'),
(302,102,'2025-01-07','Personal Leave'),
(303,103,'2025-01-10','Vacation'),
(304,104,'2025-01-12','Medical'),
(305,105,'2025-01-15','Family Function'),
(306,106,'2025-01-18','Sick Leave'),
(307,107,'2025-01-20','Personal Work');

INSERT INTO payroll VALUES
(401,101,1,201,301,'2025-01-31','January Payroll',55000),
(402,102,2,202,302,'2025-01-31','January Payroll',43000),
(403,103,3,203,303,'2025-01-31','January Payroll',61000),
(404,104,4,204,304,'2025-01-31','January Payroll',37500),
(405,105,5,205,305,'2025-01-31','January Payroll',32000),
(406,106,6,206,306,'2025-01-31','January Payroll',34200),
(407,107,7,207,307,'2025-01-31','January Payroll',49000);

-- Q1.Highest paid employee.

SELECT e.fname, p.total_amount
FROM employee e
JOIN payroll p ON e.emp_ID = p.emp_ID
ORDER BY p.total_amount DESC
LIMIT 1;

-- Q2.Lowest paid employee

SELECT e.fname, p.total_amount
FROM employee e
JOIN payroll p ON e.emp_ID = p.emp_ID
ORDER BY p.total_amount ASC
LIMIT 1;

-- Q3.Dept with highest payout

SELECT j.job_dept, SUM(p.total_amount) AS payout
FROM payroll p
JOIN job_department j ON p.job_ID = j.job_ID
GROUP BY j.job_dept
ORDER BY payout DESC
LIMIT 1;
 
 -- Q4.Employees who took sick leave
 
SELECT e.fname, l.date
FROM employee e
JOIN leave_table l ON e.emp_ID = l.emp_ID
WHERE l.reason = 'Sick Leave';

-- Q5.Average salary by Department

SELECT j.job_dept,
       AVG(p.total_amount) AS average_salary
FROM payroll p
JOIN job_department j
     ON p.job_ID = j.job_ID
GROUP BY j.job_dept;

-- Q6. Employees Salary above average

SELECT e.fname, p.total_amount
FROM employee e
JOIN payroll p ON e.emp_ID = p.emp_ID
WHERE p.total_amount > (
    SELECT AVG(total_amount) FROM payroll
);













