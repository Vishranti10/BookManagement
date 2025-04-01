<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Book</title>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body { font-family: Arial, sans-serif; margin: 20px; }
    .container { width: 50%; margin: 0 auto; }
    .form-group { margin-bottom: 15px; }
    label { display: inline-block; width: 120px; }
    input[type="text"], select { width: 200px; padding: 5px; }
    .button { 
        padding: 8px 15px; 
        background-color: #4CAF50; 
        color: white; 
        border: none; 
        cursor: pointer; 
    }
    .button:hover { background-color: #45a049; }
</style>
</head>
<body>


<div class="container">

    <form action="searchBook.jsp" method="post" style="margin-top: 50px;">
    <button type="submit" class="btn btn-secondary">Back</button>
</form>
    
    <h1>Add New Book</h1> 
    
    <form action="AddBookServlet" method="post">
        <div class="form-group">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required>
        </div>
        
        <div class="form-group">
            <label for="author">Author:</label>
            <input type="text" id="author" name="author" required>
        </div>
        
        <div class="form-group">
            <label for="genre">Genre:</label>
            <input type="text" id="genre" name="genre" required>
        </div>
        
        <div class="form-group">
            <label for="availability">Availability:</label>
            <select id="availability_status" name="availability_status" required>
    <option value="Available">Available</option>
    <option value="Checked Out">Checked Out</option>
</select>

        </div>
        
        <div class="form-group">
            <input type="submit" value="Add Book" class="button">
            
        </div>
    </form>
</div>
</body>
</html>
