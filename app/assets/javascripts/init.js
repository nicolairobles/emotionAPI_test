(function( $ ){
  'use strict';

  //
  // Preloader
  jQuery(window).load(function() {
    jQuery(".preloader").delay(1000).fadeOut("slow");
  });

  $(document).ready(function(){
    //
    // Sticky Header
    $(window).scroll(function () {
      if ($(this).scrollTop() > 200) {
        $('body').addClass("sticky-nav");
      }
      else {
        $('body').removeClass("sticky-nav");
      }
    });
    $(window).scroll();

    //
    // Smooth Scrolling
    $('a[href*=#]:not([href=#])').click(function() {
      if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
        if (target.length) {
          $('html,body').animate({
            scrollTop: target.offset().top - 60
          }, 500);
          return false;
        }
      }
    });

    //
    // ScrollSpy
    $("body").scrollspy({
      target  : '.navbar',
      offset  : 65
    });

    //
    // Scroll Animation
    var wow = new WOW(
      {
        mobile:       false
      }
    );
    wow.init();

    //
    // Magnific Popup (Video)
    $('.play-btn').magnificPopup({
      disableOn: 700,
      type: 'iframe',
      mainClass: 'mfp-fade',
      removalDelay: 160,
      preloader: true,
      fixedContentPos: false
    });

    //
    // Counter Up
    $('.countup').counterUp({
      delay : 10,
      time  : 1000
    });

    //
    // Subscribe (mailchimp)
    var mailSubscribe   = $('.subscribe-form');

    mailSubscribe.ajaxChimp({
      callback: mailchimpCallback,
      url: "http://frontpixels.us11.list-manage.com/subscribe/post?u=8ed724b6f4db710960cbc2439&amp;id=26648b74c9" // Just paste your mailchimp list url inside the "".
    });

    function mailchimpCallback(resp) {
      var successMessage    = $('.subscribe-success'),
          errorMessage      = $('.subscribe-error'),
          successIcon       = '<i class="ion-ios-checkmark"></i> ',
          errorIcon         = '<i class="ion-ios-close"></i> ';

      if (resp.result === 'success') {
        successMessage.html(successIcon + resp.msg).fadeIn(1000);
        errorMessage.fadeOut(300);

      } else if(resp.result === 'error') {
        errorMessage.html(errorIcon + resp.msg).fadeIn(1000);
      }
    }

    //
    // Contact
    var contact         = $('.contact-form'),
      successMessage    = $('.contact-success'),
      errorMessage      = $('.contact-error');

    contact.validate({
      rules: {
        name: {
          required: true,
          minlength: 2
        },
        email: {
          required: true,
          email: true
        },
        message: {
          required: true
        }
      },

      messages: {
        name: {
          required: "Come on! Enter your name",
          minlength: "your name must consist of at least 2 characters"
        },
        email: {
          required: "no email, no message"
        },
        message: {
          required: "You have to write something to send this form.",
          minlength: "thats all? really?"
        }
      },

      submitHandler: function(form) {
        $(form).ajaxSubmit({
          type:"POST",
          data: $(form).serialize(),
          url:"assets/php/contact.php",
          success: function() {
            successMessage.fadeIn();
          },
          error: function() {
            contact.fadeTo( "slow", 0.15, function() {
              errorMessage.fadeIn();
            });
          }
        });
      }
    });

  });

  //
  // Review
  $('.review-carousel').owlCarousel({
    loop            : true,
    autoplay        : true,
    autoplayTimeout : 9000,
    items           : 1,
    nav             : true,
    navText       : ['<i class="ion-ios-arrow-thin-left"><i/>','<i class="ion-ios-arrow-thin-right"><i/>']
  });

  //
  // Screenshots
  var screenshots = $('.screenshots');
  screenshots.owlCarousel({
    loop            : true,
    margin          : 30,
    responsiveClass : true,
    nav             : true,
    navText       : ['<i class="ion-ios-arrow-left"><i/>','<i class="ion-ios-arrow-right"><i/>'],
    responsive:{
      0:{
        items   : 1,
        margin  : 0
      },
      736:{
        items   : 2
      },
      1000:{
        items   : 3
      },
      1600:{
        items   : 4
      }
    }
  });

  //
  // Clients
  $('.clients').owlCarousel({
    loop            : true,
    autoplay        : true,
    autoplayTimeout : 7000,
    margin          : 30,
    responsiveClass : true,
    responsive:{
      0:{
        items   : 1,
        margin  : 0
      },
      736:{
        items   : 2
      },
      991:{
        items   : 3
      },
      1000:{
        items   : 4
      },
      1200:{
        items   : 5
      }
    }
  });

})(window.jQuery);