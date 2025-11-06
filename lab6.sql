
DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;


CREATE TABLE dept (
  deptno INT PRIMARY KEY,
  dname VARCHAR(50),
  dloc VARCHAR(50)
);

CREATE TABLE employee (
  empno INT PRIMARY KEY,
  ename VARCHAR(50),
  mgrno INT,
  hiredate DATE,
  sal DECIMAL(10,2),
  deptno INT,
  FOREIGN KEY (deptno) REFERENCES dept(deptno)
);

CREATE TABLE project (
  pno INT PRIMARY KEY,
  pname VARCHAR(50),
  ploc VARCHAR(50)
);

CREATE TABLE assignedto (
  empno INT,
  pno INT,
  jobrole VARCHAR(50),
  PRIMARY KEY (empno, pno),
  FOREIGN KEY (empno) REFERENCES employee(empno)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (pno) REFERENCES project(pno)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE incentives (
  empno INT,
  incentivedate DATE,
  incentiveamount DECIMAL(10,2),
  FOREIGN KEY (empno) REFERENCES employee(empno)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


INSERT INTO dept VALUES
(110, 'hr', 'mumbai'),
(120, 'marketing', 'bangalore'),
(130, 'it', 'kolkata'),
(140, 'realestate', 'bangalore'),
(150, 'finance', 'hyderabad');

INSERT INTO employee VALUES
(1, 'rahul', NULL, '2022-04-01', 50000, 110),
(2, 'bina', 1, '2009-03-03', 50000, 110),

(3, 'chandra', 1, '2020-06-06', 60000, 120),
(4, 'farah', NULL, '2023-08-19', 60000, 120),
(5, 'divya', 4, '2022-08-10', 40000, 120);

INSERT INTO project VALUES
(201, 'pro_a', 'bangalore'),
(202, 'pro_b', 'gujarat'),
(203, 'pro_c', 'mumbai'),
(204, 'pro_d', 'delhi'),
(205, 'pro_e', 'bangalore');

INSERT INTO assignedto VALUES
(1, 201, 'developer'),
(2, 203, 'analyst'),
(3, 202, 'developer'),
(4, 203, 'hr'),
(5, 204, 'developer');

INSERT INTO incentives VALUES
(1, '2024-02-15', 2000),
(3, '2024-01-01', 1500),
(2, '2021-09-09', 3000);


SELECT ename AS manager_name
FROM employee 
WHERE empno IN (
  SELECT mgrno 
  FROM employee 
  GROUP BY mgrno 
  HAVING COUNT(*) = (
    SELECT MAX(cnt) 
    FROM (
      SELECT mgrno, COUNT(*) AS cnt 
      FROM employee 
      GROUP BY mgrno
    ) AS sub
  )
);

SELECT m.ename AS manager_name
FROM employee m
WHERE m.empno IN (SELECT DISTINCT mgrno FROM employee WHERE mgrno IS NOT NULL)
  AND m.sal > (
    SELECT AVG(e.sal)
    FROM employee e
    WHERE e.mgrno = m.empno
  );


SELECT e.ename AS employee_name
FROM employee e
JOIN employee m ON e.mgrno = m.empno
WHERE e.deptno = m.deptno;


SELECT e.*
FROM employee e
JOIN incentives i ON e.empno = i.empno
WHERE i.incentiveamount = (
  SELECT incentiveamount 
  FROM incentives 
  WHERE incentivedate BETWEEN '2019-01-01' AND '2019-01-31'
  ORDER BY incentiveamount DESC 
  LIMIT 1 OFFSET 1
);

select d.deptno ,e.empno,e.ename from dept d
join employee e1 on d.deptno =e1.deptno and e1.mgrno is null 
join employee e on e.mgrno=e1.empno;