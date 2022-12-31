# INST123 Final Group Project
INST123 (Databases for All) Section 0101<br />
Team Final Project Submission, December 13th 2020<br />
The Bookworms: Milo Gilad, Radhika Khare, Eesha Aggarwal, Malchu Pascual, Chenglei Si
## Introduction
Imagine a library without any sort of data. How will members be identified? How will librarians keep track of the books that are checked out? How will the number of copies of each book be counted? How will book return dates be remembered? Our database presents a solution to all these questions and many more. The database our team has created focuses on various books in a library. Our database contains data that has to do with the members of the library, borrowing records, the books in the library, author information, and publisher information. <br /><br />
Although we made a few minor changes along the way, the ultimate purpose of our database never changed. Some of the changes we made were to add primary and foreign key constraints to certain parts of the data set, such as the publisher_id, author_id, member_id, and book_id. We also stopped using the ISBN as a natural key and instead used book_id as a primary key, simply because we found that older books don’t always have an ISBN. The last minor change we made from our original plan was to keep the records in our database at a manageable amount. Although it would have been more realistic to have a database that contained the records for hundreds or maybe even thousands of books, for the purposes of this project, it made more sense to not have an excessive amount of data. <br /><br />
Books can be considered an integral part of many people’s lives. This database is helpful for monitoring the books people are using. With our database, our small library has the books organized and it is easy to keep track of information from all different aspects regarding the books. The many ways books in a library can be organized made this database an interesting project to construct.
## Database Description
### Physical Database
We have 5 tables to maintain our library. The first of these tables is our publishers table which contains a chronologically numbered ids which serve as the primary keys represented by column publisher_id, the names of the publishing company represented by column name, and locations of the headquarters listed as state, or if not applicable, city and country represented by column location.
The second table is for authors which includes their chronologically numbered ids which serve as the primary keys represented by column author_id, the author’s first names represented by column first_name, the author’s last names represented by column by column last_name, their genders represented by column gender, and their nationalities represented by column nationality.
	The next table we have contains the card-carrying members of our library which includes their chronologically numbered ids which serve as the primary keys represented by column member_id, the member’s first names represented by column first_name, and the member’s last names represented by column last_name.
Central to any good library database is a table containing books - our table includes the chronologically numbered book ids which serve as the primary keys represented by column book_id, a books’ ISBN values represented by column isbn, the publishers’ ids that refers to publishers table’s publisher ids as a foreign key represented by column publisher_id,  the authors’ ids that refers to authors table’s author ids as a foreign key represented by column author_id, the book names represented by column book_name, their genres represented by column book_genre, and the total number of copies of each book (could be available or checked out) in the library represented by column total_copies.

Lastly is our table holding borrowing records. This table’s columns the chronologically numbered borrower ids which serve as the primary keys represented by column borrow_id, unique ids of the members borrowing books that refers to members table’s member ids as a foreign key represented by column member_id, unique ids of the books borrowed that refers to books table’s book ids as a foreign key represented by column book_id, and the data the borrowed book needs to be returned represented by column return_by. 
We will only have one database that keeps track of the data for a singular library, rather than creating multiple database instances for separate branches of libraries. We won’t keep a record for every copy of each book, and consequently we don’t include details of each copy such as their conditions. We also won’t include the ratings or reviews, specific contents, summaries, or table of contents for any books. We do not include when a book was borrowed and we only keep track of currently checked out books - therefore we do not keep track of whether a book is returned or not (if it is, the record is simply removed from the borrowed books table).
### Sample Data
Our sample data consists primarily of acquiring real data about books, such as the author and publisher of each one. Then, we will also utilize hypothetical data, which will consist of the number of copies of each book in the library and the library patrons data. To provide a general collection of data for our library to act as a base, we will use the following comma-separated values (CSV) file from GitHub by jaidevd. We utilized a random generator to select 31 rows of data initially from this CSV file for the books and their corresponding author and publisher data. 
*	Base Library Data - books.csv - https://gist.github.com/jaidevd/23aef12e9bf56c618c41
To act as supplemental data for our base library data, the following websites will be utilized to acquire information regarding the data not provided by our base library data, such as the author’s nationality, the book’s ISBN, and publisher’s location.
*	Goodreads Database - https://www.goodreads.com/
*	ISBN Data - https://www.abebooks.com/books/search-number-code-10-13-digit/ISBN.shtml
However, we quickly discovered that the table didn’t provide us with the variety of data we desired to do analysis on our data through queries. This limitation arose since the dataset from  jaidevd was based on one’s personal library where overlap of various books’ authors or publishers was less prevalent than it would be in a real public library. We added an additional 30 records of data with hypothetical but plausible data that maintained internal consistency. 
Regarding our entirely hypothetical data, for the total copies of books we randomly generated a value between 1-10 as the number of copies of each book since we wanted a positive non zero value that would be plausible for a smaller public library. The member data and borrow records data are hypothetical but we maintain internal consistency with values such as the return by date including dates that are upcoming and have passed in the SQL date format.
### Queries
The following provides a summary of our queries in terms of the requirements. The following are brief descriptions of each of the queries:
*	Query 1: Utilizes the avg() aggregate function, subqueries, and filtering to find all the books whose total copies in the library are greater than or equal to the average number of copies for books. Uses JOIN to list out these books’ authors’ first and last names as well
*	Query 2: Uses count() and JOIN to sort publishers by the number of books they’ve published which have ended up in the library. Uses WHERE to only get publishers with 2 books or less.
*	Query 2.5: A variation of query 2.0 used to sort books by the number of borrows they have focusing on books borrowed 3 or less times
*	Query 3: Uses JOIN clause and filtering with WHERE to join the books and borrow_records tables on column book_id to allow member with member_id of 2 to see the title of the book they borrowed associated with the book_id, and to see the return date
*	Query 4: Uses JOIN on the members and borrow records tables and WHERE to find members with borrows not due yet (utilizing current date determined at time of query execution).
*	Query 5: Uses JOIN and GROUP BY and COUNT to determine the popularity ranking of books currently (based on the number of copies borrowed currently) by each genre. Uses dense_rank and PARTITION BY to obtain ranking grouped by genre, excluding any gaps in the order
## Changes from Original Design
The ID columns of each table in the original design were revised to include the name of the table they belonged to (i.e. publishers.id became publishers.publisher_id, members.id became members.member_id, and so on). 
Each table was updated to include primary keys where necessary, with the ID columns used as each table’s primary keys (for all tables except borrow_records, which does not use its own ID column). Foreign keys were also added when one table referenced another table’s ID column (books received foreign keys for authors.author_id and publishers.publisher_id, while borrow_records received foreign keys for members.member_id and books.book_id). 
Checks were added to each column in each table — columns of type varchar and date received the NOT NULL check (with the exception of books.ISBN and books.book_genre, both of which are permitted to be NULL in the event that no genre/ISBN was assigned to the book), and the books.total_copies column (which has the integer type) received a check ensuring its values would be greater than zero.
Originally, the ISBN column of the book table was planned to be used as the primary key for that table (“natural key”). After discovering that several older books were never assigned an ISBN, or had inconsistent ISBNs across different search engines, the book_id bigserial column was conceived as a replacement (although the ISBN column remains in the table — just not as the primary key).
The original dataset consisted of one row per table (i.e. one book, one author, one borrow record, one publisher, one member). Our completed dataset now contains 61 books, 41 borrow records, 27 authors, 20 library members, and 19 publishers.
## Lessons Learned
Throughout our process of completing this project, we have come to learn a few lessons along the way. At the beginning of the project, we initially had some trouble finding and selecting a dataset for our database. We were considering using a single dataset from a single source to represent a library, or using a base dataset and building from that using various sources and also creating some data on our own. We resolved this problem by choosing the latter because it would create a cleaner and more cohesive dataset. We learned that it is important to ensure that the data you are working with and inputting into the database is clean. If we had not opted to create a cleaner dataset to use by settling with a single csv file from a single source, it would have been difficult to work with our database.
	Another lesson we learned was that it is important to establish good communication. We once had difficulty understanding certain aspects of the project regarding the requirements and instructions. Some of them were vague or nonexistent which led to some confusion on our end. To resolve this, we contacted the professor for clarification to ensure we were doing our job correctly. We learned that communication is essential in all kinds of work. It is inevitable that misunderstandings occur, so it is important to communicate with each other to get on the same page.
	Additionally, we learned that it is crucial to formulate our plans and work early. Over the course of the time working on this project, there were multiple due dates that needed to be met. Especially working as a team, collaborating on each part of an assignment efficiently was something we became more proficient in. Unavoidably, we would run into some minor issues, but given the fact we began our work earlier, we had sufficient time to resolve these issues to ensure a successful submission. 
## Potential Future Work
There are several aspects that we can further expand our project as future work. Firstly, one of the challenges that we faced was to obtain sufficient data. Currently we only have a limited number of rows in the tables, which is more for demonstration purposes. If we are to expand the project into real use cases, we should collect much more real book data and import them into our database so that people can really search for specific information about any books using SQL queries. We have found that collecting real-life data is definitely a non-trivial task, for example, the book data that we directly scraped from online sites are usually not complete, and we have to perform additional search online to find out information about the book authors, the publisher information, etc. This can be a tedious process and not very scalable. To further improve on that as future work, we might need to automate this process, for example, by writing a script to perform all the multi-hop searches to collect all the relevant information about books, authors and publishers. 
Secondly, our current database implementation stores all books in the same table. For future work, where we will have many more books, it might be a better choice to split all books and put into several different tables, so that we can perform our queries more efficiently. For example, we may have one table for books of each genre. With such an implementation, if we want to find a science fiction book, we wouldn’t need to search over all books and perform a match, we could just perform this match in the science fiction books table, which would be much more efficient. 
Lastly, we can add more columns into the tables to include more details about the books, book authors, members, borrow records and publishers. For example, we can include the authors’ born dates (ages) in the author’s table, we can also include the number of times that each library member missed a borrow due date in the members table, which could be very useful in certain real-life use cases.
## References
AbeBooks. ISBN Search. http://www.abebooks.com/books/search-number-code-10-13-digit/ISBN.shtml. Accessed 10 Dec. 2020.<br />
Deshpande, Jaidev. “Books.Csv.” Gist, https://gist.github.com/jaidevd/23aef12e9bf56c618c41. Accessed 10 Dec. 2020.<br />
ISBNsearch.org. ISBN Search. https://isbnsearch.org/. Accessed 10 Dec. 2020.
