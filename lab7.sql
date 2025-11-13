DROP DATABASE   supplier;
CREATE DATABASE supplier;
USE supplier;


create table Supplier(
		sid int primary key,
        sname varchar(50),
        city varchar(50));
CREATE TABLE Parts (
		pid INT PRIMARY KEY,
		pname VARCHAR(50),
		color VARCHAR(20)
);
create table catalog(
		sid int,
        pid int,
        cost decimal(10,2),
        primary key(sid,pid),
        foreign key(sid) references supplier(sid),
        foreign key(pid) references parts(pid));

INSERT INTO Supplier VALUES (10001, 'Acme Widget', 'Bangalore'),
							(10002, 'Johns', 'Kolkata'),
                            (10003, 'Vimal', 'Mumbai'),
                            (10004,'reliance','delhi'),
                            (10005,'mahindra','mumbai');


insert into parts values(20001,'book','red'),
						(20002,'pen','red'),
                        (20003,'pencil','green'),
                        (20004, 'Mobile', 'Green'),
                        (20005, 'Charger', 'Black');

insert into catalog values(10001, 20001, 10),
						  (10001, 20002, 10),
                          (10001, 20003, 30),
                          (10001, 20004, 10),
                          (10001, 20005, 10),
                          (10002, 20001, 10),
                          (10002, 20002, 20),
                          (10003, 20003, 30),
                          (10004, 20003, 40);
-- 3 Q
select distinct(pname) from parts
join catalog on catalog.pid=parts.pid;

-- 4Q
SELECT S.sname
FROM Supplier S
WHERE NOT EXISTS (
    SELECT P.pid
    FROM Parts P
    WHERE P.pid NOT IN (
        SELECT C.pid
        FROM Catalog C
        WHERE C.sid = S.sid
    )
);

-- 5Q
SELECT S.sname
FROM Supplier S
where not exists (
    SELECT P.pid
    FROM Parts P
    WHERE p.color='red' and P.pid NOT IN (
        SELECT C.pid
        FROM Catalog C
        WHERE C.sid = S.sid
    )
);

-- 6Q
select pname from parts p 
join catalog c on p.pid=c.pid
join supplier s on c.sid=s.sid
where s.sname='acme widget' and p.pid not in
(select c1.pid from catalog c1
join supplier s1 on c1.sid=s1.sid
where s1.sname != 'acme widget');

-- 7Q
SELECT DISTINCT C.sid
FROM Catalog C
WHERE C.cost > (
    SELECT AVG(C2.cost)
    FROM Catalog C2
    WHERE C2.pid = C.pid
);

-- 8Q
select s.sname, p.pname from catalog c
join supplier s on c.sid=s.sid
join parts p on p.pid=c.pid
where c.cost = (select max(catalog.cost) from catalog 
				where catalog.pid=c.pid);