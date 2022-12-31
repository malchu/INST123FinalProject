CREATE TABLE publishers (
    publisher_id bigserial,
    name varchar(100) NOT NULL,
    location varchar(100) NOT NULL,
    CONSTRAINT publisher_key PRIMARY KEY (publisher_id)
);

CREATE TABLE authors (
    author_id bigserial,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    gender varchar(20) NOT NULL,
    nationality varchar(50) NOT NULL,
    CONSTRAINT author_key PRIMARY KEY (author_id)
);

CREATE TABLE members (
    member_id bigserial,
    first_name varchar(50) NOT NULL,
    last_name varchar(50) NOT NULL,
    CONSTRAINT member_key PRIMARY KEY (member_id)
);

CREATE TABLE books (
    book_id bigserial,
    ISBN varchar(50),
    publisher_id bigserial REFERENCES publishers (publisher_id),
    author_id bigserial REFERENCES authors (author_id),
    book_name varchar(90) NOT NULL,
    book_genre varchar(50),
    total_copies integer CHECK (total_copies > 0),
    CONSTRAINT book_key PRIMARY KEY (book_id)
);

CREATE TABLE borrow_records (
    member_id bigserial REFERENCES members (member_id),
    book_id bigserial REFERENCES books (book_id),
    return_by date NOT NULL
);

COPY publishers (name, location)
FROM 'C:\Users\Public\publishers.csv' 
WITH (FORMAT CSV);

COPY authors (first_name, last_name, gender, nationality)
FROM 'C:\Users\Public\authors.csv' 
WITH (FORMAT CSV);

COPY books (ISBN, publisher_id, author_id, book_name, book_genre, total_copies)
FROM 'C:\Users\Public\books.csv' 
WITH (FORMAT CSV);



 
