<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .book-table { margin-top: 20px; }
        .action-btns { white-space: nowrap; }
    </style>
</head>
<body>
    <div class="container">
    
  <form action="searchBook.jsp" method="post" style="margin-top: 50px;">
    <button type="submit" class="btn btn-secondary">Back</button>
</form>

        <h1 class="my-4">Book Management</h1>
        
        <% List<String[]> books = (List<String[]>) request.getAttribute("books"); %>
        
        <div class="alert alert-info">
            Total books: <%= books != null ? books.size() : 0 %>
        </div>

        <table class="table table-striped book-table">
     <thead class="table-dark">
    <tr>
        <th>Title</th>
        <th>Author</th>
        <th>Genre</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>
</thead>
<tbody>
    <% if (books != null && !books.isEmpty()) { 
        for (String[] book : books) { %>
            <tr data-id="<%= book[0] %>"> <!-- ID stored here for JavaScript use -->
                <td class="book-title"><%= book[1] %></td>
                <td class="book-author"><%= book[2] %></td>
                <td class="book-genre"><%= book[3] %></td>
                <td class="book-availability_status"><%= book[4] %></td>
                <td class="action-btns">
                    <button class="btn btn-sm btn-primary edit-btn">Edit</button>
                    <form class="d-inline" action="DeleteBookServlet" method="post"
                        onsubmit="return confirm('Delete this book?');">
                        <input type="hidden" name="id" value="<%= book[0] %>">
                        <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                    </form>
                </td>
            </tr>
    <%   } 
    } else { %>
        <tr>
            <td colspan="5" class="text-center">No books found</td>
        </tr>
    <% } %>
</tbody>

        </table>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Book</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editForm">
                        <input type="hidden" id="editId" name="id">
                        <div class="mb-3">
                            <label class="form-label">Title</label>
                            <input type="text" class="form-control" id="editTitle" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Author</label>
                            <input type="text" class="form-control" id="editAuthor" name="author" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Genre</label>
                            <input type="text" class="form-control" id="editGenre" name="genre" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Status</label>
                            <select class="form-select" id="editAvailability" name="availability_status">
                                <option value="Available">Available</option>
                                <option value="Checked Out">Checked Out</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="updateBtn">Save Changes</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            // Initialize modal
            const editModal = new bootstrap.Modal(document.getElementById('editModal'));
            
            // Edit button click handler
            $('.edit-btn').click(function() {
                const row = $(this).closest('tr');
                $('#editId').val(row.data('id'));
                $('#editTitle').val(row.find('.book-title').text());
                $('#editAuthor').val(row.find('.book-author').text());
                $('#editGenre').val(row.find('.book-genre').text());
                $('#editAvailability').val(row.find('.book-availability_status').text().trim());
                editModal.show();	
            });
            
            // Update button click handler
            $('#updateBtn').click(function() {
                const formData = $('#editForm').serialize();
                
                $.ajax({
                    url: 'EditBookServlet',
                    type: 'POST',
                    data: formData,
                    success: function(response) {
                        if (response === 'success') {
                            editModal.hide();
                            location.reload(); // Refresh to see changes
                        } else {
                            alert('Error: ' + response);
                        }
                    },
                    error: function(xhr) {
                        alert('Error: ' + xhr.status + ' ' + xhr.statusText);
                    }
                });
            });
        });
    </script>
</body>
</html>