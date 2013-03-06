var SpongeApp = function() {

    return {

        init : function()
        {

            jQuery('#home-carousel').carousel({
                interval: 15000,
                pause: 'hover'
            });

            jQuery('#feature-products').carousel({
                interval: false
            });






            jQuery('.top').click(function(){
                jQuery('html,body').animate({scrollTop: jQuery('body').offset().top}, 'slow');
            }); //move to top navigator

            jQuery('[rel="tooltip"]').tooltip();
            jQuery('.popovers').popover();

            // fix sub nav on scroll
            var $win = $(window), $nav = $('.navbar'), navTop = $('.navbar').length && $('.navbar').offset().top - 5, isFixed = 0;

            processScroll()

            $win.on('scroll', processScroll)

            function processScroll() {
                var i, scrollTop = $win.scrollTop();
                if (scrollTop >= navTop && !isFixed) {
                    isFixed = 1
                    $nav.removeClass('navbar-static-top').addClass('navbar-fixed-top')
                } else if (scrollTop <= navTop && isFixed) {
                    isFixed = 0
                    $nav.addClass('navbar-static-top').removeClass('navbar-fixed-top')
                }
            }

        }

    };

}();