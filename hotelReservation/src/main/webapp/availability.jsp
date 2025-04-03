<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hotelreservation.hotelreservation.RoomDAO" %>
<%@ page import="com.hotelreservation.hotelreservation.Room" %>
<%@ page import="com.hotelreservation.hotelreservation.RoomUtil" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setHeader("Expires", "0"); // Proxies

// Check for booking completion
    HttpSession sessionn = request.getSession(false);
    if (sessionn != null && sessionn.getAttribute("bookingCompleted") != null) {
        sessionn.removeAttribute("bookingCompleted");
        response.sendRedirect("index.jsp");
        return;
    }
%>


<%@ page import="java.util.List" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Availability</title>
    <link rel="stylesheet" type="text/css" href="CSS/google-fonts.css">
    <link rel="stylesheet" href="CSS/availability.css">
</head>
<body>
    <section>
<%--        Room Type name will be set based on what button is click in the accomodation page--%>
    <div class="headSection">
        <!-- Heading -->
        <h1 class="heading">Available <span class="roomTypeHeader"> Standard </span> Rooms</h1>
        <!-- Filter button to filter by room type -->
        <button class="filterBtn"><span class="filterName">Filter</span><span class="filterArrow">▼</span></button>
        <ul class="filterBy">
            <li data-room-type="All">All</li>
            <li data-room-type="Standard Suite">Standard Suite</li>
            <li data-room-type="Executive Suite">Executive Suite</li>
            <li data-room-type="Deluxe Suite">Deluxe Suite</li>
            <li data-room-type="Family Suite">Family Suite</li>
        </ul>
    </div>
    <!-- availableRoomsContainer this container will house all the individual hotel rooms -->
    <div class="availableRoomsContainer" id="availableRoomsContainer">
        <!-- Individual room -->
        <%
            RoomDAO roomDAO = new RoomDAO();
            List<Room> rooms = roomDAO.getAllRooms();
            for (Room room : rooms) {
        %>
        <div class="availableRoom" data-room-type="<%= room.getRoomType() %>">
            <div class="availableRoomImgContainer" data-room-id="<%= room.getRoomId() %>">
                <img src="<%= RoomUtil.getRoomThumbnail(room.getRoomNumber()) %>"
                     onerror="this.src='Images/Svgs/no-image.svg'"
                     alt="<%= room.getRoomName() %>">
            </div>
            <h2 class="roomName"><%= room.getRoomName() %></h2>
            <div class="roomTypeAndNumber">
                <p class="roomType"><%= room.getRoomType() %></p>
                <p class="roomNo"><%= room.getRoomNumber() %></p>
            </div>
            <h1 class="priceContainer">₦ <span class="price"><%= String.format("%,.2f", room.getPricePerNight()) %></span></h1>
            <button class="BookRoomBtn" data-room-id="<%= room.getRoomId() %>" data-room-name="<%= room.getRoomName() %>" data-room-type="<%= room.getRoomType() %>" data-room-number="<%= room.getRoomNumber() %>" data-room-price="<%= room.getPricePerNight() %>" <%= room.getIsBooked() ? "disabled" : "" %>>>
                <span><%= room.getIsBooked() ? "BOOKED" : "Book Room" %></span>
            </button>
        </div>
        <% } %>
    </div>
    <!-- Room Gallery Modal -->
    <div class="roomImgModal">
        <!-- Room Gallery Modal Content -->
        <div class="roomImgModalContent">
            <!-- Close button to close the modal -->
            <button id="room-img-modal-close-btn">✕</button>
            <!-- Top section of the modal -->
            <div class="roomImgTop">
                <!-- Room image container to house the room images and thumbnails -->
                <div class="roomImgContainer">
                    <!-- Room Image Here this will be added dynamically -->
                    <img src="Images/RoomImages/Room_101/image-1.jpg" alt="">
                    <!-- Room Thumbnails Container to house each image thumbnails -->
                    <div class="roomImgThumbnailsContainer">
                        <!-- Each individual thumbnail container -->
                        <div class="roomImgThumbnails">
                            <!-- Image thumbnail -->
                            <img src="Images/RoomImages/Room_101/Thumbnails/image-1.jpg" alt="">
                        </div>
                        <!-- Each Individual Thumbnail container -->
                        <div class="roomImgThumbnails">
                            <!-- Image thumbnail -->
                            <img src="Images/RoomImages/Room_101/Thumbnails/image-2.jpg" alt="">
                        </div>
                    </div>
                    <!-- Navigation buttons to navigate between images -->
                    <button id="prev-btn">❮</button>
                    <button id="next-btn">❯</button>
                </div>
                <!-- Room Info -->
                <div class="roomImgModalRoomInfo">
                    <!-- Room Name (This wil be added dynamically for the particular room clicked) -->
                    <h2 class="roomImgModalRoomName" data-room-id="${roomData.roomId}">Serenity</h2>
                    <!-- Room Description (This too will be added dynamically) -->
                    <p class="roomImgModalRoomDescription">Lorem ipsum dolor, sit amet consectetur adipisicing elit. Reiciendis recusandae iste architecto, praesentium est, modi distinctio corrupti voluptatibus dolores saepe repudiandae! Necessitatibus, cupiditate! Nam harum, sapiente pariatur eius ullam doloremque.</p>
                    <!-- Book button to open the booking modal and form for the particular room -->
                    <button class="BookRoomBtn"><span>BOOK NOW</span></button>
                </div>
            </div>

            <!-- Room Amenities Container -->
            <div class="amenitiesContainer">
                <!--amenities-room-type will be added dynamically this will depend on the room type that is clicked  -->
                <h2><span id="amenities-room-type">Standard </span> Room Amenities</h2>
                <!-- Room Amenities -->
                <ul class="amenities">
                    <li>1 Double or 2 Single Beds</li>
                    <li>Flat Screen TV</li>
                    <li>Telephone</li>
                    <li>Wifi *Upon Request*</li>
                    <li>Individually Controlled A/C & Heating</li>
                    <li>Electronic Lock Key System</li>
                </ul>
            </div>
        </div>
    </div>

        <!-- Modal To book rooms -->
        <div class="bookingModal">
            <!-- Modal content -->
            <form class="modalContent" id="booking-form">
                <!-- This is the modal top for the heading and the close button -->
                <div class="modalTop">
                    <h1>Booking</h1>
                    <span class="closeModal">✕</span>
                </div>
                <!-- Container that houses all guest info -->
                 <div class="allInfo">
                    <!-- guest information section and header -->
                    <h2>Guest Information</h2>
                    <!-- Guest information container -->
                    <div class="information" id="guest-information">
                        <!-- Input field container for name to house the guest information -->
                        <div class = "modalFieldContainers">
                            <!--Input field and label for name input field  -->
                            <input type="text" name="full-name" id="full-name" required>
                            <label for="full-name">Full Name</label>
                        </div>

                        <!-- Input field container for phone no to house the guest information -->
                        <div class = "modalFieldContainers">
                            <!--Input field and label for phone no input field  -->
                            <input type = "tel" name = "phone-no" id = "phone-no" pattern="^(070|080|081|090|091)[0-9]{8}$" required>
                            <label for="phone-no">Phone No</label>
                        </div>

                        <!-- Input field container for email address to house the guest information -->
                        <div class = "modalFieldContainers">
                            <!--Input field and label for email address input field  -->
                            <input type="email" name="email" id="email" required>
                            <label for="email">Email</label>
                        </div>

                        <!-- Input field container for number of guest to house the guest information -->
                        <div class = "modalFieldContainers">
                            <!--Input field and label for number of guest  input field  -->
                            <input type = "number" name = "no-of-guest" id = "no-of-guest" min="1" max="10" required>
                            <label for="no-of-guest">Number of Guest</label>
                        </div>
                        <!-- Input field container for house address to house the guest information -->
                        <div class = "modalFieldContainers">
                            <!--Input field and label for house address input field  -->
                            <input type="text" name="house-address" id="house-address" required>
                            <label for="house-address">House Address</label>
                        </div>
                    </div>

                    <!-- Booking information container -->
                    <h2>Booking Information</h2>
                    <div class="information" id="booking-information">
                        <!-- Input field container for check-in date to house the booking information -->
                        <div class = "modalFieldContainers">
                            <!--Input field and label for Check-In input field  -->
                            <input type="date" name="check-in" id="check-in" class="date" required>
                            <label for="check-in">Check In Date</label>
                        </div>

                        <!-- Input field container for check-out date to house the booking information -->
                        <div class = "modalFieldContainers">
                            <!--Input field and label for Check-Out input field  -->
                            <input type="date" name="check-out" id="check-out" class="date" required>
                            <label for="check-out">Check Out Date</label>
                        </div>
                        <!-- Static field container for Room number, for the room being booked -->
                        <div class = "modalFieldContainers">
                            <!--bookingRoomNo will be added dynamically  -->
                            <span>Number: <span class="bookingRoomNo">101</span></span>
                        </div>

                        <!-- Static field container for Room type, for the room being booked -->
                        <div class = "modalFieldContainers">
                            <!-- bookingRoomType will be added dynamically -->
                            <span>Type: <span class="bookingRoomType">Standard Suite</span></span>
                        </div>
                    </div>
                    <!-- bookingPrice for the room will be added dynamically -->
                    <h3>Price: <span>₦<span class="bookingPrice">120,000</span></span></h3>

                    <!-- This will proceed to the payment page -->
                    <div class="bookingButtons">
                        <button id="proceed-booking">Proceed</button>
                    </div>
                 </div>

            </form>
        </div>

        <div id="conflictModal" class="modal">
            <div class="modal-content">
                <span class="close-conflict-modal">&times;</span>
                <h3>ROOM HAS ALREADY BEEN BOOKED FOR THESE DATES:</h3>
                <div id="conflictDates"></div>
                <p>PLEASE SELECT ANOTHER DATE PERIOD OR ROOM!!</p>
            </div>
        </div>
    </section>
    <script src="JS/jQueryv3.7.1.js"></script>
    <script>
        // Initially hide the booking and room image modals
        $(".bookingModal").hide();
        $(".roomImgModal").hide();

        // Initialize the current slide index and slideshow interval variable
        let currentSlide = 0;
        let slideshowInterval;

        // Get the context path from the URL for potential dynamic URL constructions
        var contextPath = window.location.pathname.split('/')[1];
        console.log("Context Path:", contextPath);
        $(document).ready(function() {
            // Keep input field labels active if they have a value
            $('.modalFieldContainers input').on('input', function() {
                if ($(this).val() !== '') {
                    $(this).addClass('hasValue');
                } else {
                    $(this).removeClass('hasValue');
                }
            });

            // Set the minimum selectable date for date inputs to today
            const currentDate = new Date().toISOString().split('T')[0];
            $('.date').attr('min', currentDate);
            // Ensure that the check-out date cannot be before the check-in date
            $("#check-in").on("change", function() {
                const checkInDate = $(this).val();
                $("#check-out").attr("min", checkInDate);
                if ($("#check-out").val() < checkInDate) {
                    $("#check-out").val(checkInDate); // Reset check-out date if invalid
                }
            });

            // ============ ALL AJAX RESPONSE CODE HERE ====================
            // Set default filter value to "All"
            let currentFilter = "All";

            // Function to update the UI based on the selected room type filter
            function updateUI(filter) {
                console.log("Updating UI for filter:", filter);

                // Update the filter button text
                if (filter === "All") {
                    $(".filterName").html("Filter");
                } else {
                    $(".filterName").html((filter));
                }

                // Update the heading based on filter selection
                if (filter === "All") {
                    $(".roomTypeHeader").text("");
                } else {
                    $(".filterName").text(filter); // Update the filter button text directly
                    $(".roomTypeHeader").text(filter);
                }
            }

            // Function to fetch rooms based on the selected filter via AJAX
            function fetchRooms(filter) {
                $.ajax({
                    url: "RoomServlet", // Servlet URL to fetch rooms
                    type: "GET",
                    data: { roomType: filter },
                    success: function(response) {
                        // Clear and update the container with new room data
                        $(".availableRoomsContainer").empty();
                        // Append the new rooms
                        $(".availableRoomsContainer").html(response);
                    },
                    error: function(xhr, status, error) {
                        console.error("Error fetching rooms:", error);
                    }
                });
            }

            // Toggle filter dropdown on filter button click
            $(".filterBtn").on("click", function(event) {
                event.stopPropagation(); // Prevent the click from propagating to the document
                $(".filterBy").toggleClass("Clicked");
            });

            // Handle selection of a filter option
            $(".filterBy li").on("click", function() {
                const selectedFilter = $(this).data("room-type");
                currentFilter = selectedFilter;
                updateUI(selectedFilter);  // Update UI to reflect selected filter
                fetchRooms(selectedFilter); // Fetch rooms for the selected filter
                $(".filterBy").removeClass("Clicked"); // Close the filter dropdown
            });

            // Close the dropdown when clicking outside
            $(document).on('click', function(event) {
                if (!$(event.target).closest('.filterBy, .filterBtn').length) {
                    $('.filterBy').removeClass('Clicked');
                }
            });

            // Initialize UI and fetch default room list with "All" filter
            updateUI(currentFilter);
            fetchRooms(currentFilter);

            // =================== Booking Form Submission ===================
            $("#booking-form").on("submit", function(event) {
                event.preventDefault(); // Prevent the form from submitting normally

                // Serialize form data for submission
                const formData = $(this).serializeArray();

                // Log the form data for debugging
                console.log("Form Data:", formData);

                // Simulate a payment gateway before actual booking submission
                simulatePaymentGateway(formData);
            });

            // Simulate a payment process with a delay
            function simulatePaymentGateway(formData) {
                // Show a loading spinner or message
                $(".bookingButtons").html("<p>Processing booking...</p>");

                // Simulate a delay (e.g., 2 seconds)
                const promise = new Promise((resolve) => {
                    setTimeout(() => {
                        // Simulate successful payment; change to false to simulate failure
                        const paymentSuccess = true;
                        resolve(paymentSuccess);
                    }, 2000); // Simulate a 2-second delay
                });

                promise.then((paymentSuccess) => {
                    if (paymentSuccess) {
                        // Submit booking via AJAX if payment is successful
                        $.ajax({
                            url: "BookingServlet",
                            type: "POST",
                            data: $.param(formData),
                            dataType: "json", // ✅ Expect a JSON response
                            success: function(response) {
                                if (response.conflicts) {
                                    showConflictModal(response.conflicts);
                                } else {
                                    window.location.href = response.redirectUrl;
                                }
                            },
                            error: function(xhr, status, error) {
                                handleBookingError();
                            }
                        });
                    } else {
                        // Handle payment failure
                        handlePaymentFailure();
                    }
                });
            }

            // Show a modal if there are date conflicts in the booking
            function showConflictModal(conflicts) {
                const now = new Date();
                const conflictList = conflicts.map(dates => {
                    const [start, end] = dates.split(' - ');
                    const startDate = new Date(start.split('/').reverse().join('-'));
                    return startDate < now ?
                        `<span class="past-date">`+(dates)+` (Past)</span>` :
                        dates;
                }).join('<br>');

                $('#conflictDates').html(conflictList);
                $('#conflictModal').fadeIn();

                // Auto-close conflict modal after 10 seconds
                setTimeout(() => {
                    $('#conflictModal').fadeOut();
                }, 10000);
                // Reset booking buttons after showing conflict modal
                $(".bookingButtons").html('<button id="proceed-booking">Proceed to Pay</button>');
            }

            // Close the conflict modal when clicking outside or on the close button
            $('.close-conflict-modal, #conflictModal').click(function(e) {
                if ($(e.target).hasClass('close-conflict-modal') || $(e.target).is('#conflictModal')) {
                    $('#conflictModal').fadeOut();
                }
            });

            // Validate that the selected check-in and check-out dates are valid
            function validateDates(checkIn, checkOut) {
                const today = new Date();
                today.setHours(0,0,0,0);

                if (new Date(checkIn) < today) {
                    alert("Check-in date cannot be in the past!");
                    return false;
                }

                if (new Date(checkOut) < new Date(checkIn)) {
                    alert("Check-out date must be after check-in date!");
                    return false;
                }

                return true;
            }


            // Function to handle successful booking
            function handleBookingSuccess(response) {
                $(".bookingModal").fadeOut(); // Hide the booking modal
                $("#booking-form")[0].reset(); // Reset form fields
                $(".bookingButtons").html('<button id="proceed-booking">Proceed to Pay</button>'); // Reset the "Proceed to Pay" button
                // Re-fetch room list to update availability
                fetchRooms(currentFilter); // Refresh the room list
            }

            // Handle booking errors by alerting the user and resetting form/button states
            function handleBookingError() {
                alert("An error occurred while processing your booking. Please try again.");
                $("#booking-form")[0].reset();
                $(".bookingButtons").html('<button id="proceed-booking">Proceed to Pay</button>');
            }

            // Handle payment failure with an alert and reset the booking form/buttons
            function handlePaymentFailure() {
                // Show a payment failure message
                alert("Payment failed. Please check your payment details and try again.");
                $("#booking-form")[0].reset();
                $(".bookingButtons").html('<button id="proceed-booking">Proceed to Pay</button>');
            }

            // Variable to hold the room's price per night, updated when a room is selected
            let roomPricePerNight = 0; // Will hold the room's price per night

            // Event delegation: When a room's Book button is clicked
            $(".availableRoomsContainer").on("click", ".BookRoomBtn", function() {
                const initialDays = 1;
                const initialTotalPrice = roomPricePerNight * initialDays;
                if (!validateDates($('#check-in').val(), $('#check-out').val())) {
                    return;
                }
                // Update the displayed booking price
                $(".bookingPrice").text(initialTotalPrice.toLocaleString(undefined, {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                }));

                // Remove any existing hidden totalPrice field and add a new one with the calculated price
                $("#totalPrice").remove();
                $("<input>")
                    .attr({
                        type: "hidden",
                        id: "totalPrice",
                        name: "totalPrice",
                        value: initialTotalPrice
                    })
                    .appendTo("#booking-form");

                // Add the animate class to the clicked button
                $(this).addClass("animate");

                // Remove the animate class after the animation finishes
                $(this).on("animationend", function() {
                    $(this).removeClass("animate");
                });

                // Retrieve room details from the button's data attributes
                const roomId = $(this).data("room-id");
                const roomName = $(this).data("room-name");
                const roomType = $(this).data("room-type");
                const roomNumber = $(this).data("room-number");
                roomPricePerNight = $(this).data("room-price");

                console.log("Room ID:", roomId); // Debugging: For Checking if room details are logged

                // Populate the booking modal with the selected room details
                $(".bookingRoomNo").text(roomNumber);
                $(".bookingRoomType").text(roomType);
                $(".bookingPrice").text(roomPricePerNight.toLocaleString());

                // Store the room ID in a hidden field within the booking form
                $("#roomId").remove(); // Remove any existing hidden field
                $("<input>").attr({
                    type: "hidden",
                    id: "roomId",
                    name: "roomId",
                    value: roomId
                }).appendTo("#booking-form");

                // Show the booking modal
                $(".bookingModal").fadeIn();
                console.log("Booking modal shown"); // Debugging: Check if this logs
            });

            // Recalculate the total booking price when check-in or check-out dates change
            $("#check-in, #check-out").on("change", function() {
                const checkInDate = new Date($("#check-in").val());
                const checkOutDate = new Date($("#check-out").val());
                const timeDiff = checkOutDate - checkInDate;
                const days = Math.ceil(timeDiff / (1000 * 3600 * 24)) || 1;
                const totalPrice = roomPricePerNight * days;
                // Update displayed price
                $(".bookingPrice").text(totalPrice.toLocaleString(undefined, {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                }));
                // Update hidden field
                $("#totalPrice").val(totalPrice);
            });

            // Close the booking modal when the close button is clicked
            $(".closeModal").on("click", function() {
                $(".bookingModal").fadeOut();
                console.log("Booking modal hidden"); // Debugging: Check if this logs
            })

            // =========================THIS IS TO SET THE FILTER WHEN THROUGH THE ROOMS TYPES BTN FROM THE INDEX.JSP=================================
            // Retrieve room_type parameter from URL if present
            const urlParams = new URLSearchParams(window.location.search);
            const roomTypeParam = urlParams.get('room_type');

            if(roomTypeParam) {
                // Decode and set the filter
                const decodedType = decodeURIComponent(roomTypeParam.replace(/\+/g, ' '));
                updateUI(decodedType);
                fetchRooms(decodedType);
            }

            // Force a background availability refresh
            $.post("BackgroundRefreshServlet");

            // ============================================== GALLERY FUNCTIONALITY ================================================================
            // When a room image container is clicked, load room details for the modal
            $("section").on("click", ".availableRoomImgContainer", function() {
                const roomId = $(this).data("room-id");
                console.log("Fetching details for room ID:", roomId);
                loadRoomDetails(roomId);
                $(".roomImgModal").fadeIn();
            });

            // Close the room image modal when clicking the close button or modal overlay
            $("#room-img-modal-close-btn, .roomImgModal").click(function(e) {
                if (e.target === this) {
                    clearInterval(slideshowInterval);
                    $(".roomImgModal").fadeOut();
                }
            });

            // Load room details for the image modal via AJAX
            function loadRoomDetails(roomId) {
                $.ajax({
                    url: "RoomDetailsServlet",
                    data: { roomId: roomId },
                    success: function(data) {
                        updateModalContent(data);
                        startSlideshow();
                        $(".roomImgModal").fadeIn();
                    },
                    error: function() {
                        alert("Error loading room details");
                    }
                });
            }

            // Update the modal content with the retrieved room details
            function updateModalContent(roomData) {
                console.log("Room Data:", roomData);

                // Clear previously existing content
                $(".roomImgModalRoomName").empty();
                $(".roomImgModalRoomDescription").empty();
                $(".amenities").empty();


                // Update text details in the modal
                if (roomData.roomName) {
                    $(".roomImgModalRoomName").text(roomData.roomName);
                }
                if (roomData.description) {
                    $(".roomImgModalRoomDescription").text(roomData.description);
                }
                if (roomData.roomType) {
                    $("#amenities-room-type").text(roomData.roomType);
                }

                // Populate/Update amenities list
                if (roomData.amenities && roomData.amenities.length > 0) {
                    roomData.amenities.forEach((item) => {
                        $(".amenities").append($("<li>").text(item)); // Explicit jQuery element creation
                    });
                }

                // Handle images: build the base path using the room number
                contextPath = window.location.pathname.split('/')[1];
                const mainImg = $(".roomImgContainer img:first");
                const thumbnailsContainer = $(".roomImgThumbnailsContainer");
                thumbnailsContainer.empty();

                if (roomData.images?.length > 0 && roomData.roomNumber) {
                    const basePath = `Images/RoomImages/Room_`+(roomData.roomNumber)+`/`;
                    console.log(basePath)

                    // Set main image
                    const mainImageUrl = (basePath)+(roomData.images[0]);

                    console.log("Main Image URL:", mainImageUrl);

                    mainImg.attr("src", mainImageUrl)
                        .on("error", function() {
                            console.error("Failed to load:", mainImageUrl);
                            $(this).attr("src", "Images/Svgs/no-image.svg");
                        });

                    // Thumbnails
                    roomData.images.forEach((filename) => {
                        const thumbnailUrl = (basePath)+`Thumbnails/`+(filename);
                        console.log("Thumbnail URL:", thumbnailUrl);


                        const thumbnail = `
                          <div class="roomImgThumbnails">
                            <img src="`+(thumbnailUrl)+`" onerror="this.src='Images/Svgs/no-image.svg'">
                          </div>
                        `;


                        thumbnailsContainer.append(thumbnail);
                    });
                } else {
                    mainImg.attr("src", "Images/Svgs/no-image.svg");
                }
                // 5. Handle Book Now button
                $(".roomImgModal .BookRoomBtn").off("click").click(function() {
                    $(".roomImgModal").fadeOut();
                    <%--$(`.BookRoomBtn[data-room-id="${roomData.roomId}"]`).trigger("click");--%>
                    $('.BookRoomBtn[data-room-id="'+(roomData.roomId)+'"]').trigger("click");

                });
            }

            // Start a slideshow for room images in the modal
            function startSlideshow() {
                clearInterval(slideshowInterval);
                const images = $(".roomImgThumbnails img");
                if (images.length < 2) return;

                slideshowInterval = setInterval(() => {
                    currentSlide = (currentSlide + 1) % images.length;
                    updateMainImage(currentSlide);
                }, 5000);

                // Navigation buttons for slideshow
                $("#prev-btn").off("click").click(() => navigate(-1));
                $("#next-btn").off("click").click(() => navigate(1));            }

            // Update the main image based on the current slide index
            function updateMainImage(index) {
                const thumbnails = $(".roomImgThumbnails");
                if (index >= thumbnails.length) index = 0;
                if (index < 0) index = thumbnails.length - 1;

                const targetThumbnail = thumbnails.eq(index);
                const newSrc = targetThumbnail.find("img").attr("src");

                $(".roomImgContainer img:first")
                    .attr("src", newSrc)
                    .on("error", function() {
                        $(this).attr("src", "Images/Svgs/no-image.svg");
                    });

                thumbnails.removeClass("active");
                targetThumbnail.addClass("active");
            }

            // Navigation function to move between slides
            function navigate(direction) {
                currentSlide += direction;
                if (currentSlide < 0) currentSlide = $(".roomImgThumbnails").length - 1;
                if (currentSlide >= $(".roomImgThumbnails").length) currentSlide = 0;
                updateMainImage(currentSlide);
                clearInterval(slideshowInterval);
                startSlideshow();
            }

            // Navigation button event handlers
            $("#prev-btn").click(() => navigate(-1));
            $("#next-btn").click(() => navigate(1));

            // Prevent back navigation using browser history manipulation
            history.replaceState(null, null, document.URL);
            window.addEventListener('popstate', function(event) {
                history.pushState(null, null, document.URL);
                window.location.href = "index.jsp";
            });

            // Force a refresh if the page is loaded from cache
            window.onpageshow = function(event) {
                if (event.persisted) {
                    window.location.reload();
                }
            };

        });
    </script>
</body>
</html>