package com.hotelreservation.hotelreservation;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;


@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    // Handle POST requests for booking operations
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Logging parameters for debugging purposes
        logParameters(request);


        // Validate and parse the room ID from the request parameter
        String roomIdParam = request.getParameter("roomId");
        if (roomIdParam == null || roomIdParam.isEmpty()) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Room ID is missing");
            return;
        }

        int roomId;
        try {
            roomId = Integer.parseInt(roomIdParam);
        } catch (NumberFormatException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid Room ID");
            return;
        }

        // Validate and parse total price parameter
        String totalPriceParam = request.getParameter("totalPrice");
        if (totalPriceParam == null || totalPriceParam.isEmpty()) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Total price is missing");
            return;
        }

        double totalPrice;
        try {
            totalPrice = Double.parseDouble(totalPriceParam);
        } catch (NumberFormatException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid total price");
            return;
        }

        // Retrieve other required parameters from the request
        String guestName = request.getParameter("full-name");
        String guestPhone = request.getParameter("phone-no");
        String guestEmail = request.getParameter("email");
        String numberOfGuestsParam = request.getParameter("no-of-guest");
        String guestAddress = request.getParameter("house-address");
        String checkInDateStr = request.getParameter("check-in");
        String checkOutDateStr = request.getParameter("check-out");

        // Validate that none of the required fields are missing or empty
        if (!validateRequiredFields(guestName, guestPhone, guestEmail, numberOfGuestsParam,
                guestAddress, checkInDateStr, checkOutDateStr)) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Missing or invalid form data");
            return;
        }

        // Parse and validate check-in and check-out dates
        LocalDate checkInDate;
        LocalDate checkOutDate;
        try {
            checkInDate = LocalDate.parse(checkInDateStr);
            checkOutDate = LocalDate.parse(checkOutDateStr);

            // Check that check-out date is not before check-in date
            if (checkOutDate.isBefore(checkInDate)) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Check-out date cannot be before check-in date");
                return;
            }

            // Ensure the check-in date is not in the past
            if (checkInDate.isBefore(LocalDate.now())) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Check-in date cannot be in the past");
                return;
            }
        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid date format");
            return;
        }

        // Validate the number of guests is within allowed limits (1 to 10)
        int numberOfGuests;
        try {
            numberOfGuests = Integer.parseInt(numberOfGuestsParam);
            if (numberOfGuests < 1 || numberOfGuests > 10) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Number of guests must be between 1 and 10");
                return;
            }
        } catch (NumberFormatException e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid number of guests");
            return;
        }

        // Retrieve room details from the database using RoomDAO class
        RoomDAO roomDAO = new RoomDAO();
        Room room;
        try {
            room = roomDAO.getRoomById(roomId);
            if (room == null) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Room not found");
                return;
            }
        } catch (SQLException e) {
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
            return;
        }

        // Check for date conflicts with existing bookings
        try {
            List<String> conflicts = getConflictingDates(roomId, checkInDate, checkOutDate);
            if (!conflicts.isEmpty()) {
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                // If using Gson, make sure to import com.google.gson.Gson at the top.
                out.print("{\"conflicts\": " + new Gson().toJson(conflicts) + "}");
                out.flush();
                return;
            }
        } catch (SQLException e) {
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error while checking conflicts");
            return;
        }
// ============================ END CONFLICT CHECK **=======================================================***


        // Calculate the expected total price based on the room's price per night and the number of days booked
        long daysBetween = ChronoUnit.DAYS.between(checkInDate, checkOutDate);
        double serverTotalPrice = room.getPricePerNight() * daysBetween;

        // Validate that the calculated price matches the total price sent by the client (with a small margin for floating-point differences)
        if (Math.abs(serverTotalPrice - totalPrice) > 0.01) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST,
                    "Price mismatch. Expected: " + serverTotalPrice + ", Received: " + totalPrice);
            return;
        }

        // Perform database operations within a transaction to ensure atomicity
        try (Connection conn = DatabaseConnection.getConnection()) {
            conn.setAutoCommit(false); // Start transaction

            // Insert a new booking record into the database
            int bookingId = insertBooking(conn, roomId, guestName, guestPhone, guestEmail,
                    numberOfGuests, guestAddress, checkInDate, checkOutDate, totalPrice);

            if (bookingId <= 0) {
                conn.rollback();
                sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create booking");
                return;
            }

            // Generate a unique booking code based on the guest name and booking ID
            String bookingCode = generateBookingCode(guestName, bookingId);
            if (!updateBookingCode(conn, bookingId, bookingCode)) {
                conn.rollback();
                sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update booking code");
                return;
            }

            // Update the room's status to indicate it has been booked
            if (!updateRoomStatus(conn, roomId)) {
                conn.rollback();
                sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update room status");
                return;
            }

            conn.commit(); // Commit transaction if all operations are successful

            // Mark booking as completed in the user's session
            HttpSession session = request.getSession();
            session.setAttribute("bookingCompleted", true);

            // Return a success response with the booking code for redirection purposes
            sendSuccessResponse(response, bookingCode);

        } catch (SQLException e) {
            sendError(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }

    // Helper method: Log all request parameters for debugging
    private void logParameters(HttpServletRequest request) {
        Enumeration<String> params = request.getParameterNames();
        while (params.hasMoreElements()) {
            String param = params.nextElement();
            System.out.println(param + ": " + request.getParameter(param));
        }
    }

    // Helper method: Check for any conflicting booking dates for the room in the database
    private List<String> getConflictingDates(int roomId, LocalDate checkIn, LocalDate checkOut) throws SQLException {
        List<String> conflicts = new ArrayList<>();
        String sql = "SELECT check_in_date, check_out_date FROM Bookings WHERE room_id = ? AND (? <= check_out_date AND ? >= check_in_date)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomId);
            pstmt.setDate(2, Date.valueOf(checkIn));
            pstmt.setDate(3, Date.valueOf(checkOut));

            ResultSet rs = pstmt.executeQuery();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

            while (rs.next()) {
                LocalDate existingCheckIn = rs.getDate("check_in_date").toLocalDate();
                LocalDate existingCheckOut = rs.getDate("check_out_date").toLocalDate();
                conflicts.add(existingCheckIn.format(formatter) + " - " + existingCheckOut.format(formatter));
            }
        }
        return conflicts;
    }

    // Helper method: Validate that none of the provided fields are null or empty
    private boolean validateRequiredFields(String... fields) {
        for (String field : fields) {
            if (field == null || field.trim().isEmpty()) return false;
        }
        return true;
    }

    // Helper method: Insert a new booking into the database and return the generated booking ID
    private int insertBooking(Connection conn, int roomId, String guestName, String guestPhone,
                              String guestEmail, int numberOfGuests, String guestAddress,
                              LocalDate checkInDate, LocalDate checkOutDate, double totalPrice) throws SQLException {
        String query = "INSERT INTO Bookings (booking_code, room_id, guest_name, guest_phone, "
                + "guest_email, number_of_guests, guest_address, check_in_date, check_out_date, total_price) "
                + "VALUES ('TEMP', ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, roomId);
            stmt.setString(2, guestName);
            stmt.setString(3, guestPhone);
            stmt.setString(4, guestEmail);
            stmt.setInt(5, numberOfGuests);
            stmt.setString(6, guestAddress);
            stmt.setDate(7, Date.valueOf(checkInDate));
            stmt.setDate(8, Date.valueOf(checkOutDate));
            stmt.setDouble(9, totalPrice);

            stmt.executeUpdate();

            // Retrieve the auto-generated booking ID
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                return rs.next() ? rs.getInt(1) : -1;
            }
        }
    }

    // Helper method: Update the booking record with the generated booking code
    private boolean updateBookingCode(Connection conn, int bookingId, String bookingCode) throws SQLException {
        String query = "UPDATE Bookings SET booking_code = ? WHERE booking_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, bookingCode);
            stmt.setInt(2, bookingId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Helper method: Update the room's status to mark it as booked in the database
    private boolean updateRoomStatus(Connection conn, int roomId) throws SQLException {
        String query = "UPDATE Rooms SET is_booked = 1 WHERE room_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, roomId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Helper method: Generate a unique booking code using parts of the guest's name and the booking ID
    private String generateBookingCode(String guestName, int bookingId) {
        String[] names = guestName.split(" ");
        String firstName = names[0];
        String lastName = names.length > 1 ? names[names.length - 1] : ""; // Get last name part

        // Get first two letters of the first name (or the full name if shorter)
        String firstTwo = firstName.length() >= 2 ?
                firstName.substring(0, 2).toUpperCase() :
                firstName.toUpperCase();

        // Get first two letters of the last name (or the full name if shorter)
        String lastTwo = lastName.length() >= 2 ?
                lastName.substring(0, 2).toUpperCase() :
                lastName.toUpperCase();

        return firstTwo + lastTwo + bookingId;
    }

    // Helper method: Send a JSON response indicating a successful booking with a redirect URL containing the booking code
    private void sendSuccessResponse(HttpServletResponse response, String bookingCode) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{ \"redirectUrl\": \"SuccessServlet?bookingCode=" + bookingCode + "\" }");
        out.flush();

    }

    // Helper method: Send an error response with the specified HTTP status and error message
    private void sendError(HttpServletResponse response, int status, String message) throws IOException {
        response.sendError(status, message);
        System.err.println("Error: " + message);
    }
}