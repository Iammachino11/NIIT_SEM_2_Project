package com.hotelreservation.hotelreservation;

// This class represents a hotel room with its details and booking status.
public class Room {
    // Private fields to store room properties
    private int roomId;               // Unique identifier for the room
    private String roomName;          // Descriptive name for the room
    private String roomType;          // Type/category of the room (e.g., Deluxe, Suite)
    private String roomNumber;        // The room's number (as used in the hotel)
    private double pricePerNight;     // Cost to book the room per night
    private boolean isBooked;         // Flag indicating if the room is currently booked
    private int roomTypeId;           // Identifier for the room type, useful for categorization
    private String roomDescription;   // Detailed description of the room

    // Getters and Setters
    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public double getPricePerNight() {
        return pricePerNight;
    }

    public void setPricePerNight(double pricePerNight) {
        this.pricePerNight = pricePerNight;
    }

    public boolean getIsBooked() {
        return isBooked;
    }

    public void setIsBooked(boolean isBooked) {
        this.isBooked = isBooked;
    }

    public int getRoomTypeId() {
        return roomTypeId;
    }

    public void setRoomTypeId(int roomTypeId) {
        this.roomTypeId = roomTypeId;
    }

    public String getRoomDescription() {
        return roomDescription;
    }

    public void setRoomDescription(String roomDescription) {
        this.roomDescription = roomDescription;
    }
}