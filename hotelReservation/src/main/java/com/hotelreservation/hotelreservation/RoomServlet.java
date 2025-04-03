package com.hotelreservation.hotelreservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import com.google.gson.Gson;


@WebServlet("/RoomServlet")
public class RoomServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the selected room type from the request
        String roomType = request.getParameter("roomType");

        // Fetch rooms based on the selected filter
        RoomDAO roomDAO = new RoomDAO();
        List<Room> rooms;
        if (roomType == null || roomType.equals("All")) {
            rooms = roomDAO.getAllRooms();
        } else {
            rooms = roomDAO.getRoomsByType(roomType);
        }

        // Generate HTML for the filtered rooms
        StringBuilder html = new StringBuilder();
        for (Room room : rooms) {
            boolean isBooked = room.getIsBooked();
            html.append("<div class=\"availableRoom\">")
                    .append("<div class=\"availableRoomImgContainer\" data-room-id=\"")
                    .append(room.getRoomId())
                    .append("\">")
                    .append("<img src=\"")
                    .append(RoomUtil.getRoomThumbnail(room.getRoomNumber()))
                    .append("\" onerror=\"this.src='Images/Svgs/no-image.svg'\" alt=\"")
                    .append(room.getRoomName())
                    .append("\">")
                    .append("</div>")
                    .append("<h2 class=\"roomName\">").append(room.getRoomName()).append("</h2>")
                    .append("<div class=\"roomTypeAndNumber\">")
                    .append("<p class=\"roomType\">").append(room.getRoomType()).append("</p>")
                    .append("<p class=\"roomNo\">").append(room.getRoomNumber()).append("</p>")
                    .append("</div>")
                    .append("<h1 class=\"priceContainer\">₦ <span class=\"price\">").append(String.format("%,.2f", room.getPricePerNight())).append("</span></h1>")
                    .append("<button class=\"BookRoomBtn")
                    .append(isBooked ? " booked" : "") // Add 'booked' class if booked
                    .append("\" data-room-id=\"")
                    .append(room.getRoomId()) // Correct data-room-id
                    .append("\" data-room-name=\"")
                    .append(room.getRoomName())
                    .append("\" data-room-type=\"")
                    .append(room.getRoomType())
                    .append("\" data-room-number=\"")
                    .append(room.getRoomNumber())
                    .append("\" data-room-price=\"")
                    .append(room.getPricePerNight())
                    .append("\"")
                    .append(isBooked ? " disabled" : "") // Add 'disabled' attribute if booked
                    .append(">")
                    .append("<span>").append(isBooked ? "BOOKED" : "Book Room").append("</span>")
                    .append("</button>")
                    .append("</div>");
        }


        // Send the HTML response
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.print(html.toString());
        out.flush();
    }
}

