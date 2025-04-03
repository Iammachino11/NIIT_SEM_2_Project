package com.hotelreservation.hotelreservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


@WebServlet("/SuccessServlet")
public class SuccessServlet extends HttpServlet {
    // Handle GET requests for successful bookings
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Disable caching to ensure fresh content is always served
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");

        // Retrieve the bookingCode parameter from the request
        String bookingCode = request.getParameter("bookingCode");
        if (bookingCode == null || bookingCode.isEmpty()) {
            // If bookingCode is missing, send a 400 Bad Request error
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Booking code is missing");
            return;
        }

        // Establish a database connection
        try (Connection conn = DatabaseConnection.getConnection()) {
            // Prepare an SQL query to retrieve booking details along with room info
            String query = "SELECT b.*, r.room_number, rt.room_type " +
                    "FROM Bookings b " +
                    "JOIN Rooms r ON b.room_id = r.room_id " +
                    "JOIN RoomTypes rt ON r.room_type_id = rt.room_type_id " +
                    "WHERE b.booking_code = ?";

            // Use a PreparedStatement to avoid SQL injection
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, bookingCode); // Set the booking code parameter
                ResultSet rs = stmt.executeQuery();

                // If a booking record is found
                if (rs.next()) {
                    // Set request attributes with the booking details
                    request.setAttribute("bookingId", rs.getInt("booking_id"));
                    request.setAttribute("bookingCode", rs.getString("booking_code"));
                    request.setAttribute("guestName", rs.getString("guest_name"));
                    request.setAttribute("roomNumber", rs.getString("room_number"));
                    request.setAttribute("roomType", rs.getString("room_type"));
                    request.setAttribute("checkInDate", rs.getDate("check_in_date"));
                    request.setAttribute("checkOutDate", rs.getDate("check_out_date"));
                    // Format the price to two decimal places and set as attribute
                    request.setAttribute("price", String.format("%,.2f", rs.getDouble("total_price")));

                    // Forward the request to success.jsp to display the success page
                    request.getRequestDispatcher("success.jsp").forward(request, response);
                } else {
                    // If no booking is found, send a 404 Not Found error
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Booking not found");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Send a 500 Internal Server Error response if a database error occurs
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}