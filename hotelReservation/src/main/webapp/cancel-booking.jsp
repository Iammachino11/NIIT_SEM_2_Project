<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/CSS/google-fonts.css">
    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* ================== CODE FOR THE LOADING SCREEN ================================= */
        .loadingScreen{
            position: fixed;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            max-width: 100vw;
            width: 100%;
            background-color: #fff;
            z-index: 10000;
        }

        .loader {
            width: 100px;
            aspect-ratio: 1;
            border-radius: 50%;
            border: 5px solid #d3b037;
            animation:
                    l20-1 0.8s infinite linear alternate,
                    l20-2 1.6s infinite linear;
        }

        .loaderLogo{
            position: absolute;
            width: 50px;
            animation: loaderIcon 1s ease-in-out 0s infinite normal forwards;
        }

        @keyframes l20-1{
            0%    {clip-path: polygon(50% 50%,0       0,  50%   0%,  50%    0%, 50%    0%, 50%    0%, 50%    0% )}
            12.5% {clip-path: polygon(50% 50%,0       0,  50%   0%,  100%   0%, 100%   0%, 100%   0%, 100%   0% )}
            25%   {clip-path: polygon(50% 50%,0       0,  50%   0%,  100%   0%, 100% 100%, 100% 100%, 100% 100% )}
            50%   {clip-path: polygon(50% 50%,0       0,  50%   0%,  100%   0%, 100% 100%, 50%  100%, 0%   100% )}
            62.5% {clip-path: polygon(50% 50%,100%    0, 100%   0%,  100%   0%, 100% 100%, 50%  100%, 0%   100% )}
            75%   {clip-path: polygon(50% 50%,100% 100%, 100% 100%,  100% 100%, 100% 100%, 50%  100%, 0%   100% )}
            100%  {clip-path: polygon(50% 50%,50%  100%,  50% 100%,   50% 100%,  50% 100%, 50%  100%, 0%   100% )}
        }
        @keyframes l20-2{
            0%    {transform:scaleY(1)  rotate(0deg)}
            49.99%{transform:scaleY(1)  rotate(135deg)}
            50%   {transform:scaleY(-1) rotate(0deg)}
            100%  {transform:scaleY(-1) rotate(-135deg)}
        }

        @keyframes loaderIcon{
            0%{
                transform: scale(100%);
            }
            50%{
                transform: scale(75%);
            }
            100%{
                transform: scale(100%);
            }
        }

        /* =============================== END OF CODE FOR THE LOADING SCREEN ======================= */

        input{
            outline: none;
        }
        /* This is to remove outline when the input field is focused on */
        input:focus, textarea:focus{
            outline: none;
            border: none;
        }

        section{
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            height: 100%;
            max-width: 100vw;
            width: 100%;
        }

        form{
            position: relative;
            display: flex;
            flex-direction: column;
            gap: 10px;
            width: 400px;
            background-color: #f8f8f8;
            padding: 20px;
            border-radius: 10px;
        }

        form.validationForm h1{
            font-family: 'Montserrat', sans-serif;
            text-align: center;
            color: #CCB67D;
        }
        
        form.validationForm p{
            font-family: 'Jost', sans-serif;
            text-align: center;
        }

        .inputFieldContainers{
            width: 100%;
            min-width: 160px;
            min-height: 40px;
            height: 40px;
            position: relative;
            margin-top: 15px;
            flex-grow: 1;
        }

        /* Styling for input fields and text areas here */
        .inputFieldContainers input, 
        .inputFieldContainers span,
        .inputFieldContainers textarea{
            background-color: rgba(255, 255, 255, 0);
            padding-left: 15px;
            font-family: 'Poppins', sans-serif;
            font-size: 13px;
            width: 100%;
            height: 100%;
            border: 2px solid grey;
            border-radius: 5px;
            text-align:left;
            overflow: hidden;
            color:black;
        }

        .inputFieldContainers input:-webkit-autofill,
        .inputFieldContainers input:-webkit-autofill:hover, 
        .inputFieldContainers input:-webkit-autofill:focus,
        .inputFieldContainers textarea:-webkit-autofill,
        .inputFieldContainers textarea:-webkit-autofill:hover,
        .inputFieldContainers textarea:-webkit-autofill:focus,
        .inputFieldContainers select:-webkit-autofill,
        .inputFieldContainers select:-webkit-autofill:hover,
        .inputFieldContainers select:-webkit-autofill:focus {
        /* border: 1px solid #43434600; */
        -webkit-text-fill-color: black;
        -webkit-box-shadow: 0 0 0px 1000px  #f8f8f8 inset;
        background-clip: padding-box;
        background-color: #f8f8f8;
        transition: background-color 5000s ease-in-out 0s;
        }

        .inputFieldContainers span{
            display: flex;
            align-items: center;
            font-family: 'Poppins', sans-serif;
            font-size: 12px;
            background-color: #e5e5e5;
            border: none;
            gap: 5px;
        }

        /* Change the state of the label on input field focus and if content is in it */
        .inputFieldContainers input:focus~label,
        .inputFieldContainers input.hasValue~label,
        .inputFieldContainers textarea:focus~label,
        .inputFieldContainers textarea.hasValue~label{
            pointer-events: none;
            font-size: 11px;
            transform: translateY(-16px);
            color: #CCB67D;
        }

        /* Styling for the input fields label text which displays what field that is for */
        .inputFieldContainers label{
            position: absolute;
            display: flex;
            align-items: center;
            gap: 10px;
            top: 9px;
            left: 10px;
            pointer-events: none;
            transition: all 0.3s ease;
            color: grey;
            padding: 0px 5px;
            background-color: #f8f8f8;
            font-family: 'Poppins', sans-serif;
            font-size: 14px;
            pointer-events: none;
        }

        /* Styling to change the color of the input fields borders when focused */
        .inputFieldContainers input:focus,
        .inputFieldContainers input.hasValue,
        .inputFieldContainers textarea:focus,
        .inputFieldContainers textarea.hasValue{
            border: 2px solid #CCB67D;
            transition: border-bottom 0.5s;
        }
        button{
            cursor: pointer;
            background-color: #CCB67D;
            padding: 10px;
            width: 100%;
            border: none;
            border-radius: 5px;
            font-size: 16px;
        }

        .bookingInfoContainer{
            position: relative;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .BookingInfo{
            display: flex;
            flex-direction: column;
            gap: 10px;
            background-color: #f8f8f8;
            padding: 20px;
            width: 400px;
            border-radius: 10px;
        }
        .detailsContainer{
            display: flex;
            align-items: center;
            gap: 20px;
            justify-content: space-between;
            font-family: 'Poppins', sans-serif;
        }

        .title{
            color: grey;
        }

        .info{
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            width: 100px;
            flex-grow: 1;
        }
        .info::before{
            content: '';
            width: 50px;
            flex-grow: 1;
            border-bottom: 2px dotted grey;
        }

        .BookingInfo>h2{
            font-family: 'Montserrat', sans-serif;
            text-align: center;
            margin-bottom: 10px;
            padding: 10px;
        }

        .cancelBookingForm h2{
            width: 100%;
            font-family: 'Montserrat', sans-serif;
            text-align: center;
        }
        .reasonContainer{
            display: flex;
            gap: 10px;
            align-items: center;
            background-color: #e5e5e5;
            padding: 5px 10px;
            border-radius: 5px;
        }
        .reasonContainer label{
            font-family: 'Poppins',sans-serif;
        }

        .reason5Container{
            height: auto;
        }

        .inputFieldContainers textarea{
            resize: none;
            height: 150px;
            padding: 10px;
        }

        .successInfo{
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-family: 'Poppins', sans-serif;
            height: 300px;
            width: 380px;
            padding: 20px;
            z-index: 10000;
            color: #000000;
            transition: 0.5s ease;
            background-color: #f8f8f8;
            border-radius: 10px;
        }
        .successInfo h1{
            margin-top: 10px;
            font-weight: normal;
            font-size: 25px;
            text-align: center;
        }
        .successInfo p{
            font-size: 14px;
            text-align: center;
        }

        .tickerContainer{
            position: relative;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            height: 50px;
            width: 50px;
            padding: 10px;
            color: white;
            background: linear-gradient(135deg, rgba(84,212,101,1) 50%, rgb(90, 188, 186) 100%);
            border-radius: 50%;
        }

        .tickerContainer::before{
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            content: '';
            width: 0;
            height: 0;
            background-color: #00000000;
            border: 2px solid #54d465;
            animation: checkmarkCirle 0.8s ease forwards;
            opacity: 1;
            border-radius: 50%;
        }

        .tickerDots{
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            list-style: none; /* Remove default list styling */
            padding: 0;
            margin: 0;
        }

        .tickerDot{
            position: absolute;
            width: 5px;
            height: 5px;
            background-color: #54d465;
            border-radius: 50%; /* Make the dots circular */
            opacity: 0; /* Start hidden */
            animation: spreadOut 0.8s ease forwards; /* Apply the animation */
        }

        @keyframes spreadOut {
            0% {
                opacity: 0;
                transform: translate(0, 0) scale(0); /* Start at the center */
            }
            50% {
                opacity: 1;
                transform: translate(var(--x), var(--y)) scale(1); /* Move to unique positions */
            }
            100% {
                opacity: 0;
                transform: translate(var(--x), var(--y)) scale(1); /* Move to unique positions */
            }
        }

        /* Assign unique positions to each dot using CSS variables */
        .tickerDot:nth-child(1) { --x: -30px; --y: -30px; }
        .tickerDot:nth-child(2) { --x: 30px; --y: -30px; }
        .tickerDot:nth-child(3) { --x: -30px; --y: 30px; }
        .tickerDot:nth-child(4) { --x: 35px; --y: 30px; }
        .tickerDot:nth-child(5) { --x: -40px; --y: 0; }
        .tickerDot:nth-child(6) { --x: 40px; --y: 0; }


        @keyframes checkmarkCirle {
            0% {
                width: 0;
                height: 0;
                opacity: 1;
            }
            50% {
                width: 130%;
                height: 130%;
                opacity: 1;
            }
            100% {
                width: 130%;
                height: 130%;
                opacity: 0;
            }
            
        }

        .tickerSvg {
            width: 100%;
            margin: 1px 0 0 1px;
        }

        .tickerLine{
            stroke-dasharray: 52.5; /* Total length of the path */
            stroke-dashoffset: 52.5; /* Start with the path hidden */
            animation: drawCheckmark 1s ease 0.2s forwards;
        }

        @keyframes drawCheckmark {
            to {
                stroke-dashoffset: 0;
            }
        }
    </style>
</head>
<body>
<!-- Loading Screen -->
<div class="loadingScreen" id="loading-screen">
    <div class="loader">
    </div>
    <img src="Images/Svgs/load-screen-logo.svg" class="loaderLogo" alt="">
</div>
    <section>
        <form action="" class="validationForm" id="validation-form">
            <h1>Cancel Booking </h1>
            <p>Enter Your Booking Code to cancel room bookings</p>
            <div class = "inputFieldContainers">
                <input type="text" name="cancel-validation" id="cancel-validation" required>
                <label for="cancel-validation">Booking Code</label>
            </div>
            <button id="validate-cancel">Next</button>
        </form>
        <div class="bookingInfoContainer">
            <div class="BookingInfo">
                <h2>Booking Info </h2>
                <div class="detailsContainer">
                    <p class="title">Booking Code</p>
                    <span class="info" id="booking-code">JNHK101321</span>
                </div>
                <div class="detailsContainer">
                    <p class="title">Full Name</p>
                    <span class="info" id="full-name">Jenna Hitchkins</span>
                </div>
                <div class="detailsContainer">
                    <p class="title">Room No</p>
                    <span class="info" id="room-no">101</span>
                </div>
                <div class="detailsContainer">
                    <p class="title">Room Type</p>
                    <span class="info" id="room-type">Standard Suite</span>
                </div>
                <div class="detailsContainer">
                    <p class="title">Price</p>
                    <span class="info"><span>₦ 420,000</span></span>
                </div>
                <div class="detailsContainer">
                    <p class="title">Booking Date</p>
                    <span class="info" id="booking-date">10/03/2025 12:35 PM</span>
                </div>
            </div>
            <button id="cancel-btn">CANCEL</button>
        </div>
        <form action="" class="cancelBookingForm" id="cancel-booking-form">
            <h2>Reason for Cancelation</h2>
            <div class="reasonContainer">
                <input type="checkbox" name="reason-1" id="reason-1" value="Technical Issues or Double Booking">
                <label for="reason-1">Technical Issues or Double Booking</label>
            </div>
            <div class="reasonContainer">
                <input type="checkbox" name="reason-2" id="reason-2" value="Unavailability of Preferred Room or Rate">
                <label for="reason-2">Unavailability of Preferred Room or Rate</label>
            </div>
            <div class="reasonContainer">
                <input type="checkbox" name="reason-3" id="reason-3" value="Hotel Facilities or Services Issues">
                <label for="reason-3">Hotel Facilities or Services Issues</label>
            </div>
            <div class="reasonContainer">
                <input type="checkbox" name="reason-4" id="reason-4" value="Change of Heart or Plans">
                <label for="reason-4">Change of Heart or Plans</label>
            </div>
            <div class="reasonContainer">
                <input type="checkbox" name="reason-5" id="reason-5" value="Others">
                <label for="reason-5">Others</label>
            </div>
            <div class="inputFieldContainers reason5Container">
                <textarea name="reason-text" id="reason-text"></textarea>
                <label for="reason-5">Tell Us More!!</label>
            </div>
            <button id="submit-cancel-btn">CANCEL BOOKING</button>
        </form>

        <div class="successInfo">
            <div class="tickerContainer">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 30" class="tickerSvg">
                    <polyline class="tickerLine" points="1.38,13.54 8.47,20.26 23.6,4.75" stroke="currentColor" stroke-width="5" fill="none" />
                </svg>
                <ul class="tickerDots">
                    <li class="tickerDot"></li>
                    <li class="tickerDot"></li>
                    <li class="tickerDot"></li>
                    <li class="tickerDot"></li>
                    <li class="tickerDot"></li>
                    <li class="tickerDot"></li>
                </ul>
            </div>
            <h1>Booking Cancelled Successfully</h1>
            <p>Your Booking cancellation is successfull You will be redirected to back to the home page in <span id="timer">3</span></p>
        </div>
        
    </section>
    <script src="JS/jQueryv3.7.1.js"></script>
    <script>
        $(document).ready(function(){
                    // For making input field label stay the way it is if there is a character in it
            $('input').on('input', function() {
                if ($(this).val() !== '') {
                    $(this).addClass('hasValue');
                } else {
                    $(this).removeClass('hasValue');
                }
            });
          // Initially hide the textarea container for "Others"
          $(".reason5Container").hide();

          // Handler for the standard reasons (excluding "Others")
          $(".cancelBookingForm input[type='checkbox']").not("#reason-5").on('change', function(e){
            // When any standard option is checked, uncheck "Others" and hide its textarea.
            $("#reason-5").prop("checked", false);
            $(".reason5Container").hide();

            // Only act if the checkbox is being checked.
            if ($(this).is(":checked")) {
              var checkedBoxes = $(".cancelBookingForm input[type='checkbox']")
                                    .not("#reason-5")
                                    .filter(":checked");
              if (checkedBoxes.length > 2) {
                // If more than two are selected, uncheck the first one (in DOM order) that is not the current one.
                checkedBoxes.each(function(){
                  if (this !== e.target) {
                    $(this).prop("checked", false);
                    return false; // break out of the loop after unchecking one.
                  }
                });
              }
            }
          });

          // Handler for the "Others" checkbox
          $("#reason-5").on('change', function(){
            if($(this).is(":checked")){
              // Uncheck all standard options and show the textarea.
              $(".cancelBookingForm input[type='checkbox']").not("#reason-5").prop("checked", false);
              $(".reason5Container").show();
            } else {
              // Hide the textarea if "Others" is unchecked.
              $(".reason5Container").hide();
            }
          });

        //  ================================================= DYNAMIC STUFFS HERE ===========================================================
            // UI Initialization
// UI Initialization
            $(".validationForm").show();
            $(".bookingInfoContainer").hide();
            $(".cancelBookingForm").hide();
            $(".successInfo").hide();
            $(".loadingScreen").hide();
            let currentBooking = null;

            // Input field label handling
            $('input').on('input', function() {
                $(this).toggleClass('hasValue', $(this).val().trim() !== '');
            });

            // Cancel reason handling
            $(".reason5Container").hide();
            handleCancelReasons();

            // Form submissions
            $("#validation-form").submit(handleValidation);
            $("#cancel-booking-form").submit(handleCancellation);

            // Modified cancel button handler: directly show cancellation form
            $("#cancel-btn").click(function() {
                $(".bookingInfoContainer").hide();
                $(".cancelBookingForm").show();
            });

            // ======================== DYNAMIC FUNCTIONALITY =================================
            // Modified validation success handler
            function handleValidationResponse(response) {
                if (response.valid && response.cancelAllowed) {
                    currentBooking = {
                        booking_code: response.bookingCode,
                        booking_id: response.bookingId,
                        room_id: response.roomId,
                        guest_name: response.guestName,
                        room_number: response.roomNumber,
                        room_type: response.roomType,
                        total_price: response.totalPrice,
                        booking_date: response.bookingDate,
                        check_in_date: response.checkInDate
                    };
                    updateBookingUI();
                    $(".validationForm").hide();
                    $(".bookingInfoContainer").show();
                } else {
                    handleValidationError(response);
                    $(".bookingInfoContainer").hide();
                    $(".validationForm").show();
                }
            }

            // Modified cancellation success handler
            function handleCancellationSuccess(response) {
                if (response.success) {
                    $(".cancelBookingForm").hide();
                    $(".successInfo").show();
                    startCountdown();
                } else {
                    showErrorAlert(response.message || "Cancellation failed");
                    $(".cancelBookingForm").hide();
                    $(".validationForm").show();
                }
            }

            // New function to reset UI state
            function resetFormState() {
                $(".validationForm").show();
                $(".bookingInfoContainer").hide();
                $(".cancelBookingForm").hide();
                $(".successInfo").hide();
                $("#cancel-validation").val('');
            }

            // Update startCountdown to include reset
            function startCountdown() {
                let seconds = 5;
                const timer = $("#timer");

                const interval = setInterval(() => {
                    timer.text(seconds);
                    if (seconds-- <= 0) {
                        clearInterval(interval);
                        resetFormState();
                        window.location.href = "index.jsp";
                    }
                }, 1000);
            }

            // Update AJAX handlers to use new functions
            function handleValidation(e) {
                e.preventDefault();
                showLoading();
                $.ajax({
                    url: "CancelBookingServlet",
                    type: "POST",
                    data: {
                        action: "validate",
                        bookingCode: $("#cancel-validation").val().trim()
                    },
                    success: handleValidationResponse,
                    error: function() {
                        showErrorAlert("Error validating booking");
                        resetFormState();
                    },
                    complete: hideLoading
                });
            }

            function handleCancellation(e) {
                e.preventDefault();
                if (!validateCancellationTime()) return;
                showLoading();
                const cancellationReason = buildCancellationReason();
                $.ajax({
                    url: "CancelBookingServlet",
                    type: "POST",
                    data: {
                        action: "cancel",
                        bookingId: currentBooking.booking_id,
                        roomId: currentBooking.room_id,
                        reason: cancellationReason
                    },
                    success: handleCancellationSuccess,
                    error: function(xhr) {
                        showErrorAlert(xhr.responseJSON?.message || "Cancellation failed");
                        resetFormState();
                    },
                    complete: hideLoading
                });
            }

            // ======================== HELPER FUNCTIONS =================================
            function handleCancelReasons() {
                // Standard reasons
                $(".cancelBookingForm input[type='checkbox']").not("#reason-5").on('change', function(e) {
                    if ($(this).is(":checked")) {
                        $("#reason-5").prop("checked", false);
                        $(".reason5Container").hide();
                        limitStandardReasonSelection(e.target);
                    }
                });

                // "Others" reason
                $("#reason-5").on('change', function() {
                    if ($(this).is(":checked")) {
                        $(".cancelBookingForm input[type='checkbox']").not("#reason-5").prop("checked", false);
                        $(".reason5Container").show();
                    } else {
                        $(".reason5Container").hide();
                    }
                });
            }

            function limitStandardReasonSelection(currentTarget) {
                const checkedBoxes = $(".cancelBookingForm input[type='checkbox']")
                    .not("#reason-5")
                    .filter(":checked");

                if (checkedBoxes.length > 2) {
                    checkedBoxes.each(function() {
                        if (this !== currentTarget) {
                            $(this).prop("checked", false);
                            return false;
                        }
                    });
                }
            }

            function updateBookingUI() {
                try {
                    $("#booking-code").text(currentBooking.booking_code || "N/A");
                    $("#full-name").text(currentBooking.guest_name || "N/A");
                    $("#room-no").text(currentBooking.room_number || "N/A");
                    $("#room-type").text(currentBooking.room_type || "N/A");
                    $("#price").text(formatPrice(currentBooking.total_price));
                    $("#booking-date").text(formatDate(currentBooking.booking_date));
                    $(".validationForm").hide();
                    $(".bookingInfoContainer").show();
                } catch (error) {
                    console.error("UI update error:", error);
                    showErrorAlert("Error displaying booking information");
                }
            }

            function formatPrice(price) {
                if (!price) return "₦ N/A";
                const formatted = parseFloat(price).toLocaleString('en-NG', {
                    style: 'currency',
                    currency: 'NGN',
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                });
                return formatted.replace('NGN', '₦');
            }

            function formatDate(dateString) {
                try {
                    const options = {
                        year: 'numeric',
                        month: 'long',
                        day: 'numeric',
                        hour: '2-digit',
                        minute: '2-digit'
                    };
                    return new Date(dateString).toLocaleDateString('en-US', options);
                } catch {
                    return "Date not available";
                }
            }

            function validateCancellationTime() {
                try {
                    const checkInDate = new Date(currentBooking.check_in_date);
                    const today = new Date();
                    if (today >= checkInDate) {
                        showErrorAlert('Cannot cancel booking after check-in date');
                        return false;
                    }
                    return true;
                } catch (error) {
                    console.error("Date validation error:", error);
                    return false;
                }
            }

            function buildCancellationReason() {
                if ($("#reason-5").is(":checked")) {
                    return $("#reason-text").val().trim();
                }
                return $("input[type='checkbox']:checked").not("#reason-5")
                    .map(function() { return $(this).val(); })
                    .get().join(", ");
            }

            function handleValidationError(response) {
                const message = response.message || "Invalid booking code";
                if (response.valid && !response.cancelAllowed) {
                    $(".bookingInfoContainer").show();
                    $(".cancel-btn").prop("disabled", true);
                    showErrorAlert(message);
                } else {
                    showErrorAlert(message);
                    $(".bookingInfoContainer").hide();
                    $(".cancelBookingForm").hide();
                    $(".successInfo").hide();
                    $(".loadingScreen").hide();
                }
            }

            // Utility functions
            function showLoading() {
                $(".loadingScreen").fadeIn(200);
            }

            function hideLoading() {
                $(".loadingScreen").fadeOut(200);
            }

            function showErrorAlert(message) {
                alert(message);
            }
        });
      </script>
      
</body>
</html>