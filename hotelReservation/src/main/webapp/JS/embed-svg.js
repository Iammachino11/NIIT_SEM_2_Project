  // Code to Embed SVG into the HTML file. DO NOT TOUCH THIS BLOCK OF CODE
        // As it allowed me to change the Color of the SVG file
        jQuery('.svg').each(function () {
            const $img = jQuery(this);
            const imgID = $img.attr('id');
            const imgClass = $img.attr('class');
            const imgURL = $img.attr('src');
            jQuery.get(
                imgURL,
                (data) => {
                    let $svg = jQuery(data).find('svg');
                    if (imgID) $svg.attr('id', imgID);
                    if (imgClass) $svg.attr('class', `${imgClass} replaced-svg`);
                    $svg.removeAttr('xmlns:a');
                    $img.replaceWith($svg);
                },
                'xml',
            );
        });