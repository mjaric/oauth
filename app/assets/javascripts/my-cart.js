var MyCartApp = function() {

    return {

        init : function()
        {

            jQuery('.carousel').carousel({
                interval: 15000,
                pause: 'hover'
            });

            jQuery('.top').click(function(){
                jQuery('html,body').animate({scrollTop: jQuery('body').offset().top}, 'slow');
            }); //move to top navigator

            jQuery('.tooltips').tooltip();
            jQuery('.popovers').popover();

        }

    };

}();