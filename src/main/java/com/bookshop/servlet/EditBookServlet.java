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

@WebServlet("/EditBookServlet")
public class EditBookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        String id = request.getParameter("id"	);
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String genre = request.getParameter("genre");
        String availability_status = request.getParameter("availability_status");

        if (id == null || title == null || author == null || genre == null || availability_status == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("Missing parameters");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "UPDATE books SET title=?, author=?, genre=?, availability_status=? WHERE id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, author);
            stmt.setString(3, genre);
            stmt.setString(4, availability_status);
            stmt.setInt(5, Integer.parseInt(id));

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                out.print("success");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("Book not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("Database error: " + e.getMessage());
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
            out.close();
        }
    }
}