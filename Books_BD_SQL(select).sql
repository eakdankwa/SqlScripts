/*1. What is the output of this query? Select * from Book where PurchaseCost >12;
2. What is the output of this query? Select DISTINCT Category from Book;
3. Write a SQL query to retrieve all the data from Book where Status equals “out”.
4. Write SQL statement to retrieve only the first 3 rows from book.
5. Write a SQL statement to count all books where the Category equals Travel.
6. Write SQL statements to delete the books with ISBN of “978-1-119-95055-02-4,
978-0-261-81762-01-2" */

select * from books.book where `Purchase Cost` > 12; -- Q1
Select DISTINCT Category from books.book;            -- Q2
select * from books.book where Status = 'Out';       -- Q3
select * from book limit 3;                          -- Q4
select * from book where Category = 'Travel';        -- Q5
delete from book where `Book ISBN` IN ("978-1-119-95055-02-4","978-0-261-81762-01-2");   -- Q6
select * from book  where `Book ISBN` IN ("978-1-119-95055-02-4");  -- Just to form the delete statement

