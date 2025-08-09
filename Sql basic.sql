## 1. Create a table called employees with the following structure
#### emp_id (integer, should not be NULL and should be a primary key)
#### emp_name (text, should not be NULL)
#### age (integer, should have a check constraint to ensure the age is at least 18)
#### email (text, should be unique for each employee)
#### salary (decimal, with a default value of 30,000).
#### Write the SQL query to create the above table with all constraints.

## **Answer:**
use abhi;
CREATE TABLE employees(
    emp_id INTEGER PRIMARY KEY NOT NULL,
    emp_name TEXT NOT NULL,
    age INTEGER CHECK (age >= 18),
    email varchar(20) UNIQUE,
    salary DECIMAL DEFAULT 30000
);

## 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints

## Answer:
**Constraints** are rules enforced on columns in a database table to ensure the accuracy, consistency, and integrity of the data stored.

### Purpose of Constraints

-  Ensure **valid data entry**
-  Prevent **invalid or duplicate data**
-  Maintain **relationships between tables**
-  Enforce **business rules**

###  Common Types of Constraints (with Examples)

| Constraint Type | Purpose                                              | Example                                                   |
|------------------|------------------------------------------------------|------------------------------------------------------------|
| **NOT NULL**     | Ensures a column cannot have a NULL value           | `emp_name TEXT NOT NULL`                                  |
| **UNIQUE**       | Ensures all values in a column are different        | `email TEXT UNIQUE`                                       |
| **PRIMARY KEY**  | Uniquely identifies each row and cannot be NULL     | `emp_id INTEGER PRIMARY KEY`                              |
| **FOREIGN KEY**  | Maintains referential integrity between tables      | `FOREIGN KEY (dept_id) REFERENCES departments(dept_id)`   |
| **CHECK**        | Ensures values meet a specific condition            | `age INTEGER CHECK (age >= 18)`                           |
| **DEFAULT**      | Assigns a default value if none is provided         | `salary DECIMAL DEFAULT 30000`                            |

## 3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify our answer.
## Answer:
The NOT NULL constraint is used when we want to make sure that a column always has a value. It helps prevent missing or empty data in important fields. For example, if we want every employee to have a name, we use NOT NULL on the emp_name column. A primary key cannot contain NULL values because it must uniquely identify each row in a table. If the value is NULL, it means it’s unknown, and we can’t use it to identify a row. That’s why a primary key is always automatically NOT NULL.

## 4.Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.
## Answer:
### Steps to **Add a Constraint**
Use `ALTER TABLE` followed by `ADD CONSTRAINT`.

####  Example: Add a `UNIQUE` constraint to the `email` column

ALTER TABLE employees
ADD CONSTRAINT unique_email UNIQUE (email);

### Steps to **Remove a Constraint**
Use `ALTER TABLE` followed by `DROP CONSTRAINT`.

> Note: You must know the **name of the constraint** to remove it. If you didnot name it while creating, the database gives it a default name.
####  Example: Remove the `unique_email` constraint

ALTER TABLE employees
DROP CONSTRAINT unique_email;

##  5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.
## Answer:
Constraints are rules set on table columns to protect data integrity. If you try to **insert**, **update**, or **delete** data in a way that breaks these rules, the database will block the operation and return an error.

###  Consequences of Violating Constraints

- **INSERT**: Adding a row with missing or invalid data will fail.
- **UPDATE**: Changing data that breaks a constraint will be rejected.
- **DELETE**: Deleting a record that is linked by a foreign key can cause errors.

#### Example 1: Violating `NOT NULL`

INSERT INTO employees (emp_id, emp_name, age)
VALUES (101, NULL, 25);

 **Error message:**
ERROR: null value in column "emp_name" violates not-null constraint

####  Example 2: Violating `UNIQUE`

INSERT INTO employees (emp_id, emp_name, age, email)
VALUES (102, 'Alice', 30, 'john@example.com');  -- email already exists

 **Error message:**
ERROR: duplicate key value violates unique constraint "unique_email"

## 6. You created a products table without constraints as follows:
#### CREATE TABLE products (
#### product_id INT,
#### product_name VARCHAR(50),
#### price DECIMAL(10, 2));
#### Now, you realise that
### The product_id should be a primary key
### The price should have a default value of 50.00
## **Answer:**

ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

## 7. You have two tables:
###  Students Table

| student_id | student_name | class_id |
|------------|--------------|----------|
| 1          | Alice        | 101      |
| 2          | Bob          | 102      |
| 3          | Charlie      | 101      |



###  Classes Table

| class_id | class_name |
|----------|------------|
| 101      | Math       |
| 102      | Science    |
| 103      | History    |


## **Answer:**

### Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

SELECT 
    students.student_name,classes.class_name
FROM 
    students INNER JOIN classes
ON 
    students.class_id = classes.class_id;
    
##  8. Consider the following three tables:

###  Orders Table

| order_id | order_date | customer_id |
|----------|------------|-------------|
| 1        | 2024-01-01 | 101         |
| 2        | 2024-01-03 | 102         |


###  Customers Table

| customer_id | customer_name |
|-------------|----------------|
| 101         | Alice          |
| 102         | Bob            |


###  Products Table

| product_id | product_name | order_id |
|------------|--------------|----------|
| 1          | Laptop       | 1        |
| 2          | Phone        | NULL     |


### Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are listed even if they are not associated with an order ,Hint: (use INNER JOIN and LEFT JOIN)

## **Answer:**

SELECT 
    products.order_id,
    customers.customer_name,
    products.product_name
FROM 
    products
LEFT JOIN orders
    ON products.order_id = orders.order_id
LEFT JOIN customers
    ON orders.customer_id = customers.customer_id;

## 9.Given the following tables:
###  Sales Table

| sale_id | product_id | amount |
|---------|------------|--------|
| 1       | 101        | 500    |
| 2       | 102        | 300    |
| 3       | 101        | 700    |



###  Products Table

| product_id | product_name |
|------------|--------------|
| 101        | Laptop       |
| 102        | Phone        |

### Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function

## **Answer:**

SELECT 
    p.product_name,
    SUM(s.amount) AS total_sales
FROM 
    sales s
INNER JOIN 
    products p
ON 
    s.product_id = p.product_id
GROUP BY 
    p.product_name;

## 10. You are given three tables:
###  Orders Table

| order_id | order_date  | customer_id |
|----------|-------------|-------------|
| 1        | 2024-01-02  | 1           |
| 2        | 2024-01-05  | 2           |



###  Customers Table

| customer_id | customer_name |
|-------------|----------------|
| 1           | Alice          |
| 2           | Bob            |



### Order_Details Table

| order_id | product_id | quantity |
|----------|------------|----------|
| 1        | 101        | 2        |
| 1        | 102        | 1        |
| 2        | 101        | 3        |

### Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between all three tables.

## **Answer:**
SELECT 
    o.order_id,c.customer_name,od.quantity
FROM orders o
INNER JOIN customers c 
    ON o.customer_id = c.customer_id
INNER JOIN order_details od 
    ON o.order_id = od.order_id;

# **SQL Commands**

## 1.Identify the primary keys and foreign keys in maven movies db. Discuss the differences
###  Primary Keys
Primary keys uniquely identify each row in a table. They cannot be NULL or duplicated.

| Table           | Primary Key            |
|-----------------|------------------------|
| actor           | actor_id               |
| address         | address_id             |
| category        | category_id            |
| city            | city_id                |
| country         | country_id             |
| customer        | customer_id            |
| film            | film_id                |
| inventory       | inventory_id           |
| language        | language_id            |
| payment         | payment_id             |
| rental          | rental_id              |
| staff           | staff_id               |
| store           | store_id               |
| film_actor      | (film_id, actor_id)    |
| film_category   | (film_id, category_id) |

### Foreign Keys
Foreign keys link records between tables using referenced primary keys.

| Table           | Foreign Key(s)                            | References                       |
|-----------------|--------------------------------------------|----------------------------------|
| address         | city_id                                    | city(city_id)                    |
| city            | country_id                                 | country(country_id)              |
| customer        | store_id, address_id                       | store, address                   |
| film            | language_id, original_language_id          | language                         |
| film_actor      | film_id, actor_id                          | film, actor                      |
| film_category   | film_id, category_id                       | film, category                   |
| inventory       | film_id, store_id                          | film, store                      |
| payment         | customer_id, staff_id, rental_id           | customer, staff, rental          |
| rental          | inventory_id, customer_id, staff_id        | inventory, customer, staff       |
| staff           | address_id, store_id                       | address, store                   |
| store           | address_id, manager_staff_id               | address, staff                   |

###  Primary Key vs Foreign Key

| Feature        | Primary Key                              | Foreign Key                                      |
|----------------|-------------------------------------------|--------------------------------------------------|
| Purpose        | Uniquely identifies each record           | Connects one table to another                    |
| Uniqueness     | Must be unique                            | Can have duplicates                              |
| NULL allowed   |  Not allowed                             |  Allowed (depending on the relationship)        |
| Used in        | The table it belongs to                   | Refers to another table                          |

## 2.  List all details of actors
use sakila;
SELECT * FROM actor limit 10;

## 3. List all customer information from DB
SELECT * FROM customer limit 10;

## 4. List different countries.
SELECT DISTINCT country FROM country;

## 5. Display all active customers.
SELECT * FROM customer
WHERE active = 1 limit 10;

## 6. List of all rental IDs for customer with ID 1.
SELECT rental_id FROM rental
WHERE customer_id = 1;

 ## 7. Display all the films whose rental duration is greater than 5 .
SELECT * FROM film
WHERE rental_duration > 5 limit 10;

## 8. List the total number of films whose replacement cost is greater than $15 and less than $20.
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

## 9. Display the count of unique first names of actors.
SELECT 
    COUNT(DISTINCT first_name) AS unique_first_name_count
FROM 
    actor;

## 10. Display the first 10 records from the customer table .
SELECT * FROM customer
LIMIT 10;

## 11. Display the first 3 records from the customer table whose first name starts with ‘b’.
SELECT * FROM customer
WHERE first_name LIKE 'B%'
LIMIT 3;

## 12. Display the names of the first 5 movies which are rated as ‘G’.
SELECT title 
FROM film
WHERE rating = 'G'
LIMIT 5;

## 13. Find all customers whose first name starts with "a".
SELECT * FROM customer
WHERE first_name LIKE 'A%';

## 14. Find all customers whose first name ends with "a".
SELECT * FROM customer
WHERE first_name LIKE '%a' limit 20;

## 15. Display the list of first 4 cities which start and end with ‘a’.
SELECT city FROM city
WHERE city LIKE 'a%a'
LIMIT 4;

## 16. Find all customers whose first name have "NI" in any position.
SELECT * FROM customer
WHERE first_name LIKE '%NI%';

## 17. Find all customers whose first name have "r" in the second position.
SELECT * FROM customer
WHERE first_name LIKE '_r%';

## 18. Find all customers whose first name starts with "a" and are at least 5 characters in length.
SELECT * FROM customer
WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;

## 19. Find all customers whose first name starts with "a" and ends with "o".
SELECT * FROM customer
WHERE first_name LIKE 'a%o';

##  20. Get the films with pg and pg-13 rating using IN operator.
SELECT * FROM film
WHERE rating IN ('PG', 'PG-13') LIMIT 5; # use LIMIT to avoid large output

## 21. Get the films with length between 50 to 100 using between operator.
SELECT * FROM film
WHERE length BETWEEN 50 AND 100 limit 5;

## 22. Get the top 50 actors using limit operator.
SELECT * FROM actor
LIMIT 50;

## 23. Get the distinct film ids from inventory table
SELECT count(DISTINCT film_id) FROM inventory;

# **Functions**

##  Basic Aggregate Functions:
### Question 1: Retrieve the total number of rentals made in the Sakila database.Hint: Use the COUNT() function.
SELECT COUNT(*) AS total_rentals
FROM rental;

### Question 2: Find the average rental duration (in days) of movies rented from the Sakila database.Hint: Utilize the AVG() function.
SELECT AVG(rental_duration) AS average_rental_duration
FROM film;

## String Functions:
### Question 3: Display the first name and last name of customers in uppercase.Hint: Use the UPPER () function.
SELECT 
    UPPER(first_name) AS first_name_upper,
    UPPER(last_name) AS last_name_upper
FROM customer limit 20;

###  Question 4: Extract the month from the rental date and display it alongside the rental ID.Hint: Employ the MONTH() function.
SELECT 
    rental_id,
    MONTH(rental_date) AS rental_month
FROM 
    rental limit 10;

##  GROUP BY:
 ### Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).Hint: Use COUNT () in conjunction with GROUP BY.
SELECT 
    customer_id,
    COUNT(*) AS rental_count
FROM 
    rental
GROUP BY 
    customer_id limit 10;

 ### Question 6: Find the total revenue generated by each store.Hint: Combine SUM() and GROUP BY
SELECT 
    c.store_id,
    SUM(p.amount) AS total_revenue
FROM 
    payment p
JOIN 
    customer c ON p.customer_id = c.customer_id
GROUP BY 
    c.store_id;

### Question 7: Determine the total number of rentals for each category of movies.Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
SELECT 
    c.store_id,
    SUM(p.amount) AS total_revenue
FROM 
    payment p
JOIN 
    customer c ON p.customer_id = c.customer_id
GROUP BY 
    c.store_id;

###  Question 8: Find the average rental rate of movies in each language.Hint: JOIN film and language tables, then use AVG () and GROUP BY.
SELECT 
    l.name AS language,
    AVG(f.rental_rate) AS average_rental_rate
FROM 
    film f
JOIN 
    language l ON f.language_id = l.language_id
GROUP BY 
    l.name
ORDER BY 
    average_rental_rate ;
    
###  Questions 9: Display the title of the movie, customer s first name, and last name who rented it.Hint: Use JOIN between the film, inventory, rental, and customer tables.
SELECT 
    f.title,
    c.first_name,
    c.last_name
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
JOIN 
    customer c ON r.customer_id = c.customer_id limit 10;  #use limit to avoid large output

### Question 10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind."Hint: Use JOIN between the film actor, film, and actor tables.
SELECT 
    a.first_name,
    a.last_name
FROM 
    film f
JOIN 
    film_actor fa ON f.film_id = fa.film_id
JOIN 
    actor a ON fa.actor_id = a.actor_id
WHERE 
    f.title = 'Gone with the Wind';

### Question 11: Retrieve the customer names along with the total amount they've spent on rentals.Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_amount_spent
FROM 
    customer c
JOIN 
    payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    total_amount_spent DESC limit 10;  
 
### Question 12: List the titles of movies rented by each customer in a particular city (e.g., 'London').Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
SELECT 
    c.first_name,
    c.last_name,
    ci.city,
    f.title
FROM 
    customer c
JOIN 
    address a ON c.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    ci.city = 'London'
ORDER BY 
    c.last_name, f.title;

##  Advanced Joins and GROUP BY:
###  Question 13: Display the top 5 rented movies along with the number of times they've been rented.Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
SELECT 
    f.title AS movie_title,
    COUNT(r.rental_id) AS times_rented
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.title
ORDER BY 
    times_rented DESC
LIMIT 5;

###  Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
SELECT 
    r.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT i.store_id) AS store_count
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    customer c ON r.customer_id = c.customer_id
GROUP BY 
    r.customer_id, c.first_name, c.last_name
HAVING 
    COUNT(DISTINCT i.store_id) = 2 LIMIT 10; #use limit to avoid large output

# Windows Function:
## 1. Rank the customers based on the total amount they've spent on rentals.
SELECT 
    customer_id,
    CONCAT(first_name, ' ', last_name) AS customer_name,
    SUM(amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(amount) DESC) AS spending_rank
FROM 
    payment
JOIN 
    customer USING (customer_id)
GROUP BY 
    customer_id, first_name, last_name LIMIT 10;  
    
##  2. Calculate the cumulative revenue generated by each film over time.
SELECT 
    f.film_id,
    f.title,
    r.rental_date,
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY r.rental_date) AS cumulative_revenue
FROM 
    payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id LIMIT 10;

## 3. Determine the average rental duration for each film, considering films with similar lengths.
SELECT 
    FLOOR(length / 10) * 10 AS length_group,
    AVG(rental_duration) AS avg_rental_duration
FROM 
    film
GROUP BY 
    length_group
ORDER BY 
    length_group;

## 4. Identify the top 3 films in each category based on their rental counts.
SELECT 
    category_name, title, rental_count FROM (
    SELECT 
        c.name AS category_name,
        f.title,
        COUNT(r.rental_id) AS rental_count,
        RANK() OVER (PARTITION BY c.name ORDER BY COUNT(r.rental_id) DESC) AS rnk
    FROM 
        rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY 
        c.name, f.title
) AS ranked
WHERE rnk <= 3 ;

## 5. Calculate the difference in rental counts between each customer's total rentals and the average rentalsacross all customers.
WITH customer_rentals AS (
    SELECT customer_id, COUNT(*) AS rental_count
    FROM rental
    GROUP BY customer_id
), avg_rentals AS (
    SELECT AVG(rental_count) AS avg_count FROM customer_rentals
)
SELECT 
    cr.customer_id,
    cr.rental_count,
    ar.avg_count,
    cr.rental_count - ar.avg_count AS difference_from_avg
FROM 
    customer_rentals cr, avg_rentals ar limit 10; 
    
## 6. Find the monthly revenue trend for the entire rental store over time.
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS monthly_revenue
FROM 
    payment
GROUP BY 
    month
ORDER BY 
    month;
    
## 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
WITH total_spending AS (
    SELECT 
        customer_id,
        SUM(amount) AS total_amount
    FROM payment
    GROUP BY customer_id
), spending_ranked AS (
    SELECT *, 
           NTILE(5) OVER (ORDER BY total_amount DESC) AS quintile
    FROM total_spending
)
SELECT * 
FROM spending_ranked
WHERE quintile = 1 limit 10; 

## 8. Calculate the running total of rentals per category, ordered by rental count.
use sakila;
SELECT 
    category.name AS category,
    film.title,
    COUNT(rental.rental_id) AS rental_count,
    SUM(COUNT(rental.rental_id)) OVER (PARTITION BY category.name ORDER BY COUNT(rental.rental_id) DESC) AS running_total
FROM 
    rental 
JOIN inventory  ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category  ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name, film.title limit 10; 

## 9. Find the films that have been rented less than the average rental count for their respective categories.
WITH film_rentals AS (
    SELECT 
        fc.category_id,
        f.film_id,
        f.title,
        COUNT(r.rental_id) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    GROUP BY fc.category_id, f.film_id, f.title
), category_avg AS (
    SELECT category_id, AVG(rental_count) AS avg_count
    FROM film_rentals
    GROUP BY category_id
)
SELECT 
    fr.title,
    fr.rental_count,
    ca.avg_count,
    c.name AS category
FROM film_rentals fr
JOIN category_avg ca ON fr.category_id = ca.category_id
JOIN category c ON c.category_id = fr.category_id
WHERE fr.rental_count < ca.avg_count limit 20;

## 10. Identify the top 5 months with the highest revenue and display the revenue generated in each .
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month,
    SUM(amount) AS revenue
FROM payment
GROUP BY month
ORDER BY revenue DESC
LIMIT 5;

# Normalisation & CTE

## 1. First Normal Form (1NF):
## a. Identify a table in the Sakila database that violates 1NF. Explain how youwould normalize it to achieve 1NF.
- Example: Hypothetical table violating 1NF: 'customer_phones' with multiple phone numbers in a single column
- Fix: Split into separate rows or move phone numbers into a new table with customer_id foreign key

## 2. Second Normal Form (2NF):
## a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.
- Example table: 'film_actor' with composite key (film_id, actor_id)
-  If it includes actor_name, it is not in 2NF. Fix: Move actor_name to 'actor' table, relate via actor_id.

## 3. Third Normal Form (3NF):
## a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.
- Example table: 'customer' has address_id, and address contains city_id, and city_id links to city
- If customer also contains city_name (transitive dependency), move city details to 'city' table and normalize
 
## 4. Normalization Process:
## a. Take a specific table in Sakila and guide through the process of normalizing it from the initial  unnormalized form up to at least 2NF.
 - Example: Start with unnormalized rental_customer table with repeated fields
- Step 1: Split repeating groups into rows (1NF)
- Step 2: Ensure each non-key attribute depends on whole key (2NF)
- Step 3: Remove transitive dependencies like storing city_name with address_id (3NF)

## 5. CTE Basics:
### a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the actor and film_actor tables.
WITH actor_films AS (
    SELECT actor_id, COUNT(film_id) AS film_count
    FROM film_actor
    GROUP BY actor_id
)
SELECT 
    a.first_name, a.last_name, af.film_count
FROM actor a
JOIN actor_films af ON a.actor_id = af.actor_id limit 20;

## 6. CTE with Joins:
### a. Create a CTE that combines information from the film and language tables to display the film title,language name, and rental rate.
WITH film_info AS (
    SELECT f.film_id, f.title, l.name AS language, f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM film_info limit 10; 

## 7. CTE for Aggregation:
### a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables.
WITH customer_revenue AS (
    SELECT customer_id, SUM(amount) AS total_revenue
    FROM payment
    GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, cr.total_revenue
FROM customer c
JOIN customer_revenue cr ON c.customer_id = cr.customer_id limit 10;

## 8. CTE with Window Functions:
### a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
WITH ranked_films AS (
    SELECT title, rental_duration,
           RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
    FROM film
)
SELECT * FROM ranked_films limit 10;

## 9. CTE and Filtering:
### a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details.
WITH frequent_customers AS (
    SELECT customer_id, COUNT(*) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > 2
)
SELECT c.*
FROM customer c
JOIN frequent_customers fc ON c.customer_id = fc.customer_id limit 10;

## 10. CTE for Date Calculations:
### a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table
WITH monthly_rentals AS (
    SELECT DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
           COUNT(*) AS total_rentals
    FROM rental
    GROUP BY rental_month
)
SELECT * FROM monthly_rentals limit 10;  

## 11. CTE and Self-Join:
### a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
WITH actor_pairs AS (
    SELECT fa1.film_id, fa1.actor_id AS actor1, fa2.actor_id AS actor2
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
)
SELECT ap.film_id, a1.first_name AS actor1_first, a1.last_name AS actor1_last,
       a2.first_name AS actor2_first, a2.last_name AS actor2_last
FROM actor_pairs ap
JOIN actor a1 ON ap.actor1 = a1.actor_id
JOIN actor a2 ON ap.actor2 = a2.actor_id
limit 10;


## 12. CTE for Recursive Search:
### a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column.
WITH RECURSIVE staff_hierarchy AS (
    SELECT staff_id, first_name, last_name, reports_to
    FROM staff
    WHERE staff_id = 1  -- Replace with manager's ID
    
    UNION ALL

    SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
    FROM staff s
    JOIN staff_hierarchy sh ON s.reports_to = sh.staff_id
)
SELECT * FROM staff_hierarchy;

 