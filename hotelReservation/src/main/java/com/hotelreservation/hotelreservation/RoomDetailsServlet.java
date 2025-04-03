package com.hotelreservation.hotelreservation;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.List;

@WebServlet("/RoomDetailsServlet")
public class RoomDetailsServlet extends HttpServlet {
    // Handle GET requests to fetch room details and related data
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the roomId parameter from the request
        String roomIdParam = request.getParameter("roomId");
        if (roomIdParam == null || roomIdParam.isEmpty()) {
            // Send a 400 Bad Request if roomId is missing or empty
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing room ID");
            return;
        }

        // Parse roomId from String to integer
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        // Create a RoomDAO instance to interact with the database
        RoomDAO roomDAO = new RoomDAO();

        try {
            // Get room details from the database using the provided roomId
            Room room = roomDAO.getRoomById(roomId);
            // Retrieve a list of image paths for the room
            List<String> images = roomDAO.getRoomImages(roomId);
            // Retrieve a list of amenities based on the room type ID
            List<String> amenities = roomDAO.getRoomAmenities(room.getRoomTypeId());

            // Create a JSON response object to store room details
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("roomName", room.getRoomName());
            jsonResponse.addProperty("roomId", room.getRoomId());
            jsonResponse.addProperty("description", room.getRoomDescription());
            jsonResponse.addProperty("roomType", room.getRoomType());
            jsonResponse.addProperty("roomNumber", room.getRoomNumber());

            // Add images as a JSON array
            JsonArray imagesArray = new JsonArray();
            for (String image : images) imagesArray.add(image);
            jsonResponse.add("images", imagesArray);

            // Add amenities as a JSON array
            JsonArray amenitiesArray = new JsonArray();
            for (String amenity : amenities) amenitiesArray.add(amenity);
            jsonResponse.add("amenities", amenitiesArray);

            // Set the response content type to JSON and write the JSON response
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());

        } catch (SQLException e) {
            // If an SQLException occurs, send an error response with details
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid room ID format");
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            e.printStackTrace();
        }
    }
}