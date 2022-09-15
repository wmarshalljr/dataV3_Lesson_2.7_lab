-- LAB 2.7

USE sakila; 

-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.

SELECT c.category_id, c.name, COUNT(f.category_id)
FROM sakila.category c
JOIN film_category f 
ON c.category_id = f.category_id
GROUP BY c.category_id
ORDER BY COUNT(f.category_id) DESC;

-- Answer: Sports with 74 films

-- 2. Display the total amount rung up by each staff member in August of 2005.

SELECT first_name, last_name, SUM(amount) as August_amount
FROM staff s
JOIN payment p USING(staff_id)
WHERE DATE(p.payment_date) LIKE '2005-08-%'
GROUP BY p.staff_id;

-- I had trouble isolating the month with BETWEEN so I used the LIKE function instead.

-- (Assuming the amount is in currency, not a count of rentals they wrung up in August)

-- 3. Which actor has appeared in the most films?

SELECT a.actor_id, a.first_name, a.last_name, COUNT(DISTINCT f.film_id)
FROM sakila.film_actor f
JOIN actor a
ON f.actor_id = a.actor_id
GROUP BY f.actor_id
ORDER BY COUNT(DISTINCT f.film_id) DESC;

-- Answer: Gina Degeneres with 42 films

-- 4. Most active customer (the customer that has rented the most number of films)

SELECT c.customer_id as 'customer_id', c.first_name, c.last_name, COUNT(r.rental_id) as 'number of rentals'
FROM sakila.customer c
JOIN sakila.rental r USING(customer_id)
GROUP BY c.customer_id
ORDER BY COUNT(r.rental_id) DESC;

-- Answer: Eleanor Hunt is the most active customer with 46 rentals

-- 5. Display the first and last names, as well as the address, of each staff member.

SELECT s.first_name, s.last_name, a.address
FROM sakila.staff s
JOIN sakila.address a
ON a.address_id = s.address_id;

-- 6. List each film and the number of actors who are listed for that film.

SELECT f.title as 'film title', COUNT(fa.actor_id) as 'number of actors'
FROM sakila.film f
JOIN sakila.film_actor fa USING(film_id)
GROUP BY f.title
ORDER BY COUNT(fa.actor_id) DESC;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.

SELECT c.first_name, c.last_name, SUM(p.amount) as 'total payment'
FROM sakila.payment p 
JOIN sakila.customer c USING(customer_id)
GROUP BY c.first_name, c.last_name
ORDER BY LAST_NAME ASC;
