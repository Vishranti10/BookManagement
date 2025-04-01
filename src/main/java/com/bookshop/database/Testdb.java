package com.bookshop.database;
import java.sql.Connection;
import java.sql.SQLException;

public class Testdb {

	public static void main(String[] args) throws SQLException {
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            System.out.println("Connection Successful!");
        } else {
            System.out.println("Connection Failed!");
        }
    }
}
