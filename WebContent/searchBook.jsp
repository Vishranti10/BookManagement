<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.bookshop.servlet.SearchBookServlet" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Books</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px;
            position: relative;
            padding-bottom: 100px;
        }
        .container { 
            width: 80%; 
            margin: 0 auto; 
        }
        .form-group { 
            margin-bottom: 15px; 
        }
        label { 
            display: inline-block; 
            width: 120px; 
            font-weight: bold;
        }
        input[type="text"] { 
            width: 300px; 
            padding: 8px; 
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .button { 
            padding: 8px 20px; 
            background-color: #4CAF50; 
            color: white; 
            border: none; 
            border-radius: 4px;
            cursor: pointer; 
            font-size: 16px;
        }
        .button:hover { 
            background-color: #45a049; 
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 3px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e9e9e9;
        }
        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .action-btn {
            padding: 8px 15px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .action-btn:hover {
            background-color: #218838;
        }
        .add-book-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #007bff;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .add-book-btn:hover {
            background-color: #0069d9;
        }
        .view-books-btn {
            position: fixed;
            bottom: 20px;
            left: 20px;
            background-color: #6c757d;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .view-books-btn:hover {
            background-color: #5a6268;
        }
        .error {
            color: #d9534f;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ebccd1;
            background-color: #f2dede;
            border-radius: 4px;
        }
        .no-results {
            color: #777;
            font-style: italic;
            margin: 20px 0;
            padding: 10px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="action-buttons">
        <a href="addBook.jsp" class="action-btn">+ Add New Book</a>
        <a href="ViewBooksServlet" class="action-btn">View All Books</a>
    </div>
    
    <h1>Search Books</h1>
    
    <form action="SearchBookServlet" method="post">
        <div class="form-group">
            <label for="title">Book Title:</label>
            <input type="text" id="title" name="title" 
                   value="<%= request.getAttribute("searchTitle") != null ? 
                          request.getAttribute("searchTitle") : "" %>">
        </div>
        <div class="form-group">
            <label for="author">Author Name:</label>
            <input type="text" id="author" name="author"
                   value="<%= request.getAttribute("searchAuthor") != null ? 
                          request.getAttribute("searchAuthor") : "" %>">
        </div>
        <div class="form-group">
            <input type="submit" value="Search" class="button">
        </div>
    </form>

    <%-- Display error message if any --%>
    <% if (request.getAttribute("error") != null) { %>
        <div class="error">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <%-- Display search results --%>
    <% 
        List<SearchBookServlet.Book> books = (List<SearchBookServlet.Book>) request.getAttribute("books");
        if (books != null) {
            if (books.isEmpty()) {
    %>
                <div class="no-results">
                    No books found matching your search criteria.
                </div>
    <%      } else { %>
                <table>
                    <thead>
                        <tr>
                            
                            <th>Title</th>
                            <th>Author</th>
                            <th>Genre</th>
                            <th>Availability</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (SearchBookServlet.Book book : books) { %>
                            <tr>
                                
                                <td><%= book.getTitle() %></td>
                                <td><%= book.getAuthor() %></td>
                                <td><%= book.getGenre() %></td>
                                <td><%= book.getAvailabilityStatus() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
    <%      }
        } %>
</div>



</body>
</html>