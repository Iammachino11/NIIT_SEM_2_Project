package com.hotelreservation.hotelreservation;

import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.time.LocalDate;
import java.util.Objects;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {
    // Handle POST requests to either validate or cancel a booking
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type as JSON and obtain the PrintWriter for sending output
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action"); // Determine the requested action

        // Use a database connection within a transaction
        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false); // Start Transaction

            // Check which action is requested
            if ("validate".equals(action)) {
                // Validate booking details for potential cancellation
                handleValidation(conn, request, out);
            } else if ("cancel".equals(action)) {
                // Process the actual cancellation of the booking
                handleCancellation(conn, request, out);
            }

            conn.commit(); // Commit the transaction if all operations succeed
        } catch (SQLException | NullPointerException e) {
            // On error, send a JSON error response and log the exception
            sendErrorResponse(out, "Database error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Method to handle validation of a booking before cancellation
    private void handleValidation(Connection conn, HttpServletRequest request, PrintWriter out)
            throws SQLException {
        String bookingCode = request.getParameter("bookingCode");
        Booking booking = getBookingByCode(conn, bookingCode); // Retrieve booking using booking code

        JsonObject responseJson = new JsonObject();

        if (booking == null) {
            // If no booking found, mark validation as false
            responseJson.addProperty("valid", false);
            out.print(responseJson.toString());
            return;
        }

        // Check if booking dates are null (i.e., invalid booking)
        if (booking.check_in_date == null || booking.check_out_date == null) {
            responseJson.addProperty("valid", true);
            responseJson.addProperty("cancelAllowed", false);
            responseJson.addProperty("message", "Invalid booking dates");
            out.print(responseJson.toString());
            return;
        }

        // Populate response JSON with booking details
        responseJson.addProperty("valid", true);
        responseJson.addProperty("bookingCode", booking.booking_code);
        responseJson.addProperty("bookingId", booking.booking_id);
        responseJson.addProperty("roomId", booking.room_id);
        responseJson.addProperty("guestName", booking.guest_name);
        responseJson.addProperty("roomNumber", booking.room_number);
        responseJson.addProperty("roomType", booking.room_type);
        responseJson.addProperty("totalPrice", booking.total_price);
        responseJson.addProperty("bookingDate", booking.booking_date.toString());
        responseJson.addProperty("checkInDate", booking.check_in_date.toString());
        responseJson.addProperty("checkOutDate", booking.check_out_date.toString());

        // Determine if cancellation is allowed based on the current date and booking dates
        LocalDate today = LocalDate.now();
        LocalDate checkInDate = booking.check_in_date.toLocalDate();
        LocalDate checkOutDate = booking.check_out_date.toLocalDate();

        if (today.isAfter(checkInDate) || today.isEqual(checkInDate)) {
            // Cancellation is not allowed if check-in date has passed or is today
            responseJson.addProperty("cancelAllowed", false);
            responseJson.addProperty("message", "Cannot cancel booking - check-in date has passed");
        } else if (today.isAfter(checkOutDate)) {
            // Cancellation is not allowed if booking period has elapsed
            responseJson.addProperty("cancelAllowed", false);
            responseJson.addProperty("message", "Booking period has elapsed");
        } else {
            // Otherwise, cancellation is allowed
            responseJson.addProperty("cancelAllowed", true);
        }
        // Send the JSON response back to the client
        out.print(responseJson.toString());
    }

    // Method to handle the cancellation process of a booking
    private void handleCancellation(Connection conn, HttpServletRequest request, PrintWriter out)
            throws SQLException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String reason = request.getParameter("reason");

        // Retrieve booking dates for the given bookingId
        try (PreparedStatement stmt = conn.prepareStatement(
                "SELECT check_in_date, check_out_date FROM Bookings WHERE booking_id = ?")) {

            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();

            if (!rs.next()) {
                // If no booking is found, send an error response
                sendErrorResponse(out, "Booking not found");
                return;
            }

            Date checkInDate = rs.getDate("check_in_date");
            Date checkOutDate = rs.getDate("check_out_date");

            // Validate that both check-in and check-out dates exist
            if (checkInDate == null || checkOutDate == null) {
                sendErrorResponse(out, "Invalid booking dates");
                return;
            }

            // Convert SQL dates to LocalDate for comparison
            LocalDate today = LocalDate.now();
            LocalDate checkIn = checkInDate.toLocalDate();
            LocalDate checkOut = checkOutDate.toLocalDate();

            // Ensure cancellation is not allowed if check-in has passed or booking period has elapsed
            if (today.isAfter(checkIn) || today.isEqual(checkIn)) {
                sendErrorResponse(out, "Cannot cancel booking - check-in date has passed");
                return;
            }
            if (today.isAfter(checkOut)) {
                sendErrorResponse(out, "Booking period has elapsed");
                return;
            }

            // Process/Perform cancellation:
            //Move booking data to cancelled_bookings table
            moveToCancelledBookings(conn, bookingId, roomId, reason);
            // 2. Update the room's status to available
            updateRoomStatus(conn, roomId);
            // 3. Delete the original booking record from Bookings table
            deleteBooking(conn, bookingId);

            // Send a success response indicating cancellation was successful
            out.print("{ \"success\": true }");
        }
    }

    // Retrieve a Booking object based on its booking code
    private Booking getBookingByCode(Connection conn, String bookingCode) throws SQLException {
        // SQL query to join booking, room, and room type details
        String query = "SELECT b.*, r.room_number, rt.room_type, "
                + "b.check_in_date, b.check_out_date "  // Explicitly select dates
                + "FROM Bookings b "
                + "JOIN Rooms r ON b.room_id = r.room_id "
                + "JOIN RoomTypes rt ON r.room_type_id = rt.room_type_id "
                + "WHERE b.booking_code = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, bookingCode); // Set the booking code parameter
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Booking booking = new Booking();
                // Populate booking dates, checking for null values
                booking.check_in_date = rs.getDate("check_in_date");
                booking.check_out_date = rs.getDate("check_out_date");

                // If dates are invalid, return null to indicate an issue
                if (booking.check_in_date == null || booking.check_out_date == null) {
                    return null;
                }

                // Populate remaining fields from the ResultSet
                booking.booking_id = rs.getInt("booking_id");
                booking.booking_code = rs.getString("booking_code");
                booking.guest_name = rs.getString("guest_name");
                booking.room_number = rs.getString("room_number");
                booking.room_type = rs.getString("room_type");
                booking.total_price = rs.getDouble("total_price");
                booking.booking_date = rs.getTimestamp("booking_date");
                booking.room_id = rs.getInt("room_id");

                return booking;
            }
            return null; // Return null if no booking is found
        }
    }

    // Move a booking record to the cancelled_bookings table for record-keeping
    private void moveToCancelledBookings(Connection conn, int bookingId, int roomId, String reason)
            throws SQLException {
        String query = "INSERT INTO cancelled_bookings (booking_id, room_id, guest_name, cancellation_reason, original_check_in, original_check_out) " +
                "SELECT booking_id, room_id, guest_name, ?, check_in_date, check_out_date " +
                "FROM Bookings WHERE booking_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, reason);  // Set cancellation reason
            stmt.setInt(2, bookingId);    // Set booking id
            stmt.executeUpdate();         // Execute the insertion
        }
    }

    // Update the room's availability status to available (is_booked = 0)
    private void updateRoomStatus(Connection conn, int roomId) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(
                "UPDATE Rooms SET is_booked = 0 WHERE room_id = ?")) {
            stmt.setInt(1, roomId); // Set the room id parameter
            stmt.executeUpdate();   // Execute the update
        }
    }

    // Delete the booking record from the Bookings table after cancellation
    private void deleteBooking(Connection conn, int bookingId) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(
                "DELETE FROM Bookings WHERE booking_id = ?")) {
            stmt.setInt(1, bookingId); // Set the booking id parameter
            stmt.executeUpdate();  // Execute the deletion
        }
    }

    // Utility method to send an error JSON response with a message
    private void sendErrorResponse(PrintWriter out, String message) {
        JsonObject error = new JsonObject();
        error.addProperty("success", false);
        error.addProperty("message", message);
        out.print(error.toString());
    }

    // Inner class representing a Booking record (used for internal data mapping)
    private static class Booking {
        int booking_id;
        String booking_code;
        String guest_name;
        String room_number;
        String room_type;
        double total_price;
        Date check_in_date;
        Date check_out_date;
        Timestamp booking_date;
        int room_id;
    }
}