package com.bookshop.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/bookshop";
    private static final String USER = "vish";  
    private static final String PASSWORD = "vish123";  

    public static Connection getConnection() throws SQLException {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure MySQL Driver is loaded
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Database Connected Successfully!");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL JDBC Driver Not Found!");
            throw new SQLException("Driver Not Found!", e);
        } catch (SQLException e) {
            System.out.println("Database Connection Failed: " + e.getMessage());
            throw e;  // Re-throw exception for debugging
        }
        return conn;
    }
}
