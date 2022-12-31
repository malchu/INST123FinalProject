--Query 1
/*utilizes aggregate functions, subqueries, and filtering to
find all the books (name and id) listed with their authors's
first and last names whose total copies in the library is greater
than or equal the average number of copies for books*/
SELECT BK.book_id, BK.book_name, authors.first_name,
authors.last_name, BK.total_copies
FROM (SELECT total_copies, book_id, book_name, author_id 
	FROM books 
	WHERE total_copies >= (
	SELECT avg(total_copies)
	FROM books ) 
ORDER BY total_copies DESC) AS BK
JOIN authors ON authors.author_id = BK.author_id
ORDER BY BK.total_copies DESC;

--Query 2
/* Uses COUNT and JOIN to sort publishers by the number of books they’ve published which have ended up in the library. 
Uses where to only get publishers with 2 books or less. */
SELECT
    publishers.name,
    count(*) AS books_published
FROM books
JOIN publishers
    ON publishers.publisher_id = books.publisher_id
GROUP BY publishers.name
HAVING COUNT(*) <= 2
ORDER BY books_published DESC;

--Query 3
/*uses JOIN clause and form of filtering to join the 
books and borrow_records tables on column book_id to allow
member #2 to see the title of the book they borrowed associated with the book_id, 
and to see the return date*/
SELECT borrow_records.member_id,
		books.book_id,
		borrow_records.book_id,
		books.book_name,
		books.book_genre,
		borrow_records.return_by
FROM books JOIN borrow_records
ON books.book_id = borrow_records.book_id
WHERE borrow_records.member_id = 2;

--Query 4
/*
Use JOIN and WHERE to find members with borrows not due yet.
*/
SELECT  members.member_id, 
		members.first_name,
		members.last_name,
		borrow_records.book_id,
		borrow_records.return_by 
FROM members JOIN borrow_records 
ON members.member_id = borrow_records.member_id 
WHERE borrow_records.return_by > current_date;

--Query 5
/*Uses JOIN and GROUP BY and COUNT to determine the popularity ranking of 
books currently (based on the number of copies borrowed currently) by each 
genre. Uses dense_rank and PARTITION BY to obtain ranking grouped by genre, 
excluding any gaps in the order*/
SELECT
	books.book_genre as "Genre",
	books.book_name as "Book Title",
	count(borrow_records.book_id) as "Copies Borrowed",
dense_rank() OVER (PARTITION BY books.book_genre 
	ORDER BY COUNT(borrow_records.book_id) DESC) as "Popularity Ranking"
FROM books JOIN borrow_records
	ON books.book_id = borrow_records.book_id
GROUP BY books.book_genre, books.book_name;

--Query 2.5
/* Variation of Query 2 created for the sole
purpose of getting at least 30 rows of output since
Query 2 does not while utilizing JOIN Uses COUNT and 
JOIN to sort book title by the how many copies
are borrowed according to borrow records
Uses where to only get books with 3 or less copies borrowed */
SELECT
    books.book_name,
    count(*) AS books_borrowed
FROM borrow_records
JOIN books
    ON books.book_id = borrow_records.book_id
GROUP BY books.book_name
HAVING COUNT(*) <= 3
ORDER BY books_borrowed DESC;
