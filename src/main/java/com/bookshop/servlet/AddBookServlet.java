package com.bookshop.servlet;

import com.bookshop.database.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddBookServlet")  // Matches the form's action
public class AddBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	  response.setContentType("text/html");
          PrintWriter out = response.getWriter();
    	
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String genre = request.getParameter("genre");
        String availability_status = request.getParameter("availability_status");

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new Exception("Database connection is NULL!");
            }

            String sql = "INSERT INTO books (title, author, genre, availability_status) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, author);
            pstmt.setString(3, genre);
            pstmt.setString(4, availability_status);

            int rowsInserted = pstmt.executeUpdate();
            
            if (rowsInserted > 0) {
                out.println("<script>alert('Book added successfully!'); window.location.href='addBook.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to add book. Please try again!'); window.location.href='addBook.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error: " + e.getMessage() + "'); window.location.href='addBook.html';</script>");
        }
          finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
