package com.hotelreservation.hotelreservation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // Database URL, Username, and Password
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=hotelDB;encrypt=false";
    private static final String USER = "MACHINO11";
    private static final String PASSWORD = "Machino2005";

    // Static block to register the driver
    static {
        try {
            DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());
        } catch (SQLException e) {
            System.err.println("Failed to register SQL Server JDBC driver");
            e.printStackTrace();
        }
    }

    // Method to get a database connection
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Test the connection (optional)
    public static void main(String[] args) {
        Connection connection = null;

        try {
            // Attempt to establish a connection
            connection = getConnection();

            // If connection is successful
            System.out.println("Connection successful!");
        } catch (SQLException e) {
            // If connection fails
            System.out.println("Connection unsuccessful");
            e.printStackTrace(); // Print the stack trace to help with debugging
        } finally {
            if (connection != null) {
                try {
                    // Close the connection when done
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}