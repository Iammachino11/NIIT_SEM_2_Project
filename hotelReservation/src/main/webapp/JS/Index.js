$(document).ready(function() {
    let isLoading = false;

    // Show loading screen with scrollbar control
    function showLoading() {
        if (!isLoading) {
            isLoading = true;
            $('body').addClass('loading-active');
            $('#loading-screen').fadeIn(300);
        }
    }

    // Hide loading screen and restore scrollbar
    function hideLoading() {
        if (isLoading) {
            isLoading = false;
            $('#loading-screen').fadeOut(300, function() {
                $('body').removeClass('loading-active');
            });
        }
    }

    // Initial page load handling
    $(document).ready(function() {
        // Show loader immediately
        showLoading();

        // Hide loader when DOM is ready (not waiting for images)
        $(window).on('load', function() {
            // Add slight delay for better visual transition
            setTimeout(hideLoading, 300);
        });

        // Fallback in case load event doesn't fire
        setTimeout(hideLoading, 5000);
    });

    // Enhanced link handling
    $(document).on('click', 'a', function(e) {
        const href = $(this).attr('href');
        const isAnchor = href && href.startsWith('#');
        const isExternal = href && !href.startsWith(window.location.origin);

        if (!isAnchor && !isExternal && href) {
            e.preventDefault();
            showLoading();

            // Allow time for loading screen to appear
            setTimeout(() => {
                window.location.href = href;
            }, 350);
        }
    });

    // Prevent FOUC (Flash of Unstyled Content)
    document.documentElement.style.visibility = 'hidden';
    $(document).ready(function() {
        document.documentElement.style.visibility = 'visible';
    });

  // Functionlity to give the nav a bg color when the page is scrolled
    const navMenu = $("#nav-menu");
    const updateNavbarBackground = () => {
        const scrollY = window.scrollY;

        if (scrollY > 50 && scrollY < 150) {
            const opacity = (scrollY - 50) / 50;
            navMenu.css("background-color", `rgba(0, 0, 0, ${opacity})`);
            navMenu.css("box-shadow", `1px 1px 10px rgba(0, 0, 0, 0)`);
        } else if (scrollY >= 150) {
            navMenu.css("background-color", `rgba(0, 0, 0, 1`);
            navMenu.css("box-shadow", `1px 1px 10px rgba(0, 0, 0, 0.5})`);
            navHyperLinks.css("color", "rgb(0, 0, 0)");
        } else {
            navMenu.css("background-color", `transparent`);
            navMenu.css("box-shadow", `1px 1px 10px rgba(0, 0, 0, 0})`);
        }
    };

    // Initial call to set the navbar background on page load
    updateNavbarBackground();

    // Update background color on scroll
    document.addEventListener("scroll", updateNavbarBackground);

    // SmoothScrooling effect
    $(document).ready(function() {
      $('.smoothScroll').on('click', function(event) {
        event.preventDefault();
        var target = $(this.hash);
        $('html, body').animate({
          scrollTop: target.offset().top
        }, 500);
      });
    });

    // 
    const sections = document.querySelectorAll("section"); // All sections
    const navLinks = document.querySelectorAll(".desktopView a"); // All navbar links

    // Function to update active link
    const updateActiveLink = () => {
        let currentSection = null;

        sections.forEach((section) => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.offsetHeight;

            if (window.scrollY >= sectionTop - 100 && window.scrollY < sectionTop + sectionHeight - 100) {
                currentSection = section.getAttribute("id");
            }
        });

        navLinks.forEach((link) => {
            if (link.getAttribute("href").includes(currentSection)) {
                link.classList.add("navActive"); // Add 'active' class
            } else {
                link.classList.remove("navActive"); // Remove 'active' class
            }
        });
    };

    // Scroll event to update active link
    document.addEventListener("scroll", updateActiveLink);

    // Initial check
    updateActiveLink();


    // Variables for menu toggle functionality
    var menuIcon = $('.menuIcon');
    var navResponsive = $('.navResponsive');
    var closeButton = '<p class="menuIcon">✕</p>'; // Defines the close button HTML element

    // Clone the original menu icon for later use
    var originalMenuIcon = menuIcon.clone();

    // Function to toggle the visibility of the responsive navigation menu
    function toggleNav() {
        navResponsive.toggleClass('navMenuactive'); // Toggles the class to show/hide the menu
        // Replace the menu icon with the close button
        if (navResponsive.hasClass('navMenuactive')) {
            menuIcon.replaceWith(closeButton);
            // Add click event to close button
            $('.menuIcon').click(function() {
                toggleNav();
            });
        } else {
            // Replace close button with the original menu icon
            $('.menuIcon').replaceWith(originalMenuIcon);
            menuIcon = $('.menuIcon'); // Rebind the menu icon variable
            menuIcon.click(function() {
                toggleNav();
            });
        }
    }

    // Add click event to the initial menu icon
    menuIcon.click(function() {
        toggleNav();
    });
    
    // Fade animation functionality for the hero section images
    var images = $('.heroSectionBG');  // Selects all hero section images
    var currentIndex = 0; // To Track the current image index
    var dots = $('.dots li'); // Selects all slider dots
    var timer; // Timer for automatic image switching

    // Initially hide all images except the first one
    images.hide();
    images.eq(currentIndex).fadeIn(); // Fade in the first image

    // Store existing HTML for mini-gallery and buttons for reuse
    var miniGalleryHtml = $('#mini-gallery').html();
    var buttonsHtml = $('.heroSectionCTA').html();

    // Function to switch images in the slider
    function switchImage(index) {
        // If index is provided, jump to that image
        if (index !== undefined) {
            currentIndex = index;
        } else {
            // if not, cycle through the images
            currentIndex = (currentIndex + 1) % images.length;  // Cycle through images
        }
    
        // Fade out all other images and fade in the current one
        images.eq(currentIndex).siblings().fadeOut();
        images.eq(currentIndex).fadeIn();
        $('.pageSliderItem').fadeOut(function() {
            // Update text content for the current image
            var textP = images.eq(currentIndex).attr('data-text-p');
            var textH1 = images.eq(currentIndex).attr('data-text-h1');
            var miniGalleryData = JSON.parse(images.eq(currentIndex).attr('data-mini-gallery'));

            // Update HTML content only for the text and buttons
            var htmlContent = '';
            if (currentIndex > 0) {
                htmlContent += '<h1 class="heroH1Modified">' + textH1 + '</h1>';
                htmlContent += '<p>' + textP + '</p>';
            } else {
                htmlContent += '<p>' + textP + '</p>';
                htmlContent += '<h1 class="heroH1Default">' + textH1 + '</h1>';
            }
           // Build mini gallery HTML and assign specific classes
          htmlContent += '<div class="miniGallery">';
          $.each(miniGalleryData, function (i, image) {
              var miniGalClass = i === 0 ? 'miniGalImg1' : i === 1 ? 'miniGalImg2' : 'miniGalImg3';
              htmlContent += '<div class="miniGalleryImgContainerBorder">';
              htmlContent += '<div class="miniGalleryImgContainer">';
              htmlContent += '<img src="' + image.src + '" class="' + miniGalClass + '" alt="">';
              htmlContent += '</div>';
              htmlContent += '</div>';
          });
          htmlContent += '</div>';

          // Add buttons back to the HTML content
          htmlContent += '<div class="heroSectionCTA">' + buttonsHtml + '</div>';
    
            // Only update the text and buttons content
            $('.pageSliderItem').html(htmlContent);
            $('.pageSliderItem').fadeIn();
    
            // Update dots
            dots.removeClass('active');
            dots.eq(currentIndex).addClass('active');
        });
    }
    

    // Function to start the automatic image slider timer
    function startTimer() {
        timer = setInterval(function() {
            switchImage();
        }, 15000);// Switch every 15 seconds
    }

    // Start the timer initially
    startTimer();

    // Add click event to dots
    dots.click(function() {
        var newIndex = dots.index(this); // Get the index of the clicked dot
        if (newIndex === currentIndex) {
            return; // Do nothing if the clicked dot is the same as the current index
        }

        clearInterval(timer); // Clear the current timer
        switchImage(newIndex); // Switch to the selected image
        startTimer(); // Start the timer again

    });

    // Project modal functionality to display the mini gallery images


    // Object containing image data for different projects.
    // Each project is represented by an ID (e.g., 1) and contains an array of image objects
    const projectImages = {
        1: [
            { thumbnail: 'Images/mini-gallery/Thumbnails/mini-gallery-01.jpg',
            original: 'Images/mini-gallery/mini-gallery-01.jpg',
            title: 'Hotel Bar'
            },
            
            { thumbnail: 'Images/mini-gallery/Thumbnails/mini-gallery-02.jpg',
            original: 'Images/mini-gallery/mini-gallery-02.jpg',
            title: 'Hotel Lounge' 
            },

            { thumbnail: 'Images/mini-gallery/Thumbnails/mini-gallery-03.jpg',
            original: 'Images/mini-gallery/mini-gallery-03.jpg',
            title: 'Pool'
            },

            { thumbnail: 'Images/mini-gallery/Thumbnails/mini-gallery-04.jpg',
            original: 'Images/mini-gallery/mini-gallery-04.jpg',
            title: 'Kitchen'
            },

            { thumbnail: 'Images/mini-gallery/Thumbnails/mini-gallery-05.jpg',
            original: 'Images/mini-gallery/mini-gallery-05.jpg',
            title: 'Tennis Court'
            },

            { thumbnail: 'Images/mini-gallery/Thumbnails/mini-gallery-06.jpg',
                original: 'Images/mini-gallery/mini-gallery-06.jpg',
                title: 'Reception'
            },

            { thumbnail: 'Images/mini-gallery/Thumbnails/mini-gallery-07.jpg',
                original: 'Images/mini-gallery/mini-gallery-07.jpg',
                title: 'Gym'
            },

            { thumbnail: 'Images/mini-gallery/Thumbnails/mini-gallery-08.jpg',
                original: 'Images/mini-gallery/mini-gallery-08.jpg',
                title: 'Entrance'
            },
          { thumbnail: 'Images/mini-gallery/Thumbnails/mini-gallery-09.jpg',
            original: 'Images/mini-gallery/mini-gallery-09.jpg',
            title: 'Game Room'
        },
        ],
      };

      // Initialize variables to keep track of the current project ID and image index
      let currentProjectId = null;
      let currentImageIndex = 0;
  
      // Generates HTML thumbnails for the given images and appends them to the container.
      function generateThumbnails(images) {
        // console.log('Images:', images);
        const thumbnailContainer = $('.image-thumbnails');   // Get the thumbnail container element
        thumbnailContainer.empty();   // Empty the thumbnail container to remove any existing thumbnails
      
        // Iterate through the images array and create a thumbnail for each image
        images.forEach((image, index) => {
          //   console.log('Image:', image);
          // Create a new thumbnail element
          const thumbnail = $('<img>').attr('src', image.thumbnail).attr('data-index', index);
          // Add an 'active' class to the thumbnail if it's the current image
          if (index === currentImageIndex) {
            thumbnail.addClass('active');
          }

          // Attach a click event handler to the thumbnail
          thumbnail.on('click', function() {
            // Update the current image index and title
            currentImageIndex = parseInt($(this).attr('data-index'));
            const imageTitle = images[currentImageIndex].title;

            // Update the main image and title
            updateMainImage(images[currentImageIndex].original, imageTitle);

            // Regenerate the thumbnails
            generateThumbnails(images);
          });

          // Append the thumbnail to the thumbnail container
          thumbnailContainer.append(thumbnail);
        });
      }
  
      // Open modal when the mini-gallery is clicked
      $('.pageSliderItem').on('click', '.miniGalleryImgContainerBorder', function() {
          currentProjectId = 1;   // Set the current project ID to 1 (default)
          // Get the images array for the current project
          const images = projectImages[currentProjectId];

          // Initialize the start index based on the current hero section background
          let startIndex = 0; 
        
          // Check which .heroSectionBG is currently visible to prevent displaying the same image over again
          if ($('.heroSectionBG2').is(':visible')) {
            startIndex = 3; // Start from the fourth image
          } else if ($('.heroSectionBG3').is(':visible')) {
            startIndex = 6; // Start from the seventh image
          }
          
          // Calculate the current image index based on the clicked item's index and start index
          const currentIndex = $(this).index() + startIndex;

          // Update the current image index, title, and main image
          if (images) {
            currentImageIndex = currentIndex;
            const imageUrl = images[currentImageIndex].original;
            const imageTitle = images[currentImageIndex].title;
            updateMainImage(imageUrl, imageTitle);
            generateThumbnails(images)
            $('#project-modal').fadeIn();
          }
        });

        // Function to update the main image and title
        function updateMainImage(src, title) {
          // Check if the image source is not empty
          if (src) {
            console.log('Updating main image with source:', src); // Log the updated image source
            $('.main-image').attr('src', src); // Update the main image source
            $('.modalTitle').text(title); // Update the modal title
          } else {
            console.error('Image source is empty'); // Log an error if the image source is empty
          }
        }

        // Event handler for closing the project modal
        $('.close').on('click', function() {
          $('#project-modal').fadeOut();
        });
  
        // Event handlers for navigation buttons
        $('.prev-btn').on('click', function() {
          // Get the images array for the current project
          const images = projectImages[currentProjectId];

          // Check if the images array is not empty
          if (images) {
            // Update the current image index to the previous image
            currentImageIndex = (currentImageIndex - 1 + images.length) % images.length;
            // Update the main image and title
            const imageUrl = images[currentImageIndex].original;
            const imageTitle = images[currentImageIndex].title;
            updateMainImage(imageUrl, imageTitle);
            generateThumbnails(images);
          }
        });

        $('.next-btn').on('click', function() {
          // Get the images array for the current project
          const images = projectImages[currentProjectId];
          // Check if the images array is not empty
          if (images) {
            // Update the current image index to the next image
            currentImageIndex = (currentImageIndex + 1) % images.length;
            // Update the main image and title
            const imageUrl = images[currentImageIndex].original;
            const imageTitle = images[currentImageIndex].title;
            updateMainImage(imageUrl, imageTitle);
            generateThumbnails(images);
          }
        });

      // Event handler for keyboard navigation to use keyboard left and right arrow keys to navigate
      $(document).on('keydown', function(e) {
        // Check if the project modal is visible
        if ($('#project-modal').is(':visible')) {
          // Get the images array for the current project
          const images = projectImages[currentProjectId];
          // Check if the images array is not empty
          if (images) {
            // Handle left arrow key press
            if (e.key === 'ArrowLeft') {
              // Update the current image index to the previous image
              currentImageIndex = (currentImageIndex - 1 + images.length) % images.length;
              // Update the main image and title
              const imageUrl = images[currentImageIndex].original;
              const imageTitle = images[currentImageIndex].title;
              updateMainImage(imageUrl, imageTitle);
              generateThumbnails(images);
            } 
            // Handle right arrow key press
            else if (e.key === 'ArrowRight') {
              // Update the current image index to the next image
              currentImageIndex = (currentImageIndex + 1) % images.length;

              // Update the main image and title
              const imageUrl = images[currentImageIndex].original;
              const imageTitle = images[currentImageIndex].title;
              updateMainImage(imageUrl, imageTitle);
              generateThumbnails(images);
            }
          }
        }
      });


      // ============= START FUNCTIONALITY FOR THE CODE FOR THE ACCOMMODATION SECTION ==================
      // Create an Intersection Observer
      const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                // Trigger animations for child elements when accommodationsContainer is visible
                $('.accommodationTypes').css('animation-play-state', 'running');
                $('.viewAllRoomsBtn').css('animation-play-state', 'running');
                observer.unobserve(entry.target); // Stop observing the container
            }
        });
      });

      // Observe the accommodationsContainer
      const container = $('.accommodationsContainer');
      container.css({
          'animation-play-state': 'paused', // Pause animations initially
      });
      $('.accommodationTypes, .viewAllRoomsBtn').css({
          'animation-play-state': 'paused',
          'opacity': 0, // Ensure elements are initially hidden
      });
      observer.observe(container[0]); // Observe the container element
// ============= END FUNCTIONALITY FOR THE CODE FOR THE ACCOMMODATION SECTION ==================


// ============= START FUNCTIONALITY FOR THE CODE FOR THE WHY CHOOSE US SECTION ==================
    // Get the elements
    const sec3Container = document.querySelector('.sectionThreeTableContainer');
    const sec3Doors = document.querySelector('.doors');
    const sec3LeftDoor = document.querySelector('.leftDoor');
    const sec3RightDoor = document.querySelector('.rightDoor');
    const sec3WhyChooseUsSection = document.querySelector('.whyChooseUsSection');
    const sectionThreeTableContainerOuters = document.querySelectorAll('.sectionThreeTableContainerOuter');
    const doorBlinkers = document.querySelectorAll('.doorBlinker');

    
    // Create a sec3 IntersectionObserver instance
    const sec3Observer = new IntersectionObserver((sec3Entries) => {
      if (sec3Entries[0].isIntersecting) {
        // Play the animations when the container is visible
        sec3Container.classList.add('visible');
        sec3LeftDoor.classList.add('visible');
        sec3RightDoor.classList.add('visible');
        sec3Doors.classList.add('visible');
        sec3WhyChooseUsSection.classList.add('animate')

         // Add the isDoorOpened class to each door blinker
        doorBlinkers.forEach((blinker) => {
          blinker.classList.add('isDoorOpened');
        });
        
        
        
        // Wait for the doors animation to finish
        setTimeout(() => {
          // Hide the doors
          sec3Doors.style.visibility = 'hidden';
          sec3Doors.classList.remove('visible');
        }, 1000); // Adjust the timeout according to your animation duration
      }
    }, {
      threshold: 0.5, // Adjust the threshold value according to your needs
    });
    
    // Create a separate IntersectionObserver instance for responsive animation
    const responsiveObserver = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('resVisible');
        }
      });
    }, {
      threshold: 0.5, // Adjust the threshold value according to your needs
    });
    
    // Observe each sectionThreeTableContainerOuter for responsive animation
    sectionThreeTableContainerOuters.forEach((sectionThreeTableContainerOuter) => {
      responsiveObserver.observe(sectionThreeTableContainerOuter);
    });
    
    // Observe the container
    sec3Observer.observe(sec3Container);
// ============= END FUNCTIONALITY FOR THE CODE FOR THE WHY CHOOSE US SECTION ==================


// ============= START FUNCTIONALITY FOR THE CODE FOR THE SERVICES SECTION ==================
function toRoman(num) {
  const romanNumerals = [
      { value: 1000, numeral: 'M' },
      { value: 900, numeral: 'CM' },
      { value: 500, numeral: 'D' },
      { value: 400, numeral: 'CD' },
      { value: 100, numeral: 'C' },
      { value: 90, numeral: 'XC' },
      { value: 50, numeral: 'L' },
      { value: 40, numeral: 'XL' },
      { value: 10, numeral: 'X' },
      { value: 9, numeral: 'IX' },
      { value: 5, numeral: 'V' },
      { value: 4, numeral: 'IV' },
      { value: 1, numeral: 'I' },
  ];

  let result = '';
  for (const { value, numeral } of romanNumerals) {
      while (num >= value) {
          result += numeral;
          num -= value;
      }
  }
  return result;
}


const serviceData = {
  hotelServices: {
      title: "Hotel Services",
      description: [
          { term: "Room Service:", detail: "Enjoy a delicious meal in the comfort of your own room, available from 6am to 11pm." },
          { term: "House-Keeping", detail: "Daily cleaning services with flexible schedules." },
          { term: "Laundry and Dry Cleaning", detail: "Let us take care of your laundry needs, with same day-service available for an additional fee" },
          { term: "Conciege Services", detail: "Our friendly concierge team is here to assist with everything from tour bookings to restaurant reservations" },
          {term: "Tour and Travel Desk", detail: "Plan your dream trip with our expert tour and travel desk team" }
      ]
  },
  foodAndRestaurantServices: {
      title: "Food and Restaurant",
      description: [
          { term: "Fine Dining", detail: "Savor international cuisine at our on-site restaurant, open for breakfast, lunch, and dinner." },
          { term: "Bar", detail: "Unwind with a cocktail or two at our stylish bar, featuring live music and happy hour specials."},
          { term: "Room Services", detail: "Enjoy a romantic dinner in the comfort of your own room, available from 6am to 11pm."},
          { term: "Catering Services", detail: "Let us take care of your event catering needs, with customized menus and exceptional service."}
      ]
  },
  wellnessAndFitnessServices: {
      title: "Wellness and Fitness",
      description: [
          { term: "Gym", detail: "Stay active on the go with our state-of-the-art fitness center, open 24/7." },
          { term: "Spa", detail: "Rejuvenate your body and mind with our range of spa treatments, including massages and facials." },
          { term: "Yoga and Meditation", detail: "Find your inner peace with our yoga and meditation classes, available daily." },
          { term: "Pool", detail: "Relax and unwind with a dip in our sparkling indoor and outdoor pool." }
      ]
  },
  techAndEaseServices: {
      title: "Tech and Ease",
      description: [
          { term: "Wi-Fi", detail: "High-speed internet available throughout the property." },
          { term: "Smart Rooms", detail: "Control room settings with just a touch." }
      ]
  },
  businessAndEventsServices: {
      title: "Business and Events",
      description: [
          { term: "Conference Rooms", detail: "Host professional meetings in our fully equipped spaces." },
          { term: "Event Planning", detail: "Dedicated support and halls for planning your events." },
          { term: "Secretarial Services", detail: "Let us take care of your administrative needs, with secretarial services available upon request." }
      ]
  },
  AccessibilityAndSupportServices: {
      title: "Accessibility and Support",
      description: [
          { term: "Wheelchair Access", detail: "Easily accessible spaces for all guests." },
          { term: "24/7 Support", detail: "Round-the-clock assistance for your needs." }
      ]
  }
};


  // Function to handle servicesOffered click
  $('.servicesOffered').on('click', function () {
    // Fade in the modal
    $('#services-modal').fadeIn();
    $('#services-modal').css('display', 'flex');

    // Get the class name of the clicked element
    const serviceClass = $(this).attr('class').split(' ')[1]; // Assumes the second class is unique

    // Retrieve the corresponding data from the JavaScript object
    const serviceInfo = serviceData[serviceClass];

    // Populate the modal title
    $('.servicesModalTitle').text(serviceInfo.title);

    // Clear the previous list and populate the new one
    const descriptionList = $('.servicesModalDescriptionList');
    descriptionList.empty(); // Clear existing content

    // Add the dt and dd elements with Roman numerals
    serviceInfo.description.forEach((item, index) => {
        const romanNumeral = toRoman(index + 1); // Convert index to Roman numeral
        descriptionList.append(`<dt>${romanNumeral}. ${item.term}</dt>`); // Add Roman numeral
        descriptionList.append(`<dd>${item.detail}</dd>`);
    });
});

// Function to handle modal close button click
$('.servicesModalCloseBtn').on('click', function () {
    // Fade out the modal
    $('#services-modal').fadeOut();
});

// Services Page animations
  // Select all the .servicesOffered elements
  const $servicesOfferedElements = $(".servicesOffered");

  // Function to check if an element is in the viewport
  function servicesPageIsInViewport($element) {
      const elementTop = $element.offset().top;
      const elementBottom = elementTop + $element.outerHeight();

      const viewportTop = $(window).scrollTop();
      const viewportBottom = viewportTop + $(window).height();

      return elementBottom > viewportTop && elementTop < viewportBottom;
  }

  // Function to handle animations
  function servicesPageHandleAnimations() {
      $servicesOfferedElements.each(function () {
          const $this = $(this);
          if (servicesPageIsInViewport($this) && !$this.hasClass("inView")) {
              $this.addClass("inView");
          }
      });
  }

  // Run the handler on scroll and on page load
  $(window).on("scroll resize", servicesPageHandleAnimations);
  servicesPageHandleAnimations(); // Initial check when the page loads

// ============= END FUNCTIONALITY FOR THE CODE FOR THE SERVICES SECTION ==================

// ============= START FUNCTIONALITY FOR THE REVIEW SECTION ==================
  const $reviewPageContent = $(".reviewsPageContent");
  const $navDotsContainer = $(".reviewPageNavDots");

  // Sample reviews data
  const reviewsData = [
      {
          starRating: 5,
          customerReview: "“From the moment I arrived, I felt like I was treated like royalty. The room was stunning, with a beautiful view and the most comfortable bed I've ever slept in. The staff were so friendly and helpful, and the food was incredible. I'll never forget my stay here.”",
          clientImg: "Images/client-face-1.jpg",
          clientName: "Jennifer Denvers",
          clientType: "Hotel Client"
      },
      {
          starRating: 5,
          customerReview: "“The staff were super friendly and helpful, and the room was clean and comfy. I loved the breakfast buffet - there was something for everyone. The hotel's location was also perfect for exploring the city. I'd definitely stay here again”",
          clientImg: "Images/Svgs/no-profile-pic-icon.svg",
          clientName: "John Doe",
          clientType: "Resort Client"
      },
      {
          starRating: 4,
          customerReview: "“Good service overall, but room for improvement in the dining options, the menu was a bit limited and the breakfast buffet could have had more variety. Service was excellent, though!.”",
          clientImg: "Images/client-face-3.jpg",
          clientName: "Sarah Johnson",
          clientType: "Travel Blogger"
      },
      {
        starRating: 3,
        customerReview: "“Generally a good stay, but a few issues. The room was nice, but the room's mini-fridge wasn't stocked, and when I ordered room service, it took over an 20mins to arrive. Staff was friendly, though. Also, the hotel's parking fee was ridiculously high.”",
        clientImg: "Images/client-face-4.jpg",
        clientName: "Kennedy",
        clientType: "Business Executive"
    },
  ];

  // Function to dynamically create dots based on reviews count
  function createNavDots() {
      $navDotsContainer.empty(); // Clear existing dots
      reviewsData.forEach((_, index) => {
          const activeClass = index === 0 ? "reviewPageNavDotsActive" : ""; // Make the first dot active
          $navDotsContainer.append(`<li class="${activeClass}"></li>`);
      });
  }

    // Function to populate content dynamically
    function populateContent(index) {
        const review = reviewsData[index];

    // Update star rating
    const $starRating = $(".starRating");
    $starRating.empty(); // Clear existing stars
    for (let i = 1; i <= 5; i++) {
        const color = i <= review.starRating ? "#CCB67D" : "gray";
        $starRating.append(`
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 250 250" class= "starRatingIcon" style="width: 50px; fill: ${color};">
                <g id="Layer_x0020_1">
                    <polygon fill:${color}; points="125,7.28 154.09,97.39 248.78,97.21 172.07,152.72 201.5,242.72 125,186.92 48.5,242.72 77.93,152.72 1.22,97.21 95.91,97.39 "/>
                </g>
            </svg>
        `);
    }

        // Update review content
        $(".customerReview").text(review.customerReview);
        $(".clientImg").attr("src", review.clientImg);
        $(".ClientName").text(review.clientName);
        $(".clientType").text(review.clientType);
    }

    // Function to set the active navigation dot
    function setActiveDot(index) {
        $navDotsContainer.find("li").removeClass("reviewPageNavDotsActive");
        $navDotsContainer.find("li").eq(index).addClass("reviewPageNavDotsActive");
    }

    // Event handler for navigation dots
    $navDotsContainer.on("click", "li", function () {
        const index = $(this).index();
        populateContent(index);
        setActiveDot(index);
    });

    // Initialize the content
    createNavDots();
    populateContent(0);


    // Reviews Page Animations 
    const reviewsPageContent = document.querySelector('.reviewsPageContent');
const reviewMiniHeader = document.querySelector('.reviewMiniHeader');
const reviewsHeader = document.querySelector('.reviewsHeader');
const starRatingIcons = document.querySelectorAll('.starRatingIcon');
const customerReview = document.querySelector('.customerReview');
const clientImg = document.querySelector('.clientImg');
const clientName = document.querySelector('.ClientName');
const clientType = document.querySelector('.clientType');
const reviewPageNavDots = document.querySelectorAll('.reviewPageNavDots li');

const reviewsObserver = new IntersectionObserver((entries) => {
  if (entries[0].isIntersecting) {
    reviewsPageContent.classList.add('playReviewsPageAnimations');
    reviewMiniHeader.classList.add('playReviewsPageAnimations');
    reviewsHeader.classList.add('playReviewsPageAnimations');
    starRatingIcons.forEach((icon) => icon.classList.add('playReviewsPageAnimations'));
    customerReview.classList.add('playReviewsPageAnimations');
    clientImg.classList.add('playReviewsPageAnimations');
    clientName.classList.add('playReviewsPageAnimations');
    clientType.classList.add('playReviewsPageAnimations');
    reviewPageNavDots.forEach((dot) => dot.classList.add('playReviewsPageAnimations'));
  }
}, {
  threshold: 0.5, // animate when 50% of the element is visible
});

reviewsObserver.observe(reviewsPageContent);
// ============= END FUNCTIONALITY FOR THE REVIEW  SECTION ==================

// ============= START FUNCTIONALITY FOR THE ABOUT US SECTION ==================
// Select the container and paragraphs inside the About Us section
const aboutUScontainer = $('.aboutUSPageTopLeftContentContainer');
const aboutUSparagraphs = $('.aboutUsPageTopLeftContent');

// Calculate the total number of paragraphs and the scroll percentage needed to activate each p tag
const aboutUSparagraphCount = aboutUSparagraphs.length;
const aboutUSscrollPercentagePerParagraph = 100 / aboutUSparagraphCount;

// Set the initial state: all paragraphs inactive, the first paragraph active
aboutUSparagraphs.addClass('inactive').first().addClass('aboutUsPageContentactive');

// Attach a scroll event listener to the container
aboutUScontainer.on('scroll', function() {
  // Calculate the scroll percentage based on container's current scroll position
  const aboutUSscrollPercentage = 
    (aboutUScontainer.scrollTop() / 
    (aboutUScontainer[0].scrollHeight - aboutUScontainer.height())) * 100;

  // Determine which paragraph should be active based on the scroll percentage
  const aboutUSactiveParagraphIndex = Math.min(
    Math.floor(aboutUSscrollPercentage / aboutUSscrollPercentagePerParagraph),
    aboutUSparagraphCount - 1 // Ensure the index does not exceed the last paragraph
  );

  // Update paragraph classes: active paragraph gets highlighted, others are inactive
  aboutUSparagraphs
    .removeClass('aboutUsPageContentactive inactive')
    .addClass('inactive') // Default to inactive for all paragraphs
    .eq(aboutUSactiveParagraphIndex) // Target the active paragraph
    .removeClass('inactive') // Remove inactive class for the active paragraph
    .addClass('aboutUsPageContentactive'); // Add active class to highlight
});

// Top Section Animation
const aboutUsTopSection = document.querySelector('.aboutUsPage'); // Select the header element in the top section

// Create an Intersection Observer to detect when the top header is visible
new IntersectionObserver((entries, observer) => {
  if (entries[0].isIntersecting) {
    // Stop observing once the animation is triggered
    observer.unobserve(aboutUsTopSection);

    // Add animation classes to all relevant elements in the top section
    document.querySelectorAll('.aboutUsHeader, .aboutUsPageTopLeftHeader, .aboutUsPageTopLeftContent, .aboutUsPageTopLeftButton, .aboutUsPageTopRightImgContainer')
      .forEach((element, index) => {
        element.classList.add('abtUsTopAnimate'); // Add animation class

        // Set animation delay for left content elements
        if (element.matches('.aboutUsPageTopLeftContent')) {
          element.style.animationDelay = `${0.25 + index * 0.05}s`; // Delay increases by 0.15s for each element
        }

        // Set animation delay for right image containers
        if (element.matches('.aboutUsPageTopRightImgContainer')) {
          element.style.animationDelay = `${0.72 + index * 0.05}s`; // Delay increases by 0.1s for each image container
        }
      });
  }
}, { threshold: 0.5 }) // Trigger animation when 50% of the header is visible
  .observe(aboutUsTopSection); // Observe the header element

// Bottom Section Animation
const aboutUsBtmContainer = $('.aboutUsPageBottom'); // Select the bottom section container using jQuery

// Categorize counters by digit count for targeted animations
const aboutUsBtmCounters = {
  single: $('.singleDigit.count'), // Single-digit counters
  double: $('.doubleDigit.count'), // Double-digit counters
  triple: $('.tripleDigit.count'), // Triple-digit counters
  quadruple: $('.quadrupleDigit.count'), // Quadruple-digit counters
};

// Extract original counter values and store them for animation purposes
const originalValues = {};
Object.entries(aboutUsBtmCounters).forEach(([key, elements]) => {
  originalValues[key] = elements.map((_, el) => parseInt($(el).text())).get(); // Save original text values as numbers
});

// /**
//  * Animate numerical counters from 0 to their original value.
//  * @param {jQuery} counters - jQuery selection of counter elements.
//  * @param {Array} values - Array of original values for each counter.
//  * @param {number} increment - Step size for incrementing the counter.
//  * @param {number} duration - Total animation duration in milliseconds.
//  */
function animateCounters(counters, values, increment = 1, duration = 2500) {
  counters.each((index, el) => {
    const targetValue = values[index]; // Get the target value for this counter
    const stepTime = duration / Math.ceil(targetValue / increment); // Calculate time per increment step
    let currentValue = 0; // Start counter at 0

    const interval = setInterval(() => {
      currentValue = Math.min(currentValue + increment, targetValue); // Increment value or cap at target
      $(el).text(currentValue); // Update the counter text
      if (currentValue === targetValue) clearInterval(interval); // Stop once the target is reached
    }, stepTime);
  });
}

// /**
//  * Animate text content with a typing effect.
//  * @param {jQuery} elements - jQuery selection of text elements to animate.
//  */
function animateText(elements) {
  elements.each((_, el) => {
    const originalText = $(el).data('original-text'); // Retrieve the original text from the stored data
    let index = 0; // Start from the first character
    $(el).text(''); // Clear the current text

    const interval = setInterval(() => {
      $(el).text($(el).text() + originalText[index++]); // Add characters one by one
      if (index >= originalText.length) clearInterval(interval); // Stop once the entire text is typed
    }, 50); // Typing speed in milliseconds per character
  });
}

// Create an Intersection Observer to detect when the bottom section is visible
new IntersectionObserver((entries, observer) => {
  if (entries[0].isIntersecting) {
    observer.unobserve(aboutUsBtmContainer.get(0)); // Stop observing once the animation is triggered

    // Reset counters to 0 for animation
    Object.entries(aboutUsBtmCounters).forEach(([key, elements]) => {
      elements.text('0'); // Reset text content
      animateCounters(elements, originalValues[key], key === 'quadruple' ? 231 : 1); // Animate with appropriate increments
    });

    // Animate text content with the typing effect
    animateText($('.aboutUsPageBottomContent'));
  }
}, { threshold: 0.5 }) // Trigger animation when 50% of the bottom section is visible
  .observe(aboutUsBtmContainer.get(0)); // Observe the bottom section container

// Store original text for typing animations
$('.aboutUsPageBottomContent').each(function () {
  $(this).data('original-text', $(this).text()); // Save the original text in a data attribute
});
// ============= END FUNCTIONALITY FOR THE ABOUT US SECTION ==================

// ============= START FUNCTIONALITY FOR THE LOCATION SECTION ==================
// ============= START FUNCTIONALITY FOR THE LOCATION SECTION ==================

// Select DOM elements
const mapPrompt = $(".mapPrompt");
const locationHeader = $(".locationPageHeader");
const locationInput = $(".searchLocation");
const distanceElement = $(".locationDistance");
const destinationCoords = $(".destination-location").val().split(", ");
const isLocationGranted = () => sessionStorage.getItem("locationGranted") === "true";

let promptDisplayed = false; // In-memory flag to track if prompt has been shown

// Hide the map prompt if location is already granted
if (isLocationGranted()) mapPrompt.addClass("mapPromptSlideOutAnimate").hide();

// Toggle map prompt visibility on header click
locationHeader.on("click", () => {
  if (!isLocationGranted() && !mapPrompt.hasClass("mapPromptSlideInAnimate")) {
    mapPrompt.removeClass("mapPromptSlideOutAnimate").addClass("mapPromptSlideInAnimate");
  }
});

// Handle map prompt button clicks
mapPrompt.on("click", ".mapUserResponseBtn", function () {
  const grantLocation = $(this).attr("id") === "mapUserResponseYesBtn";
  sessionStorage.setItem("locationGranted", grantLocation);
  mapPrompt.html(`<h2 style="color: ${grantLocation ? "green" : "red"}">${grantLocation ? "LOCATION GRANTED" : "LOCATION ACCESS DENIED!!"}</h2>`);

  if (grantLocation) {
    navigator.geolocation.getCurrentPosition(({ coords }) => {
      const userLocation = `${coords.latitude}, ${coords.longitude}`;
      locationInput.val(userLocation);

      // Calculate distance using Google Distance Matrix API
      new google.maps.DistanceMatrixService().getDistanceMatrix(
        {
          origins: [userLocation],
          destinations: [{ lat: +destinationCoords[0], lng: +destinationCoords[1] }],
          travelMode: "DRIVING",
          unitSystem: google.maps.UnitSystem.METRIC,
        },
        (response, status) => {
          if (status === "OK") distanceElement.text(response.rows[0].elements[0].distance.text);
        }
      );
    });
  }

  // Keep the message visible for at least 1 second before sliding out
  setTimeout(() => {
    mapPrompt.addClass("mapPromptSlideOutAnimate");
    setTimeout(() => {
      mapPrompt.html(`
        <h2>Allow Houstons to Access Your Current Location</h2>
        <div class="mapPromptResponse">
          <button class="mapUserResponseBtn" id="mapUserResponseNoBtn">No</button>
          <button class="mapUserResponseBtn" id="mapUserResponseYesBtn">Yes</button>
        </div>
      `).removeClass("mapPromptSlideInAnimate");
    }, 500); // Wait for slide-out animation to complete
  }, 1000); // Keep message visible for 1 second
});

// Show map prompt when location page becomes visible for the first time
const locationPage = document.getElementById("location-page");

new IntersectionObserver((entries) => {
  const isVisible = entries[0].isIntersecting;

  if (isVisible && !promptDisplayed && !isLocationGranted()) {
    promptDisplayed = true; // Mark as displayed
    mapPrompt.removeClass("mapPromptSlideOutAnimate").addClass("mapPromptSlideInAnimate").css("opacity", "1");
  }
}, { threshold: 0.5 }).observe(locationPage);

});