-- SQL ASSIGNMENT:-
CREATE DATABASE assignment;
use assignment;
/*1. Create a table called employees with the following structure
 emp_id (integer, should not be NULL and should be a primary key)
 emp_name (text, should not be NULL)
 age (integer, should have a check constraint to ensure the age is at least 18)
 email (text, should be unique for each employee)
 salary (decimal, with a default value of 30,000).
 Write the SQL query to create the above table with all constraints.*/
 CREATE TABLE employees (
    emp_id INT NOT NULL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL(10, 2) DEFAULT 30000.00
);

/* 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide 
examples of common types of constraints.?
ans- Constraints are rules applied to table columns that help enforce data accuracy, consistency, and integrity in a relational
 database.They prevent invalid or inconsistent data from being inserted, updated, or deleted.
 ITS IMPORTANT TO:-
 1- Ensure data validity (e.g., no negative ages, no nulls where they’re not allowed)
2- Protect relationships between tables (via foreign keys)
3-Avoid duplicates in unique fields (e.g., email, username)
4- Prevent logical errors like salary = -1000 or age < 0
5- Enforce business rules directly at the database level
Common Types of Constraints with Examples:
1-PRIMARY KEY:-	Uniquely identifies each row.example:- emp_id INT PRIMARY KEY.
2-NOT NULL:- Prevents missing (NULL) values. example:- emp_name VARCHAR(100) NOT NULL.
3-UNIQUE:- Ensures all values in a column are unique. Example:-	email VARCHAR(255) UNIQUE.
4-CHECK	Enforces:- specific conditions on column values. Example:-	age INT CHECK (age >= 18)
5-DEFAULT:-	Provides a default value if none is given.	salary DECIMAL(10,2) DEFAULT 30000.00.
6-FOREIGN KEY:-	Maintains referential integrity between tables.	FOREIGN KEY (dept_id) REFERENCES department(id).*/

/* 3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify 
your answer.
ans:- The NOT NULL constraint is used to ensure that a column must always contain a value.
       It prevents NULLs from being inserted into that column.
 Key Reasons:
1-Data completeness – guarantees that critical information (like emp_name, email, etc.) is always provided.
2- Avoids logic errors – NULLs can break calculations, filters, or joins.
3- Supports data integrity – helps ensure that essential fields are never left blank.
No, a primary key cannot contain NULL values — ever.
 Justification: A primary key uniquely identifies each row in a table.NULL means unknown or not available, which defeats the 
               idea of uniqueness.A primary key must always:
1- Be unique
2-Be not null
 That's why the database implicitly applies NOT NULL to primary key columns, even if you don’t declare it explicitly.*/
 
/* 4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an 
example for both adding and removing a constraint.
ans:- Steps to Add a Constraint:-
1-Use ALTER TABLE to modify the table.
2-Use ADD CONSTRAINT to add the new constraint.
3-Specify the type of constraint (e.g., PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, etc.).*/
-- EXAMPLE:-
ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);
/* Steps to Remove a Constraint:-
1-Use ALTER TABLE to modify the table.
2-Use DROP CONSTRAINT followed by the constraint name.
Example: Remove the UNIQUE Constraint:-*/
ALTER TABLE employees
DROP INDEX unique_email;  -- For MySQL

/* 5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. 
Provide an example of an error message that might occur when violating a constraint.
ans:- When you attempt to insert, update, or delete data in a way that violates constraints, the database will reject the
 operation and return an error message. Constraints are used to enforce data integrity and consistency, so violating them is 
 not allowed.
 Example:- You try to insert a NULL into a column that must have a value.*/
 INSERT INTO employees (id, name) VALUES (1, NULL);
 -- ERROR:- ERROR: Column 'name' cannot be null

/*  6. You created a products table without constraints as follows:
 CREATE TABLE products (
 product_id INT,
 product_name VARCHAR(50),
 price DECIMAL(10, 2));
 Now, you realise that
 The product_id should be a primary key
 The price should have a default value of 50.00*/
 -- 1. Add PRIMARY KEY constraint to product_id
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

-- 2. Set DEFAULT value of 50.00 for price
 ALTER TABLE products MODIFY price DECIMAL(10,2) DEFAULT 50.00;
 
 /* 7. You have two tables: STUDENTS AND CLASSES.
       Write a query to fetch the student_name and class_name for each student using an INNER JOIN.*/
SELECT s.name AS student_name, c.class_name
FROM student s
INNER JOIN classes c ON s.class_id = c.class_id;

/* Consider the following three tables: orders, customers and products.
Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are 
listed even if they are not associated with an order 
Hint: (use INNER JOIN and LEFT JOIN).*/
SELECT 
    o.order_id,
    c.customer_name,
    p.product_name
FROM 
    products p
LEFT JOIN orders o ON p.product_id = o.product_id
INNER JOIN customers c ON o.customer_id = c.customer_id;

/*  Given the following tables: Sales and products.
Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.*/
SELECT 
    p.product_name,
    SUM(p.price * oi.quantity) AS total_sales
FROM 
    products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY 
    p.product_name;

/* You are given three tables: orders, customers and order_details
 Write a query to display the order_id, customer_name, and the quantity of products ordered by each 
customer using an INNER JOIN between all three tables.*/
SELECT 
    o.order_id,
    c.customer_name,
    SUM(oi.quantity) AS total_quantity
FROM 
    customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY 
    o.order_id, c.customer_name;




  


 







