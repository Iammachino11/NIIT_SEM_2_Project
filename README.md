# NIIT_SEM_2_Project
Simple Hotel Booking Website in JAVA using JSP and Servlets
A web-based platform for booking hotel rooms without logins. Users can browse rooms by type, view images/amenities, book instantly, and cancel via unique codes.  

![Screenshot of project UI](/Project-images)  

## Features  
- **No Login Required**: Book rooms instantly without creating an account.  
- **Room-Specific Booking**: View individual rooms with images and amenities.  
- **Cancellation Codes**: Cancel reservations using a unique booking code.  
- **Real-Time Conflict Detection**: Prevent double bookings.  
- **Automated Room Updates**: Daily background jobs refresh availability.  

## Technologies  
- **Backend**: Java, Servlets, JSP  
- **Database**: Microsoft SQLServer 
- **Frontend**: HTML/CSS, JavaScript/jQuery  
- **Server**: Apache Tomcat 10

## Setup  
1. **Clone the repository**:  
   ```bash  
   https://github.com/Iammachino11/NIIT_SEM_2_Project.git  

2. **Database Setup**:  
   Make sure you have MS SQL Server
   Open the Queries.sql file and run it

3. **IDEA Setup**:  
   Make sure you have IntelliJ IDEA 
   Open the Project
   Deploy the WAR file to Apache Tomcat if necessary
   Update database credentials in DatabaseConnection.java.

4. **Run**:  
   Start Tomcat and visit http://localhost:8080/hotelReservation_war_exploded/
    

src/  
├── main/java/com/hotelreservation/hotelreservation/  
│   ├── servlets/ (e.g., BookingServlet.java, RoomServlet.java, SuccessServlet.java, CancelBookingServlet.java, RoomDetailsServlet, BackgroundRefreshServlet.java)  
│   ├── dao/ (e.g., RoomDAO.java)  
│   └── models/ (e.g., Room.java)  
WebContent/  
├── index.jsp  
├── availability.jsp  
├── css/index.css, availabilty.css, google-fonts.css
└── js/ index.js, embed-svg.js