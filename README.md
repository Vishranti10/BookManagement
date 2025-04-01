# README for Book Management System

Overview

This is a Java-based Book Management System built using Servlets, JSP, and MySQL. The system allows users to:

- View all books in the database
- Add new books
- Edit existing book information
- Delete books
- Search for books by title or author

Technologies Used

- Java 8+
- Java Servlets
- JSP (JavaServer Pages)
- MySQL Database
- JDBC for database connectivity
- Bootstrap 5 for UI styling
- Apache Tomcat 9+ as the web server

Prerequisites

Before you begin, ensure you have the following installed:

1. Java JDK 8 or later
2. Apache Tomcat 9 or later
3. MySQL Server
4. MySQL Connector/J (JDBC driver)

Setup Instructions

Database Setup

1. Create a MySQL database named `bookshop`:

   
   CREATE DATABASE bookshop;


2. Create the `books` table:

   
   USE bookshop;

   CREATE TABLE books (
       id INT AUTO_INCREMENT PRIMARY KEY,
       title VARCHAR(255) NOT NULL,
       author VARCHAR(255) NOT NULL,
       genre VARCHAR(100),
       availability_status VARCHAR(50) NOT NULL
   );
   

3. Update the database credentials in `DBConnection.java`:

   
   private static final String URL = "jdbc:mysql://localhost:3306/bookshop";
   private static final String USER = "your_username"; 
   private static final String PASSWORD = "your_password";
   
 Project Deployment

1. Clone this repository to your local machine.

2. Compile all Java files in the `src` directory:

   
   javac -cp "path/to/tomcat/lib/servlet-api.jar:path/to/mysql-connector-java.jar" com/bookshop/servlet/*.java com/bookshop/database/*.java -d WEB-INF/classes/
   

3. Copy the entire project folder to Tomcat's `webapps` directory.

4. Copy the MySQL Connector/J JAR file to Tomcat's `lib` directory.

5. Start your Tomcat server.

Features

View All Books

- Accessible via `/ViewBooksServlet`
- Displays all books in a table format with edit/delete options

Add New Book

- Accessible via `/addBook.jsp`
- Form to input book details (title, author, genre, availability status)

 Edit Book

- Click "Edit" button on any book in the view
- Modal form appears with pre-filled book information
- Changes are saved to the database

Delete Book

- Click "Delete" button on any book in the view
- Confirmation dialog appears before deletion

Search Books

- Accessible via `/searchBook.jsp`
- Search by title and/or author (supports partial matching)
- Results displayed in a table

Troubleshooting

 Common Issues

1. Database Connection Errors:

   - Verify MySQL is running
   - Check credentials in `DBConnection.java`
   - Ensure MySQL Connector/J is in Tomcat's `lib` directory

2. 404 Errors:

   - Verify the application is deployed in Tomcat's `webapps` directory
   - Check URL paths match servlet annotations

3. Class Not Found Errors:

   - Ensure all Java classes are compiled and in the correct package structure
   - Verify servlet-api.jar is in the classpath during compilation
