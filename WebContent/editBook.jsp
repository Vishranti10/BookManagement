<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .form-container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {	
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-cancel {
            background-color: #f44336;
        }
        .btn-cancel:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Edit Book</h1>
        
        <% 
            String[] book = (String[]) request.getAttribute("book");
            if (book == null) {
                response.sendRedirect("ViewBooksServlet");
                return;
            }
        %>
        
        <form action="${pageContext.request.contextPath}/EditBookServlet" method="post">
            <input type="hidden" name="id" value="<%= book[0] %>">
            
            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" id="title" name="title" value="<%= book[1] %>" required>
            </div>
            
            <div class="form-group">
                <label for="author">Author:</label>
                <input type="text" id="author" name="author" value="<%= book[2] %>" required>
            </div>
            
            <div class="form-group">
                <label for="genre">Genre:</label>
                <input type="text" id="genre" name="genre" value="<%= book[3] %>" required>
            </div>
            
            <div class="form-group">
                <label for="availability">Availability:</label>
                <select id="availability" name="availability">
                    <option value="Available" <%= book[4].equals("Available") ? "selected" : "" %>>Available</option>
                    <option value="Checked Out" <%= book[4].equals("Checked Out") ? "selected" : "" %>>Checked Out</option>
                </select>
            </div>
            
            <div class="form-group">
                <button type="submit" class="btn">Update Book</button>
                <a href="ViewBooksServlet" class="btn btn-cancel">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>