<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- CODED BY MACHINO11 -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Houstons</title>
    <link rel="icon" href="Images/Svgs/Logo.svg">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Font+Name&display=swap">
    <link rel="stylesheet" href="CSS/index.css">
</head>
<body>
    <!-- Loading Screen -->
    <div class="loadingScreen" id="loading-screen">
        <div class="loader">
        </div>
        <img src="Images/Svgs/load-screen-logo.svg" class="loaderLogo" alt="">
    </div>
    <!-- =============== START OF THE LANDING PAGE ===================== -->
    <section class="landingPage" id="landing-page">
        <!-- Navigation bar -->
        <nav class="navMenu" id="nav-menu">
            <!-- This contains the Logo and Name -->
            <div class="logoContaier">
                <img src="Images/Svgs/Logo.svg" alt=""> <span>Houstons</span>
            </div>
            <!-- This is for the desktop view -->
            <ul class="desktopView">
                <li><a href="#landing-page" class="navLinks smoothScroll">HOME</a></li>
                <li><a href="#accommodation-section" class="navLinks smoothScroll">ACCOMMODATION</a></li>
                <li><a href="#services-section" class="navLinks smoothScroll">SERVICES</a></li>
                <li><a href="#about-us-page" class="navLinks smoothScroll">ABOUT US</a></li>
                <li><a href="#contact-page" class="navLinks smoothScroll">CONTACT</a></li>
            </ul>

            <!-- CTA Button -->
            <a href="availability.jsp" class="buttonStyle3 navCTAButton" id="CTA-button">BOOK NOW</a>

            <!-- This is for the mobile view -->
            <span class="navResponsive">
                <ul>
                    <li><a href="#landing-page">HOME</a></li>
                    <li><a href="">ACCOMMODATION</a></li>
                    <li><a href="">SERVICES</a></li>
                    <li><a href="">ABOUT US</a></li>
                    <li><a href="">CONTACT</a></li>
                </ul>
                
                <!-- CTA Button -->
            </span>
            <!-- Hamburger Menu  -->
            <img src="Images/Svgs/menu.svg" alt="" class="svg menuIcon">
        </nav>

        <!-- Hero Section -->
        <div class="heroSectionContent">
            <!-- Slidable Image and dynamic content -->
            <!-- This is for the what displays when the first image is visible -->
            <img src="Images/landing-page-1.jpg" 
            alt="" 
            class="heroSectionBG heroSectionBG1" 
            data-text-p="Experience the Art of Luxury at" 
            data-text-h1="Houstons"
            data-mini-gallery='[
            {"src": "Images/mini-gallery/Thumbnails/mini-gallery-01.jpg"},
            {"src": "Images/mini-gallery/Thumbnails/mini-gallery-02.jpg"},
            {"src": "Images/mini-gallery/Thumbnails/mini-gallery-03.jpg"}
            ]'
            >

            <!-- This is for the what displays when the second image is visible -->
            <img src="Images/landing-page-2.jpg" 
            alt="" 
            class="heroSectionBG heroSectionBG2" 
            data-text-p="Where Every Moment is a Masterpiece" 
            data-text-h1="Elegant Stays"
            data-mini-gallery='[
            {"src": "Images/mini-gallery/Thumbnails/mini-gallery-04.jpg"},
            {"src": "Images/mini-gallery/Thumbnails/mini-gallery-05.jpg"},
            {"src": "Images/mini-gallery/Thumbnails/mini-gallery-06.jpg"}
            ]'
            >
            
             <!-- This is for the what displays when the last image is visible -->
            <img src="Images/landing-page-3.jpg" 
            alt="" 
            class="heroSectionBG heroSectionBG3" 
            data-text-p="Experience the Ultimate in Personalized Service" 
            data-text-h1="Quality Services"
            data-mini-gallery='[
            {"src": "Images/mini-gallery/Thumbnails/mini-gallery-07.jpg"},
            {"src": "Images/mini-gallery/Thumbnails/mini-gallery-08.jpg"},
            {"src": "Images/mini-gallery/Thumbnails/mini-gallery-09.jpg"}
            ]'
            >

            <!-- Original contents but will be changed dynamically with JS -->
            <div class="firstAnimation pageSliderItem">
                <!-- For the Paragraph Text -->
                <p>Experience the Art of Luxury at</p>
                <!-- For the Header -->
                <h1 class="heroH1Default">Houstons</h1>
                <!-- For the CTA Buttons -->
                <div class="heroSectionCTA">
                    <a href="availability.jsp" class="buttonStyle1 navRespCTAButton" id="">BOOK NOW</a>
                    <a href="availability.jsp" class="buttonStyle1 pageSliderButton pcCTAButton"><span>EXPLORE ROOMS</span></a>
                    <a class="buttonStyle2 pageSliderButton"><span>LEARN MORE...</span></a>
                </div>
                <!-- For the mini Gallery displayed at the buttom right -->
                <div class="miniGallery" id="mini-gallery">
                    <div class="miniGalleryImgContainerBorder">
                        <div class="miniGalleryImgContainer">
                            <img src="Images/mini-gallery/Thumbnails/mini-gallery-01.jpg" class="miniGalImg1" alt="">
                        </div>
                    </div>

                    <div class="miniGalleryImgContainerBorder">
                        <div class="miniGalleryImgContainer">
                            <img src="Images/mini-gallery/mini-gallery-02.jpg" class="miniGalImg2" alt="">
                        </div>
                    </div>

                    <div class="miniGalleryImgContainerBorder">
                        <div class="miniGalleryImgContainer">
                            <img src="Images/mini-gallery/Thumbnails/mini-gallery-03.jpg" class="miniGalImg2" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Slider dots, This is to navigate between images -->
        <ul class="dots">
            <li class="active"></li>
            <li></li>
            <li></li>
        </ul>

        <!-- modal to view the mini gallery -->
        <div class="modal" id="project-modal">
            <span class="close">&times;</span>
            <div class="modal-content">
                <div class="modalTitle"></div>
                <div class="modal-content-images">
                    <div class="modal-images">
                        <img src="" alt="" class="main-image">
                    </div>
                </div>
                <div class="image-thumbnails">
                    <!-- Thumbnails will be generated dynamically -->
                </div>
                <!-- Modal Navigation Buttons -->
                <button class="prev-btn">&lt;</button>
                <button class="next-btn">&gt;</button>
            </div>
        </div>
    </section>
    <!-- =============== END OF THE LANDING PAGE ===================== -->


    <!-- =============== START OF THE ACCOMMODATION PAGE ===================== -->
    <section class="accommodationSection" id="accommodation-section">
        <!-- Accomodation Page Header -->
        <h2 class="accommodationSectionHeader">ACCOMMODATION</h2>
        <!-- Accomodation page paragraph -->
        <p>Explore our Various Rooms</p>

        <!-- Container to house the four accommodations -->
        <div class="accommodationsContainer">
            <!-- Individual Accommodation -->
            <div class="accommodationTypes">
                <!-- Container to house the Individual Accommodation images -->
                <div class="accommodationTypesImgContainer">
                    <img src="Images/Standard-Suite.jpg" alt="">
                </div>
                <!-- Container to house the Individual Accommodation Information -->
                <div class="accommodationInfo">
                    <!-- Accommodation Type Name -->
                    <h2 class="accommodationTypesTitle">Standard Suite</h2>
                    <!-- Accommodation Type Description -->
                    <p class="accommodationTypesContent">
                        Enjoy a relaxing stay in our cozy standard rooms
                    </p>
                    <!-- Accommodation Type Price -->
                    <h2 class="accommodationTypesPrice" id="standard-suite-price">₦ 120,000</h2>
                    <!-- Accommodation Type Button -->
                    <button class="buttonStyle3 accomodationTypesBtn" id="standard-suite-check-btn">
                        CHECK AVAILABILITY
                    </button>
                </div>
            </div>

            <!-- Individual Accommodation -->
            <div class="accommodationTypes">
                <!-- Container to house the Individual Accommodation images -->
                <div class="accommodationTypesImgContainer">
                    <img src="Images/Executive-Suite.jpg" alt="">
                </div>
                <!-- Container to house the Individual Accommodation Information -->
                <div class="accommodationInfo">
                    <!-- Accommodation Type Name -->
                    <h2 class="accommodationTypesTitle">Executive Suite</h2>
                    <!-- Accommodation Type Description -->
                    <p class="accommodationTypesContent">
                        Elevate youe stay with upscale room and amenities
                    </p>
                    <!-- Accommodation Type Price -->
                    <h2 class="accommodationTypesPrice" id="excutive-suite-price">₦ 200,000</h2>
                    <!-- Accommodation Type Button -->
                    <button class="buttonStyle3 accomodationTypesBtn" id="executive-suite-check-btn">
                        CHECK AVAILABILITY
                    </button>
                </div>
            </div>

            <!-- Individual Accommodation -->
            <div class="accommodationTypes">
                <!-- Container to house the Individual Accommodation images -->
                <div class="accommodationTypesImgContainer">
                    <img src="Images/Deluxe-Suite.jpg" alt="">
                </div>
                <!-- Container to house the Individual Accommodation Information -->
                <div class="accommodationInfo">
                    <!-- Accommodation Type Name -->
                    <h2 class="accommodationTypesTitle">Deluxe Suite</h2>
                    <!-- Accommodation Type Description -->
                    <p class="accommodationTypesContent">
                        Unwind in style with spacious suites and luxurious amenities
                    </p>
                    <!-- Accommodation Type Price -->
                    <h2 class="accommodationTypesPrice" id="deluxe-suite-price">₦ 500,000</h2>
                    <!-- Accommodation Type Button -->
                    <button class="buttonStyle3 accomodationTypesBtn" id="deluxe-suite-check-btn">
                        CHECK AVAILABILITY
                    </button>
                </div>
            </div>

            <!-- Individual Accommodation -->
            <div class="accommodationTypes">
                <!-- Container to house the Individual Accommodation images -->
                <div class="accommodationTypesImgContainer">
                    <img src="Images/Family-Suite.jpg" alt="">
                </div>
                <!-- Container to house the Individual Accommodation Information -->
                <div class="accommodationInfo">
                    <!-- Accommodation Type Name -->
                    <h2 class="accommodationTypesTitle">Family Suite</h2>
                    <!-- Accommodation Type Description -->
                    <p class="accommodationTypesContent">
                        Create memories with your loved ones in our family freindly rooms
                    </p>
                    <!-- Accommodation Type Price -->
                    <h2 class="accommodationTypesPrice" id="family-suite-price">₦ 600,000</h2>
                    <!-- Accommodation Type Button -->
                    <button class="buttonStyle3 accomodationTypesBtn" id="family-suite-check-btn">
                        CHECK AVAILABILITY
                    </button>
                </div>
            </div>
        </div>
        <!-- Link to view all rooms -->
        <a href="availability.jsp" class="buttonStyle1 viewAllRoomsBtn"><span>VIEW ALL ROOMS</span></a>
    </section>
    <!-- =============== END OF THE ACCOMMODATION PAGE ===================== -->

    <!-- =============== START OF THE WHY CHOOSE US PAGE ===================== -->
    <section class="whyChooseUsSection" id="why-choose-us-section">
        <!-- Top Star Icon Img -->
        <img src="Images/Svgs/Top-Star-Quality-Icon.svg" alt="" class="topStarQualityIcon">
        <!-- Why Choose US Header -->
        <h2 class="WCUsectionHeader">Why Choose US</h2>
        <div class="sectionThreeTableContainer">
                <div class="sectionThreeTableContainerOuter">
                    <div class="sectionThreeTableContainerInner">
                        <h2 class="WCHtableIndexNO">01</h2>
                        <h2>Luxury Accommodations</h2>
                        <p>Indulge in our lavish rooms and suites, designed to provide the ultimate 
                            comfort and relaxation experience.
                        </p>
                    </div>
                </div>
                <div class="sectionThreeTableContainerOuter">
                    <div class="sectionThreeTableContainerInner">
                        <h2 class="WCHtableIndexNO">02</h2>
                        <h2>Exceptional Service</h2>
                        <p>Experience warm hospitality and impeccable service from our dedicated team, 
                            ensuring a memorable stay.
                        </p>
                    </div>
                </div>
                <div class="sectionThreeTableContainerOuter">
                    <div class="sectionThreeTableContainerInner">
                        <h2 class="WCHtableIndexNO">03</h2>
                        <h2>Prime Location</h2>
                        <p>Conveniently situated near major attractions and business hubs, making it easy to 
                            explore and conduct business.
                        </p>
                    </div>
                </div>
                <div class="sectionThreeTableContainerOuter">
                    <div class="sectionThreeTableContainerInner">
                        <h2 class="WCHtableIndexNO">04</h2>
                        <h2>World-Class Amenities</h2>
                        <p>Enjoy access to top-notch facilities, including fitness centres, spas, and restaurants, 
                            designed to enhance your stay.
                        </p>
                    </div>
                </div>
                <div class="sectionThreeTableContainerOuter">
                    <div class="sectionThreeTableContainerInner">
                        <h2 class="WCHtableIndexNO">05</h2>
                        <h2>Flexible Meeting Spaces</h2>
                        <p>Conveniently situated near major attractions and business hubs, making it easy to 
                            explore and conduct business.
                        </p>
                    </div>
                </div>
                <div class="sectionThreeTableContainerOuter">
                    <div class="sectionThreeTableContainerInner">
                        <h2 class="WCHtableIndexNO">06</h2>
                        <h2>High Quality Facilities</h2>
                        <p>We have high quality facilities made 100% for your fund and comfortable trip 
                            experience or stay in our hotel. Available for booking and reserve.
                        </p>
                    </div>
                </div>
                
                
        </div>
         <div class="doors">
            <span class="door leftDoor">
                <img src="Images/Svgs/Left-Door.svg" alt="">
                <ul class="doorBlinkers leftDoorBlinkers">
                    <li class="doorBlinker"></li>
                    <li class="doorBlinker"></li>
                    <li class="doorBlinker"></li>
                </ul>
            </span>
            <span class="door rightDoor">
                <img src="Images/Svgs/Right-Door.svg" alt="">
                <ul class="doorBlinkers rightDoorBlinkers">
                    <li class="doorBlinker"></li>
                    <li class="doorBlinker"></li>
                    <li class="doorBlinker"></li>
                </ul>
            </span>
         </div>   
    </section>
    <!-- =============== END OF THE WHY CHOOSE US PAGE ===================== -->


    <!-- =============== START OF THE Services PAGE ===================== -->
    <section class="serviceSection" id="services-section">
        <!-- Services page header -->
        <h2 class="servicesSectionHeader">SERVICES</h2>
        <!-- Each services offered container -->
        <div class="servicesOfferedContainer">
            <!-- Individual Services Offered -->
            <div class="servicesOffered hotelServices">
                <div class="SOclickToViewTxt">>>> CLICK TO VIEW</div>
                <!-- Services Icon -->
                <img src="Images/Svgs/hotel-icon.svg" alt="" class="svg servicesIcon">
                <!-- Services Title -->
                <h2>Hotel Services</h2>
                <!-- Services Description -->
                <p>Experience seamless convenience with our range of hotel services</p>
            </div>

            <!-- Individual Services Offered -->
            <div class="servicesOffered foodAndRestaurantServices">
                <div class="SOclickToViewTxt">>>> CLICK TO VIEW</div>
                <!-- Services Icon -->
                <img src="Images/Svgs/food-and-restaurant-icon.svg" alt="" class="svg servicesIcon">
                <!-- Services Title -->
                <h2>Food and Restuarant</h2>
                <!-- Services Description -->
                <p>Savor delicious flavors at our on-site restaurants and bars.</p>
            </div>

            <!-- Individual Services Offered -->
            <div class="servicesOffered wellnessAndFitnessServices">
                <div class="SOclickToViewTxt">>>> CLICK TO VIEW</div>
                <!-- Services Icon -->
                <img src="Images/Svgs/Wellness-and-Fitness-icon.svg" alt="" class="svg servicesIcon">
                <!-- Services Title -->
                <h2>Wellness and Fitness</h2>
                <!-- Services Description -->
                <p>Rejuvenate your body and mind with our wellness programs and facilities.</p>
            </div>

            <!-- Individual Services Offered -->
            <div class="servicesOffered techAndEaseServices">
                <div class="SOclickToViewTxt">>>> CLICK TO VIEW</div>
                <!-- Services Icon -->
                <img src="Images/Svgs/tech-and-ease-icon.svg" alt="" class="svg tech servicesIcon">
                <!-- Services Title -->
                <h2>Tech and Ease</h2>
                <!-- Services Description -->
                <p>Experience seamless convenience with our range of hotel services</p>
            </div>

            <!-- Individual Services Offered -->
            <div class="servicesOffered businessAndEventsServices">
                <div class="SOclickToViewTxt">>>> CLICK TO VIEW</div>
                <!-- Services Icon -->
                <img src="Images/Svgs/business-and-events-icon.svg" alt="" class="svg servicesIcon">
                <!-- Services Title -->
                <h2>Business and Events</h2>
                <!-- Services Description -->
                <p>Host successful business meetings and events in our stylish, modern spaces</p>
            </div>

            <!-- Individual Services Offered -->
            <div class="servicesOffered AccessibilityAndSupportServices">
                <div class="SOclickToViewTxt">>>> CLICK TO VIEW</div>
                <!-- Services Icon -->
                <img src="Images/Svgs/Accessibilty-and-Support-icon.svg" alt="" class="svg servicesIcon">
                <!-- Services Title -->
                <h2>Accessibilty and Support</h2>
                <!-- Services Description -->
                <p>Relax with easy accessibility and dedicated support in our inclusive spaces</p>
            </div>
        </div>

        <!-- Services Modal -->
        <div class="servicesModal" id="services-modal">
            <!-- Services Modal Body -->
            <div class="serviceModalBody">
                <!-- Close button -->
                <button class="servicesModalCloseBtn">&times;</button>
                <!-- Title -->
                <h2 class="servicesModalTitle">Title</h2>
                <!-- Container to house description list and contents -->
                <div class="servicesModalContent">
                    <dl class="servicesModalDescriptionList">
                        <!-- Contents will be added here dynamically -->
                    </dl>
                </div>
            </div>
        </div>
    </section>
    <!-- =============== END OF THE Services PAGE ===================== -->
    
    <!-- =============== START OF THE REVIES PAGE ===================== -->
        <section class="reviewsPage" id="reviewsPage">
            <div class="reviewsPageContent">
                <h3 class="reviewMiniHeader">REVIEWS</h3>
                <h2 class="reviewsHeader">What Our Customers<br> Say about Us</h2>
                <span class="starRating">
                    <!-- Images are added here from the JS dynamically -->
                </span>
                <p class="customerReview">
                    <!-- Reviews are added here from the JS dynamically -->
                </p>
                <div class="clientInfo">
                    <div class="clientImgContainer">
                        <!-- Images are added here from the JS dynamically -->
                        <img src="" alt="" class="clientImg">
                    </div>
                    <div class="clientNameAndType">
                        <!-- Names are added here from the JS dynamically -->
                        <h3 class="ClientName"></h3>
                        <!-- Types are added here from the JS dynamically -->
                        <p class="clientType">Hotel Client</p>
                    </div>
                </div>
                <ul class="reviewPageNavDots">
                    <!-- Dots are added here dynamically based on the number of reviews -->
                </ul>
            </div>
        </section>
    <!-- =============== END OF THE REVIEWS PAGE ===================== -->

    <!-- =============== START OF THE ABOUT US PAGE ===================== -->
        <section class="aboutUsPage" id="about-us-page">
            <!-- About Us Header -->
            <h2 class="aboutUsHeader">ABOUT US</h2>
            <!-- About Us Top Contents -->
            <div class="aboutUsPageTop">
                <!-- Contents in the Left of the About Us -->
                <div class="aboutUsPageTopLeft">
                    <!-- Heading -->
                    <h2 class="aboutUsPageTopLeftHeader">Welcome to <span>Houstons</span></h2>
                    <!-- Container to house the Paragraphs texts -->
                    <div class="aboutUSPageTopLeftContentContainer">
                        <!-- Individual Paragraphs -->
                        <p class="aboutUsPageTopLeftContent">
                            At Houstons, we're dedicated to providing exceptional hospitality and unparalleled comfort. Our story began with a passion for creating unique and memorable experiences for our guests. With a focus on elegance, sophistication, and warmth, we've crafted a hotel that feels like a home away from home. From the moment you step through our doors, you'll be enveloped in an atmosphere of refined luxury, where every detail has been carefully considered to ensure your stay is nothing short of extraordinary.
                        </p>
                        <p class="aboutUsPageTopLeftContent">
                            Our team is comprised of experienced hospitality professionals who share our commitment to excellence. From our concierge team to our culinary experts, every member of our staff is dedicated to ensuring that your stay with us is tailored to your individual needs. We take pride in our attention to detail and our ability to anticipate your every requirement. Whether you're traveling for business or pleasure, we'll work tirelessly to ensure that your stay with us is productive, relaxing, and memorable. Our staff are trained to provide exceptional service, and we're confident that you'll feel at home with us.
                        </p>
                        <p class="aboutUsPageTopLeftContent">
                            At Houstons, we believe that luxury is not just about opulence and extravagance, but about the little things that make a big difference. From our plush linens and luxurious amenities to our carefully curated art collection and beautifully landscaped gardens, every aspect of our hotel has been designed to provide a tranquil and indulgent retreat from the stresses of everyday life. Our hotel is a haven of peace and serenity, where you can unwind and recharge in style. We're committed to sustainability and community involvement, and we strive to make a positive impact on the world around us. 
                        </p>
                        <p class="aboutUsPageTopLeftContent">
                            Whether you're traveling for business or pleasure, we invite you to experience the Houstons difference. Join us for a stay that will leave you feeling refreshed, renewed, and inspired. We look forward to welcoming you to our hotel and to sharing our passion for hospitality with you. Our goal is to create a lifelong relationship with our guests, and we're committed to exceeding your expectations in every way. We can't wait to welcome you to the Houstons family!
                        </p>
                    </div>
                    <!-- Learn More Button -->
                    <a href="" class="buttonStyle2 aboutUsPageTopLeftButton">LEARN MORE....</a>
                </div>
                <!-- Content on the Top Right -->
                <div class="aboutUsPageTopRight">
                    <!-- Containter to house two images each to prevent flex wrapping all when the
                     window is resized. So now with only two container inside the top right, i have
                     set the flex wrap of the aboutUsPageTopRight to wrap to it only wraps the
                     aboutUsPageTopRightTopImgContainer and the aboutUsPageTopRightBottomImgContainer 
                     without wrapping the images in them-->
                    <div class="aboutUsPageTopRightTopImgContainer">
                        <!-- Container to house the images -->
                        <div class="aboutUsPageTopRightImgContainer">
                            <img src="Images/about-us-1.jpg" alt="">
                        </div>
                        <!-- Container to house the images -->
                        <div class="aboutUsPageTopRightImgContainer">
                            <img src="Images/about-us-2.jpg" alt="">
                        </div>
                    </div>
                    <!-- Container to house the two images for the bottom to prevent flex wrapping all
                     when the window is resized -->
                    <div class="aboutUsPageTopRightBottomImgContainer">
                        <!-- Container to house the images -->
                        <div class="aboutUsPageTopRightImgContainer">
                            <img src="Images/about-us-3.jpg" alt="">
                        </div>
                        <div class="aboutUsPageTopRightImgContainer">
                            <img src="Images/about-us-4.jpg" alt="">
                        </div>
                    </div>
                   
                </div>
            </div>
            <!-- Bottom Section of the about us page -->
            <div class="aboutUsPageBottom">
                <!-- Individual Contents Container in the Bottom -->
                <div class="aboutUsPageBottomContentContainer">
                    <!-- Contents of the container -->
                    <h2 class="doubleDigit count aboutUsPageBottomContentTitle">10</h2>
                    <p class="aboutUsPageBottomContent">Years of Excellence</p>
                </div>
                <!-- Individual Contents Container in the Bottom -->
                <div class="aboutUsPageBottomContentContainer">
                    <!-- Contents of the container -->
                    <h2 class="aboutUsPageBottomContentTitle">
                        <!-- Span to separate the contents so the "/" is not removed
                         when adding the count effect in the JS -->
                        <span class="doubleDigit count">24</span>
                        <span class="aboutUsPageBottomContentOther">/</span>
                        <span class="singleDigit count">7</span>
                    </h2>
                    <p class="aboutUsPageBottomContent">Dedicated Service</p>
                </div>
                <!-- Individual Contents Container in the Bottom -->
                <div class="aboutUsPageBottomContentContainer">
                    <!-- Contents of the container -->
                    <h2 class="tripleDigit aboutUsPageBottomContentTitle count">100</h2>
                    <p class="aboutUsPageBottomContent">Luxurious Rooms</p>
                </div>
                <!-- Individual Contents Container in the Bottom -->
                <div class="aboutUsPageBottomContentContainer">
                    <!-- Contents of the container -->
                    <h2 class="quadrupleDigit aboutUsPageBottomContentTitle">
                         <!-- Span to separate the contents so the "+" is not removed
                         when adding the count effect in the JS -->
                        <span class="quadrupleDigit count">9000</span>
                        <span class="aboutUsPageBottomContentOther">+</span>
                    </h2>
                    <p class="aboutUsPageBottomContent">Guest Satisfied</p>
                </div>
            </div>
        </section>
    <!-- =============== END OF THE ABOUT US PAGE ===================== -->

    <!-- =============== START OF THE CONTACT PAGE ===================== -->
    <section class="contactPage" id="contact-page">
        <h2 class="contactHeader">CONTACT</h2>
        <p class="contactHeaderContent">HOTEL RESERVATION</p>
        <h2 class="contactExperienceUs">Experience the Best of Our Hotel</h2>
        <h2 class="contactCallUsNow">CALL US NOW</h2>
        <h2 class="contactPhoneNo">+234 81-000-0000</h2>
    </section>
    <!-- =============== END OF THE CONTACT PAGE ===================== -->


    <!-- =============== START OF THE LOCATION PAGE ===================== -->
    <section class="locationPage" id="location-page">
        <!-- Location Header -->
        <h2 class="locationPageHeader">LOCATION</h2>
        <!-- Form to search user location -->
        <form action="" class="locationForm">
            <!-- Get Directions Text -->
            <p>GET DIRECTIONS</p>
            <!-- Input for the user to search his location -->
            <input type="text" class="searchLocation" placeholder="Please enter your current location">
            <!-- Destination location (static) -->
            <input type="hidden" class="destination-location" value="6.5244, 3.3792">
            <!-- Location Distance from the user -->
            <div class="locationInfoContainer">
                <h2 class="locationDistance">1.6km</h2>
                <div class="locationArea">From <span class="CurrentLocation"></span>Current Location</div>
            </div>
        </form>
        <!-- Google Maps form -->
        <div class="googleMapsContainer" id="map">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d8070639.283284887!2d3.377697306533485!3d8.995886348042315!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x104e0baf7da48d0d%3A0x99a8fe4168c50bc8!2sNigeria!5e0!3m2!1sen!2sng!4v1732958614511!5m2!1sen!2sng" width="2000" height="500" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>

        <!-- Prompt to ask to allow browser to access the users location -->
        <div class="mapPrompt">
            <h2>Allow Houstons to Access Your current Location</h2>
            <div class="mapPromptResponse">
                <button class="mapUserResponseBtn" id="mapUserResponseNoBtn">No</button>
                <button class="mapUserResponseBtn" id="mapUserResponseYesBtn">Yes</button>
            </div>
        </div>
    </section>

    <!-- Footer Here-->
    <footer>
        <!-- Content in the top side (black part) the footer -->
        <div class="footerTop">
            <!-- First one for brand name and address -->
            <div class="footerTopContentContainer">
                <h2 class="footerTopHeader brandName">Houstons</h2>
                <p class="footerTopContent">3 OPP. OLD OSWALD RD, ELEKA PORT-HARCOUT, NIGERIA </p>
            </div>
            <!-- Second one for location weather -->
            <div class="footerTopContentContainer">
                <h2 class="footerTopHeader">Current Weather</h2>
                <p class="footerTopContent">ELEKA PORT-HARCOUT, NIGERIA </p>
                <div class="weather">
                    <img src="Images/Svgs/sunny-weather-icon.svg" alt="" class="svg weatherIcon">
                    <p class="weatherTemp">17</p>
                    <p class="weatherCelsius">℃</p>
                    <p class="weatherFarenhiet">℉</p>
                </div>
            </div>
            <!-- Third one for connecting via social media -->
            <div class="footerTopContentContainer">
                <h2 class="footerTopHeader">Connect With US</h2>
                <p class="footerTopContent">SOCIAL MEDIA ACCOUNTS</p>
                <div class="footerSocialsIconContainer">
                    <a href="" class="footerSocialIconLink">
                        <img src="Images/Svgs/facebook-icon.svg" alt="" class="svg footerSocialsIcon">
                    </a> 
                    <a href="" class="footerSocialIconLink">
                        <img src="Images/Svgs/instagram-icon.svg" alt="" class="svg footerSocialsIcon">
                    </a>
                    <a href="" class="footerSocialIconLink">
                        <img src="Images/Svgs/twitter-icon.svg" alt="" class="svg footerSocialsIcon">
                    </a> 
                    <a href="" class="footerSocialIconLink">
                        <img src="Images/Svgs/gmail-icon.svg" alt="" class="svg footerSocialsIcon">
                    </a> 
                </div>
            </div>
            <!-- Last one for contact info -->
            <div class="footerTopContentContainer footerContactUs">
                <h2 class="footerTopHeader">Contact Us</h2>
                <p class="footerTopContent">+234-810-000-0000</p>
                <p class="footerTopContent">+234-901-101-0111</p>
                <a href="" class="footerTopContent">support@TheHoustons.com</a>
            </div>
        </div>
        <!--  Bottom part of the footer (Grey Part)-->
        <div class="footerBottom">
            <!-- Bottom Top for footer links -->
            <div class="footerBottomTop">
                <a href="">About Us</a>
                <a href="">Terms of Service</a>
                <a href="">Privacy Policy</a>
                <a href="cancel-booking.jsp">Cancel Booking</a>
                <a href="">FAQs</a>
            </div>
            <!-- Bottom end for copyright items -->
            <div class="footerBottomEnd">
                <p class="Copyright">©2025 Novar Link. All Rights Reserved</p>
<%--                <p class="poweredBy">Powered by <span> NOVAR</span></p>--%>
            </div>
        </div>
    </footer>

    <!-- =============== END OF THE LOCATION PAGE ===================== -->

    <script src="JS/jQueryv3.7.1.js"></script>
    <script src="JS/Index.js"></script>
    <script src="JS/embed-svg.js"></script>
    <script>
        document.getElementById("standard-suite-check-btn").addEventListener("click", function() {
            window.location.href = "availability.jsp?room_type=Standard+Suite"; // ✅ Fixed
        });
        document.getElementById("executive-suite-check-btn").addEventListener("click", function() {
            window.location.href = "availability.jsp?room_type=Executive+Suite";
        });
        document.getElementById("deluxe-suite-check-btn").addEventListener("click", function() {
            window.location.href = "availability.jsp?room_type=Deluxe+Suite";
        });
        document.getElementById("family-suite-check-btn").addEventListener("click", function() {
            window.location.href = "availability.jsp?room_type=Family+Suite";
        });
    </script>
</body>
</html>