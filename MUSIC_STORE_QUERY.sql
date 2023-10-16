  -- 1. Who is the senior most employee based on job title 


       select *  from employee 
       where reports_to is null


	   ------



  -- 2. Which country has the most invoices 

       select billing_country,  count(1) as occurence_time from invoice 
       group by billing_country
       ORDER BY count(1) DESC



	   ------



  -- 3. What are top 3 values of total invoice 

       select top 3 total from invoice
       order by total desc



	   ------



  -- 4. Which city has the best customers. we would like to throw a promotional music festival in the city we made the most money. write a query that returns one city that has the highest sum of invoice totals. return both the city name and sum of alll invoicce totals.

       select billing_city , sum(total) from invoice 
       group by  billing_city
       order by sum(total) desc


	   ------



  -- 5. Who is the best customer ? The customer who has spent the most money will be declared the best customer. write a query that returns the person who has spent the most money
       

       select iv.customer_id,first_name,last_name,sum(total) as totals from customer as cu
       join invoice as iv
       on cu.customer_id = iv.customer_id 
       group by iv.customer_id, first_name,last_name
       order by sum(total) desc



	   ------




  -- 6. Write query to return the email ,firstname , lastname , & genre of all rock music listeners. Return your list ordered alphabetically by email starting with A.
       

       select distinct email, first_name, last_name ,ge.name , ge.genre_id from genre as ge
       join track as tr
       on ge.genre_id = tr.genre_id
       join invoice_line as il
       on il.track_id = tr.track_id
       join invoice as iv
       on iv.invoice_id = il.invoice_id
       join customer as cu
       on cu.customer_id = iv.customer_id
       where ge.name = 'rock'
       order by email 



	   ------




  -- 7. Lets invite the artist who have written the most music in our dataset. Write a query that returns artist name and total track count of the top 10 rock bands.
       


       select top 10 ast.name , ast.artist_id, count(1) as total from artist as ast
       join album as al
       on ast.artist_id = al.artist_id 
       join track as tr
       on tr.album_id = al.album_id
       join genre as ge
       on ge.genre_id = tr.genre_id
       where ge.name = 'rock'
       group by ast.artist_id, ast.name
       order by count(1) desc



	   ------




   --8. find how much amount spent by each customer on artists. write a query to return name , artists name and total spent.
      

       select first_name , last_name, ar.artist_id ,ar.name , sum(il.unit_price*il.quantity) as total_sales    from customer as cu
       join invoice as iv  on cu.customer_id = iv.customer_id
       join invoice_line as il  on iv.invoice_id = il.invoice_id
       join track as tr on il.track_id = tr.track_id
       join album as al on tr.album_id = al.album_id
       join artist as ar on al.artist_id = ar.artist_id
       group by first_name , last_name, ar.artist_id ,ar.name



	   ------


 
  -- 9. find the top artist name on the basis of total spend and then find customer details with amount spent on top artist.


       select first_name , last_name, ar.artist_id ,ar.name , sum(il.unit_price*il.quantity) as total_sales    from customer as cu
       join invoice as iv  on cu.customer_id = iv.customer_id
       join invoice_line as il  on iv.invoice_id = il.invoice_id
       join track as tr on il.track_id = tr.track_id
       join album as al on tr.album_id = al.album_id
       join artist as ar on al.artist_id = ar.artist_id
       group by first_name , last_name, ar.artist_id ,ar.name
       having ar.name =(
       select top 1 ar.name    from customer as cu
       join invoice as iv  on cu.customer_id = iv.customer_id
       join invoice_line as il  on iv.invoice_id = il.invoice_id
       join track as tr on il.track_id = tr.track_id
       join album as al on tr.album_id = al.album_id
       join artist as ar on al.artist_id = ar.artist_id
       group by first_name , last_name, ar.artist_id ,ar.name
       order by sum(il.unit_price*il.quantity) desc
       )
       order by total_sales desc