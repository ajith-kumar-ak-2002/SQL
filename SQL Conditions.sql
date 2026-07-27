CREATE TABLE employees (
	Id INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT,
    Gender VARCHAR(10) ,
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10,2),
    Dob DATE,
    City VARCHAR(100),
    Joining_Date DATE,
    Is_active BOOLEAN
);


INSERT INTO employees (id,name,age,gender,email,salary,dob,city,joining_date,is_active) VALUES
(1,'Rohit Sharma',28,'Male','rohit.sharma@gmail.com',45000.00,'1998-05-12','Hyderabad','2022-01-15',TRUE),
(2,'Priya Reddy',25,'Female','priya.reddy@gmail.com',52000.00,'2000-03-20','Visakhapatnam','2023-06-10',TRUE),
(3,'Arjun Kumar',30,'Male','arjun.kumar@gmail.com',68000.00,'1995-07-08','Bengaluru','2021-09-01',TRUE),
(4,'Sneha Patel',27,'Female','sneha.patel@gmail.com',49000.00,'1998-11-18','Ahmedabad','2022-04-12',TRUE),
(5,'Rahul Verma',35,'Male','rahul.verma@gmail.com',85000.00,'1990-01-25','Delhi','2019-08-20',TRUE),
(6,'Anjali Singh',24,'Female','anjali.singh@gmail.com',40000.00,'2001-09-15','Lucknow','2024-01-05',TRUE),
(7,'Vikram Rao',32,'Male','vikram.rao@gmail.com',73000.00,'1993-06-30','Chennai','2020-10-18',FALSE),
(8,'Pooja Nair',29,'Female','pooja.nair@gmail.com',61000.00,'1996-12-22','Kochi','2021-03-14',TRUE),
(9,'Kiran Joshi',26,'Male','kiran.joshi@gmail.com',47000.00,'1999-08-11','Pune','2023-02-27',TRUE),
(10,'Meera Iyer',31,'Female','meera.iyer@gmail.com',76000.00,'1994-02-14','Chennai','2020-05-11',TRUE),
(11,'Suresh Naidu',38,'Male','suresh.naidu@gmail.com',92000.00,'1987-10-05','Hyderabad','2018-07-01',TRUE),
(12,'Divya Sharma',23,'Female','divya.sharma@gmail.com',39000.00,'2002-04-09','Jaipur','2024-03-20',TRUE),
(13,'Manoj Gupta',34,'Male','manoj.gupta@gmail.com',81000.00,'1991-01-17','Noida','2019-11-15',FALSE),
(14,'Kavya Reddy',27,'Female','kavya.reddy@gmail.com',54000.00,'1998-06-28','Vijayawada','2022-07-25',TRUE),
(15,'Nikhil Jain',29,'Male','nikhil.jain@gmail.com',62000.00,'1996-05-02','Indore','2021-12-13',TRUE),
(16,'Aisha Khan',26,'Female','aisha.khan@gmail.com',51000.00,'1999-09-21','Mumbai','2023-08-08',TRUE),
(17,'Harish Chandra',33,'Male','harish.chandra@gmail.com',78000.00,'1992-03-11','Nagpur','2020-01-30',TRUE),
(18,'Neha Kapoor',28,'Female','neha.kapoor@gmail.com',56000.00,'1997-07-19','Chandigarh','2022-09-16',TRUE),
(19,'Ramesh Babu',40,'Male','ramesh.babu@gmail.com',98000.00,'1985-12-03','Visakhapatnam','2017-06-05',FALSE),
(20,'Swathi Krishna',25,'Female','swathi.krishna@gmail.com',43000.00,'2000-10-27','Hyderabad','2024-02-14',TRUE);


## Conditions 
	#Basic Select
SELECT * FROM employees;
	
    #Specific Column
SELECT Id, Name, Salary FROM employees;

	#Where Condition
SELECT * FROM employees WHERE age > 25;

	#And Condition
SELECT * FROM employees WHERE Gender = 'Male' and Salary > 50000;

	#Or Condition
SELECT * FROM employees WHERE city = 'Mumbai' OR city ='Delhi';

	#Like
SELECT * FROM employees WHERE Name LIKE 'A%';

	#Between 
SELECT * FROM employees WHERE salary BETWEEN 40000 and 60000;

	#Order By
SELECT * FROM employees ORDER BY salary ASC;

	#Limit 
SELECT * FROM employees LIMIT 3;

	#Distinct
SELECT DISTINCT city FROM employees;


	#Top 3 Highest Salary
SELECT * FROM employees ORDER BY salary DESC LIMIT 3;

	#Skip 1st 5 Rows , Show next 5 Rows
SELECT * FROM employees LIMIT 5 OFFSET 5;