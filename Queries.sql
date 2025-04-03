CREATE DATABASE hotelDB;

-- Create RoomTypes Table
CREATE TABLE RoomTypes (
    room_type_id INT PRIMARY KEY IDENTITY(1,1),
    room_type NVARCHAR(50) NOT NULL,
    description NVARCHAR(MAX),
    max_guests INT NOT NULL
);

-- Create Rooms Table
CREATE TABLE Rooms (
    room_id INT PRIMARY KEY IDENTITY(1,1),
    room_name NVARCHAR(100) NOT NULL,
    room_type_id INT NOT NULL,
    room_number NVARCHAR(10) NOT NULL UNIQUE,
    price_per_night DECIMAL(10, 2) NOT NULL,
    is_booked BIT DEFAULT 0,
	room_description NVARCHAR(MAX);
    FOREIGN KEY (room_type_id) REFERENCES RoomTypes(room_type_id)
);
ALTER TABLE Rooms ADD room_description NVARCHAR(MAX);

-- Create amenities table
CREATE TABLE RoomAmenities (
    amenity_id INT PRIMARY KEY IDENTITY(1,1),
    room_type_id INT NOT NULL,
    amenity_name NVARCHAR(255) NOT NULL,
    FOREIGN KEY (room_type_id) REFERENCES RoomTypes(room_type_id)
);

-- Create RoomImages Table
CREATE TABLE RoomImages (
    image_id INT PRIMARY KEY IDENTITY(1,1),
    room_id INT NOT NULL,
    image_path NVARCHAR(255) NOT NULL,
    image_description NVARCHAR(255),
    is_thumbnail BIT DEFAULT 0,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Create Bookings Table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY IDENTITY(100000,1),
	booking_code NVARCHAR(50) NOT NULL,
    room_id INT NOT NULL,
    guest_name NVARCHAR(100) NOT NULL,
    guest_phone NVARCHAR(15) NOT NULL,
    guest_email NVARCHAR(100) NOT NULL,
    guest_address NVARCHAR(255) NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATETIME NOT NULL,
    number_of_guests INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    booking_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);	

CREATE TABLE cancelled_bookings (
    cancellation_id INT PRIMARY KEY IDENTITY(1,1),
    booking_id INT NOT NULL,
    room_id INT NOT NULL,
    guest_name NVARCHAR(100) NOT NULL,
    cancellation_reason NVARCHAR(MAX) NOT NULL,
    cancellation_date DATETIME DEFAULT GETDATE(),
	original_check_in DATE NULL,
    original_check_out DATE NULL,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);
ALTER TABLE cancelled_bookings
ADD original_check_in DATE NULL,
    original_check_out DATE NULL;

-- Create Payments Table (If Necessary e.g you want to implement a payment gateway)
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    booking_id INT NOT NULL,
    payment_amount DECIMAL(10, 2) NOT NULL,
    payment_date DATETIME DEFAULT GETDATE(),
    payment_method NVARCHAR(50) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);