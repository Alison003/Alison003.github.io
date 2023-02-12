SELECT 'CSC4410-20739 W22 Final Project - Sakila database' AS '';
 
SELECT '1. Put your name on the following line' AS '';
SELECT 'Name: Alison Langer' AS '';
SELECT ' ' AS '';

SELECT 'show databases' AS '';
show databases; -- Do not remove this line.

SELECT 'Put any needed setup sql commands here' AS '';

USE sakila;

SELECT '___ SAMPLE QUESTION ______________________ ' AS '';
SELECT '0. Which actors have the first name \'Sandra\'' AS '';
SELECT ' ' AS '';
SELECT 'The exected results is:' AS '';
SELECT '+------------+-----------+' AS '';
SELECT '| first_name | last_name |' AS '';
SELECT '+------------+-----------+' AS '';
SELECT '| SANDRA     | KILMER    |' AS '';
SELECT '| SANDRA     | PECK      |' AS '';
SELECT '+------------+-----------+' AS '';
SELECT '_______ Your result:' AS '';
select first_name, last_name from actor where first_name='SANDRA'; -- Do not remove this line.
SELECT '___ END OF SAMPLE QUESTION _______________' AS '';

SELECT '______________________' AS '';
SELECT '2. Which actors have the last name \'Depp\'' AS '';

select first_name, last_name from actor where last_name='DEPP';

SELECT '______________________' AS '';
SELECT '3. How many distinct actors last names are there? ' AS '';

SELECT COUNT(DISTINCT last_name) AS distinct_last_names FROM actor;

SELECT '______________________' AS '';
SELECT '4. What are the 3 most common last names? ' AS '';

SELECT last_name FROM (SELECT last_name, COUNT(last_name) AS frequency FROM actor GROUP BY last_name ORDER BY frequency DESC) AS table_2
WHERE frequency IN (5, 4, 3);

SELECT '______________________' AS '';
SELECT '5. What are the 4 most common first names? ' AS '';

SELECT first_name FROM (SELECT first_name, COUNT(first_name) AS frequency FROM actor GROUP BY first_name ORDER BY frequency DESC) AS table_2
WHERE frequency IN (4, 3, 2);

SELECT '______________________' AS '';
SELECT '6. Which first names are not repeated? Alphabetize the list.' AS '';

SELECT first_name FROM actor GROUP BY first_name HAVING COUNT(first_name) = 1 ORDER BY first_name ASC;

SELECT '______________________' AS '';
SELECT '7. How many unique last names are there?' AS '';

SELECT COUNT(DISTINCT(last_name)) AS unique_last_names FROM actor;

SELECT '______________________' AS '';
SELECT '8. Which last names appear more than once? Alphabetize the list.' AS '';

SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(last_name) > 1 ORDER BY last_name ASC;

SELECT '______________________' AS '';
SELECT '9. Which actor has appeared in the most films?' AS '';

SELECT first_name, last_name FROM actor INNER JOIN film_actor AS film ON actor.actor_id=film.actor_id GROUP BY film.actor_id ORDER BY COUNT(film.actor_id) DESC LIMIT 1;

SELECT '______________________' AS '';
SELECT '10. Which rating has the most films?' AS '';

SELECT rating FROM film GROUP BY rating ORDER BY COUNT(rating) DESC LIMIT 1;

SELECT '______________________' AS '';
SELECT '11. Which country has the most customers?' AS '';

SELECT country FROM country 
INNER JOIN city AS C ON country.country_id=C.country_id
INNER JOIN address AS A ON C.city_id=A.city_id
INNER JOIN customer ON A.address_id=customer.address_id
GROUP BY country ORDER BY COUNT(customer_id) DESC LIMIT 1;

SELECT '______________________' AS '';
SELECT '12. How many documentaries are there?' AS '';

SELECT COUNT(category_id) AS documentaries FROM film_category WHERE category_id=6;

SELECT '______________________' AS '';
SELECT '13. What is that average replacement cost of all the films in the sakila DB? (ignoring inventory, $##.##)' AS '';

SELECT CONCAT('$', FORMAT(AVG(replacement_cost),2)) AS avg_replacement_cost FROM film;

SELECT '______________________' AS '';
SELECT '14. What is that average repalcement cost of all the films in the sakila DB? (taking inventory into consideration, $##.##)' AS '';

SELECT CONCAT('$', FORMAT(AVG(replacement_cost),2)) AS all_replacement_cost FROM film INNER JOIN inventory ON film.film_id=inventory.film_id;

SELECT '______________________' AS '';
SELECT '15. What is the average replacement_cost of films by category? (ignoring inventory, $##.##)' AS '';

SELECT CONCAT('$', FORMAT(AVG(replacement_cost),2)) AS average_replacement, `name` AS category FROM film
INNER JOIN film_category ON film.film_id=film_category.film_id
INNER JOIN category ON film_category.category_id=category.category_id
GROUP BY `name`;

SELECT '______________________' AS '';
SELECT '16. Insert a record to represent the film \'Walt Disney Treasures: The Chronological Donald, Vol. 4 - 1951-1961 (Collector\'s Tin)\', with a replacment cost of $689.90.
\! echo NOTE: you can look it up on Amazon. Crazy, huh?' AS '';

INSERT INTO film (film_id, title, `description`, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features, last_update) 
VALUES (NULL, 'Walt Disney Treasures: The Chronological Donald, Vol. 4 - 1951-1961 (Collector\'s Tin)', NULL, NULL, 1, 3, 8.99, NULL, 689.90, NULL, NULL, '2006-02-15 05:03:42');

SELECT '______________________' AS '';
SELECT '17. How many films are there now?' AS '';

SELECT COUNT(film_id) AS count FROM film;

SELECT '______________________' AS '';
SELECT '18. What is the new average replacement cost of all the films in the sakila DB? (ignoring inventory, $##.##)' AS '';

SELECT CONCAT('$', ROUND(AVG(replacement_cost),2)) AS average_replacement FROM film;

SELECT '______________________' AS '';
SELECT '19. Which film categories average longer than 2 hours? (no fractional minutes)' AS '';

SELECT `name` FROM category
INNER JOIN film_category ON film_category.category_id=category.category_id
INNER JOIN film ON film_category.film_id=film.film_id
GROUP BY name
HAVING AVG(FORMAT(film.length,0)) > 120;

SELECT '______________________' AS '';
SELECT '20. How many copies of \'Maguire Apache\' are available for rent from Store 1?' AS '';

SELECT COUNT(film_id) AS copies FROM inventory WHERE (store_id=1 AND film_id=550);

SELECT '______________________' AS '';
SELECT '21. How many copies of that film are available for rent from Store 2?' AS '';

SELECT COUNT(film_id) AS copies FROM inventory WHERE (store_id=2 AND film_id=550);

SELECT '______________________' AS '';
SELECT '22. Answer the following question,' AS '';
SELECT 'by formatting each line of your answer as:' AS '';
SELECT 'SELECT \'Your_Answer\' AS '';' AS '';
SELECT 'so it shows up in the output.txt file.' AS '';

SELECT 'Why does this query return the empty set, and no error?' AS '';

select * from film natural join inventory; -- Do not remove this line.

SELECT 'This is because natural join acts as an inner join between the two tables.' AS '';
SELECT 'This query returns an empty set because there are no rows that match in both tables.' AS '';
SELECT 'This means that the ON requirement is never true so no rows are returned.' AS '';


SELECT '______________________' AS '';
SELECT '23. Answer the following question,' AS '';
SELECT 'by formatting each line of your answer as:' AS '';
SELECT 'SELECT \'Your_Answer\' AS '';' AS '';
SELECT 'so it shows up in the output.txt file.' AS '';

SELECT 'Which two questions/queries/reports in this list were the hardest? Why?' AS '';

SELECT 'For me, the two hardest questions were 15 and 19.' AS '';
SELECT '15 was difficult because it required two joins to acheive the result.' AS '';
SELECT '19 was difficult becasue it used an aggregate function, 2 joins as well as a grouping condition.' AS '';

SELECT 'That is all.' AS '';
SELECT '______________________ EOF' AS '';
