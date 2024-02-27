use sakila; 
# 1. Rank films by length (filter out the rows with nulls or zeros in length column).
# Select only columns title, length and rank in your output.
select * from film; 
select title, 
       length,
       rank() over(order by length desc) as films_rank
       from film; 
      
      
       
# 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in 
#length column). In your output, only select the columns title, length, rating and rank.
select * from film; 
select title,
       length,
       rating,
       rank() over( order by length desc) as ranking
       from film; 
       
       
# 3. How many films are there for each of the categories in the category table? Hint:
# Use appropriate join between the tables "category" and "film_category".
select * from film_category; 
select * from category; 

select c.category_id, c.name, count(film_id) as total_films
from category c
join film_category f
on c.category_id = f.category_id
group by category_id
order by total_films desc; 

select count(film_id) from film_category; 


# 4. Which actor has appeared in the most films? Hint: 
#You can create a join between the tables "actor" and "film actor" and count the number of 
#times an actor appears.
select a.actor_id, a.first_name, a.last_name,
       count(actor_id) as film_count
from actor a
join film_actor using (actor_id)
group by actor_id
order by film_count desc
limit 1; # Gina Degeneres

#5. Which is the most active customer (the customer that has rented the most number of films)? 
#Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for 
#each customer.
select * from customer; 
select * from rental; 

select c.customer_id, count(rental_id), first_name, last_name from customer c
join rental r
on c.customer_id = r.customer_id
group by customer_id
order by count(rental_id) desc
limit 1; #Eleanor Hunt with 46 rentals

# Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
# Hint: You can use join between three tables - "Film", 
#"Inventory", and "Rental" and count the rental ids for each film.
select * from film; 
select * from inventory; 
select * from rental; 

select f.title, count(f.title) as rentals from film f 
join
	(select r.rental_id, i.film_id FROM rental r 
    join
    inventory i on i.inventory_id = r.inventory_id) a
    on a.film_id = f.film_id group by f.title order by rentals desc
    limit 1; 


 