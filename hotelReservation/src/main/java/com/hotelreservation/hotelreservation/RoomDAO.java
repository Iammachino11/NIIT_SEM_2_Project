package com.hotelreservation.hotelreservation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// Database Access Object Class
public class RoomDAO {
    // Retrieve a Room object based on its unique roomId
    public Room getRoomById(int roomId) throws SQLException {
        // SQL query to join Rooms with RoomTypes to get room details along with its type.
        String query = "SELECT r.*, rt.room_type FROM Rooms r " +
                "JOIN RoomTypes rt ON r.room_type_id = rt.room_type_id " +
                "WHERE r.room_id = ?";

        // Use try-with-resources to ensure that Connection and PreparedStatement are closed automatically
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, roomId); // Set the roomId parameter in the query
            ResultSet rs = stmt.executeQuery(); // Execute the query
            if (rs.next()) { // If a record is found:
                Room room = new Room();
                // Populate the Room object with data from the ResultSet
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomName(rs.getString("room_name"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setPricePerNight(rs.getDouble("price_per_night"));
                room.setIsBooked(rs.getBoolean("is_booked"));
                room.setRoomTypeId(rs.getInt("room_type_id"));
                room.setRoomType(rs.getString("room_type"));
                room.setRoomDescription(rs.getString("room_description"));
                return room; // Return the populated Room object.
            }
            return null; // Return null if no room is found.
        }
    }

    // Retrieve a list of image file paths for a given roomId.
    public List<String> getRoomImages(int roomId) throws SQLException {
        List<String> images = new ArrayList<>();
        // SQL query to select distinct image paths for the specified room.
        String query = "SELECT DISTINCT image_path FROM RoomImages WHERE room_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, roomId); // Set the roomId parameter
            ResultSet rs = stmt.executeQuery();
            // Iterate through the ResultSet and add each image path to the list
            while (rs.next()) {
                images.add(rs.getString("image_path")); // e.g., returns "image-1.jpg"
            }
        }
        return images;
    }

    // Retrieve a list of amenity names based on a roomTypeId
    public List<String> getRoomAmenities(int roomTypeId) throws SQLException {
        List<String> amenities = new ArrayList<>();
        // SQL query to fetch amenity names for a given room type
        String query = "SELECT amenity_name FROM RoomAmenities WHERE room_type_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, roomTypeId); // Set the roomTypeId parameter
            ResultSet rs = stmt.executeQuery();
            // Loop through the ResultSet to add each amenity name to the list
            while (rs.next()) {
                amenities.add(rs.getString("amenity_name"));
            }
        }
        return amenities;
    }

    // Update the availability status of rooms based on current booking dates
    public void updateRoomAvailabilityStatus() {
        // Query to mark rooms as available if their latest check-out date is in the past
        String checkBookingQuery = "UPDATE Rooms SET is_booked = 0 WHERE room_id IN (" +
                "SELECT room_id FROM Bookings " +
                "GROUP BY room_id HAVING MAX(check_out_date) < GETDATE())";

        // Query to mark rooms as booked if the current date is within an active booking period
        String setBookedQuery = "UPDATE Rooms SET is_booked = 1 WHERE room_id IN (" +
                "SELECT DISTINCT room_id FROM Bookings " +
                "WHERE GETDATE() BETWEEN check_in_date AND check_out_date)";

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Prepare both update queries
            try (PreparedStatement stmt1 = conn.prepareStatement(checkBookingQuery);
                 PreparedStatement stmt2 = conn.prepareStatement(setBookedQuery)) {

                stmt1.executeUpdate();  // Execute update to mark rooms as available.
                stmt2.executeUpdate();  // Execute update to mark rooms as booked.
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Retrieve a list of all rooms with basic details.
    public List<Room> getAllRooms() {
        // Ensure room availability statuses are up-to-date before fetching room data.
        updateRoomAvailabilityStatus();  // First update status
        List<Room> rooms = new ArrayList<>();
        // SQL query to fetch room details along with their types by joining Rooms and RoomTypes.
        String query = "SELECT r.room_id, r.room_name, rt.room_type, r.room_number, " +
                "r.price_per_night, r.is_booked " +  // Added is_booked
                "FROM Rooms r " +
                "JOIN RoomTypes rt ON r.room_type_id = rt.room_type_id";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            // Loop through the results and create Room objects.
            while (rs.next()) {
                Room room = new Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomName(rs.getString("room_name"));
                room.setRoomType(rs.getString("room_type"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setPricePerNight(rs.getDouble("price_per_night"));
                room.setIsBooked(rs.getBoolean("is_booked"));  // Set booking status
                rooms.add(room);  // Add each room to the list.
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }


    // Method to retrieve a list of rooms filtered by the specified room type
    public List<Room> getRoomsByType(String roomType) {
        updateRoomAvailabilityStatus();  // First update status
        List<Room> rooms = new ArrayList<>();
        // SQL query to fetch room details for rooms matching the given type (case-insensitive)
        String query = "SELECT r.room_id, r.room_name, rt.room_type, r.room_number, " +
                "r.price_per_night, r.is_booked " +
                "FROM Rooms r " +
                "JOIN RoomTypes rt ON r.room_type_id = rt.room_type_id " +
                "WHERE LOWER(rt.room_type) = LOWER(?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, roomType); // Set the room type parameter for filtering
            ResultSet rs = stmt.executeQuery();

            // Iterate over the results to build the list of Room objects
            while (rs.next()) {
                Room room = new Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomName(rs.getString("room_name"));
                room.setRoomType(rs.getString("room_type"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setPricePerNight(rs.getDouble("price_per_night"));
                room.setIsBooked(rs.getBoolean("is_booked"));
                rooms.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;

    }

}