<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body{
            background-color: #e0e2e2;
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

        .container{
            display: flex;
            flex-direction: column;
            min-width: 400px;
            max-width: 450px;
            width: 100%;
            height: auto;
            padding: 20px;
            gap: 20px;
        }

        .successInfo{
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-family: 'Poppins', sans-serif;
            height: auto;
            width: 100%;
            padding: 20px 0;
            z-index: 10000;
            color: #000000;
            transition: 0.5s ease;
            border-bottom: 1px solid grey;
        }
        .successInfo h1{
            margin-top: 10px;
            font-weight: normal;
            font-size: 25px;
        }
        .successInfo p{
            font-size: 14px;
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

        .successContainer{
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
            padding: 30px 20px;
            background-color: white;
            -webkit-user-select: none;
            -khtml-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            -webkit-tap-highlight-color: transparent;
        }

        .transactionBody{
            display: flex;
            gap: 10px;
            flex-direction: column;
            font-family: 'Poppins', sans-serif;
            padding: 10px 0;
            width: 100%;
        }

        .transactionBody span{
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            width: 100%;
        }

        .title{
            width: auto !important;
            color: grey;
        }
        .transactionInfo{
            display: flex;
            align-items: center;
            width: 200px !important;
            flex-grow: 1;
            
        }

        .currencySymbol{
            width: auto !important;
            font-family: 'Lato', sans-serif;
        }
        #price{
            font-family: 'Poppins', sans-serif;
        }

        .transactionInfo::before{
            content: '';
            position: relative;
            top: 4px;
            width: 10px;
            width: 30px;
            border-bottom: 2px dotted grey;
            flex-grow: 1;
        }

        .actionButtonsContainer{
            position: relative;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
        }
        .actionButtonsContainer button{
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 40px;
            width: 100%;
            border: none;
            outline: none;
        }
        .actionButtonsContainer button#download-btn{
            background-color: #CCB67D;
        }
        .actionButtonsContainer button#back-to-home-btn{
            background-color: #000;
            color: #fff;
        }

        .saveAs {
            display: flex;
            position: absolute;
            top: 0;
            left: 200px;
            gap: 20px;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background-color: #fff;
            box-shadow: 1px 1px 8px rgba(128, 128, 128, 0.411);
            width: 160px;
            padding: 10px;
        }

        .saveAs button {
            width: 100%;
        }

        .saveAs #save-as-JPG {
            background-color: #CCB67D;
        }
    </style>
</head>
<body>
<section>
    <div class="container">
        <div class="successContainer">
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
                    <h1>Booking Successful</h1>
                    <p>Booking has been processed</p>
                </div>

            <div class="transactionBody">
                <span><span class="title">BOOKING ID:</span> <span class="transactionInfo" id="booking-id">${bookingId}</span></span>
                <span><span class="title">BOOKING CODE:</span> <span class="transactionInfo" id="booking-code">${bookingCode}</span></span>
                <span><span class="title">NAME:</span> <span class="transactionInfo" id="full-name">${guestName}</span></span>
                <span class="title">DATE/TIME:</span>
                <span class="transactionInfo" id="date-time">
                    <%= new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm").format(new java.util.Date()) %>
                </span>
                <span><span class="title">ROOM No:</span> <span class="transactionInfo" id="room-no">${roomNumber}</span></span>
                <span><span class="title">ROOM Type:</span> <span class="transactionInfo" id="room-type">${roomType}</span></span>
                <span><span class="title">CHECK IN DATE:</span> <span class="transactionInfo" id="check-in-date">${checkInDate}</span></span>
                <span><span class="title">CHECK OUT DATE:</span> <span class="transactionInfo" id="check-out-date">${checkOutDate}</span></span>
                <span>
                    <span class="title">AMOUNT</span>
                    <span class="transactionInfo">
                        <span class="currencySymbol">₦ <span id="price">${price}</span></span>
                    </span>
                </span>
            </div>
        </div>
        <div class="actionButtonsContainer">
            <button id="download-btn">Download</button>
            <button id="back-to-home-btn" onclick="window.location.href='index.jsp'">Back to Home</button>
            <span class="saveAs">
                    <button id="save-as-JPG">Save as JPG</button>
                    <button id="save-as-PDF">Save as PDF</button>
                </span>
        </div>
    </div>
</section>
<script src="JS/jQueryv3.7.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script>
    $(document).ready(function () {
        // Prevent copying of text
        $(".successContainer").bind("cut copy paste", function (e) {
            e.preventDefault();
        });

        // Hide saveAs initially
        $(".saveAs").hide();

        // Show saveAs when buttonsContainer button is clicked
        $("#download-btn").click(function () {
            $(".saveAs").toggle();
        });

        // Close the dropdown when clicking outside
        $(document).on('click', function(event) {
            if (!$(event.target).closest('.saveAs, #download-btn').length) {
                $('.saveAs').hide();
            }
        });

        // Save as JPG
        $("#save-as-JPG").click(function () {
            html2canvas(document.querySelector(".successContainer")).then(canvas => {
                const link = document.createElement('a');
                link.download = 'hotelBooking.jpg';
                link.href = canvas.toDataURL('image/jpeg');
                link.click();
            });
        });

        // Save as PDF
        $("#save-as-PDF").click(function () {
            html2canvas(document.querySelector(".successContainer")).then(canvas => {
                const imgData = canvas.toDataURL('image/jpeg');
                const pdf = new jspdf.jsPDF('p', 'mm', 'a4');
                const imgWidth = 210; // A4 width in mm
                const imgHeight = (canvas.height * imgWidth) / canvas.width;
                pdf.addImage(imgData, 'JPEG', 0, 0, imgWidth, imgHeight);
                pdf.save('hotelBooking.pdf');
            });
        });
        // Auto-save after 4 seconds
        setTimeout(() => {
            html2canvas(document.querySelector(".successContainer")).then(canvas => {
                const link = document.createElement('a');
                link.download = 'hotelBooking-autoSave.jpg';
                link.href = canvas.toDataURL('image/jpeg');
                link.click();
            });
        }, 4000); // 2000ms = 2 seconds
    });
</script>
</body>
</html>