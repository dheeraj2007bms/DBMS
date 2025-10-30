
DROP DATABASE IF EXISTS employee;
CREATE DATABASE employee;
USE employee;

create table dept(
deptno int primary key ,
dname varchar(50),
dloc varchar(50));

create table employee(
empno int primary key ,
ename varchar (50),
mgrno int,
hiredate date,
sal decimal(10,2),
depno int);

create table project (
pno int primary key ,
pname varchar(50),
ploc varchar(50));

create table assignedto(
empno int ,
pno int,
jobrole varchar(50),
primary key (empno,pno),
foreign key (empno) references employee (empno)
on delete cascade
on update cascade );

create table incentives 
(empno int ,incentivedate date ,
incentiveamount decimal(10,2),
foreign key(empno) references  employee(empno)
on delete cascade
on update cascade);

insert into dept values(
(110,"hr","mumbai"),
(120,"marketing","bangalore"),
(130,"it","kolkata"),
(140,"realestate","bangalore"),
(150,"finance","hyderbaf"));

insert into emplyee value (
(1,"rahul",1,"2022-04-01",50000,110),
(2,"bina",1,"2009-03-03",50000,120),
(3,"chandra",2,"2020-06-06",60000,150),
(4,"farah",3,"2023-08-19",60000,150),
(5,"divya",2,"2022-08-10",40000,130));

insert into project values (
(201,"pro_a","banglore"),
(202,"pro_b","gujarat"),
(203,"pro_c","bomby"),
(204,"pro_d","delhi"),
(205,"pro_e","bangalore"));

insert into asignedto values(
(1,201,"developer"),
(2,203,"analyst"),
(3,202,"developer"),
(4,203,"hr"),
(5,204,"developer"));



insert into incentive values(
(1,"2024-02-15",2000),
(3,"2024-01-01",1500),
(2,"2021-09-09",3000));

select distinct e.empno from employee e
join employee e 
join assignedto a on e.empno=a.empno
join project p on a.pno=p.pno
where p.ploc in ("bangalore");

select empno from employee
where empno not in (select empno from incentives);


