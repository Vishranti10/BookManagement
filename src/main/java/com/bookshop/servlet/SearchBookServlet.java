package com.bookshop.servlet;

import com.bookshop.database.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SearchBookServlet")
public class SearchBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String title = request.getParameter("title");
        String author = request.getParameter("author");

        List<Book> books = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new Exception("Database connection is NULL!");
            }

            // Build dynamic SQL query with partial matching
            StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM books WHERE 1=1");
            if (title != null && !title.trim().isEmpty()) {
                sqlBuilder.append(" AND title LIKE ?");
            }
            if (author != null && !author.trim().isEmpty()) {
                sqlBuilder.append(" AND author LIKE ?");
            }

            pstmt = conn.prepareStatement(sqlBuilder.toString());

            // Set parameters with wildcards for partial matching
            int paramIndex = 1;
            if (title != null && !title.trim().isEmpty()) {
                pstmt.setString(paramIndex++, "%" + title.toLowerCase() + "%");
            }
            if (author != null && !author.trim().isEmpty()) {
                pstmt.setString(paramIndex++, "%" + author.toLowerCase() + "%");
            }

            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Book book = new Book(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("author"),
                    rs.getString("genre"),
                    rs.getString("availability_status")
                );
                books.add(book);
            }

            request.setAttribute("searchTitle", title);
            request.setAttribute("searchAuthor", author);
            request.setAttribute("books", books);

            request.getRequestDispatcher("searchBook.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error searching books: " + e.getMessage());
            request.getRequestDispatcher("searchBook.jsp").forward(request, response);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }

    public static class Book {
        private int id;
        private String title;
        private String author;
        private String genre;
        private String availabilityStatus;

        public Book(int id, String title, String author, String genre, String availabilityStatus) {
            this.id = id;
            this.title = title;
            this.author = author;
            this.genre = genre;
            this.availabilityStatus = availabilityStatus;
        }

        // Getters
        public int getId() { return id; }
        public String getTitle() { return title; }
        public String getAuthor() { return author; }
        public String getGenre() { return genre; }
        public String getAvailabilityStatus() { return availabilityStatus; }
    }
}