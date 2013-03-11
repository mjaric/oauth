$(function() {



    $("#my-cart").fixPosition($(".cart-toggle"));

    var hideMyCart = function(){
        $(".cart-toggle").parent('li').removeClass('open');
        $("#my-cart").removeClass('visi');    
    }

    var showMyCart = function(){
        $(".cart-toggle").parent('li').addClass('open');
        $("#my-cart").addClass('visi');    
    }

    $(".cart-toggle").on("click", function(event){
        event.preventDefault();
        $(this).parent('li').toggleClass('open');
        $("#my-cart").fixPosition($(this)).toggleClass('visi');
    });

    $("#my-cart a.close").on("click", function(event){
        event.preventDefault();
        $(".cart-toggle").parent('li').removeClass('open');
        $("#my-cart").removeClass('visi');#274e13
    });

    $(window).resize(function() {
        $("#my-cart").fixPosition($(".cart-toggle"));
    });

    $(window).scroll(function() {
        $("#my-cart").fixPosition($(".cart-toggle"));
    });

    $('.dropdown-toggle').click(function () {
        hideMyCart();
    });

    var myCart = document.getElementById('my-cart');
    var myCartLink = document.getElementById('my-cart-link');

    $(document).click(function(e) {
        var target = (e && e.target) || (event && event.srcElement);
        var visibility = 'hidden';
        
        while (target.parentNode) {
            // console.log(target);
            if (target == myCart || target == myCartLink) {
                // console.log('visible');
                visibility ='visible';
                break;
            }
            target = target.parentNode;
        }

        if(visibility != 'visible'){
            // console.log('remove');
            $(".cart-toggle").parent('li').removeClass('open');
            $('#my-cart').removeClass('visi');
        }
    });

});

jQuery.fn.fixPosition = function(element) {
    var windowWidth = $(window).width();
    var windowHalf = $(window).width() / 2;

    var offset = element.offset();
    var offsetCorrection = 10;
    var verticalOffsetCorrection = 1;
    var heightOffset = element.outerHeight();

    this.css({top: offset.top + heightOffset + verticalOffsetCorrection});

    if(offset.left < windowHalf){
        this.css({left: offset.left - offsetCorrection});
    } else {
        this.css({right: windowWidth - (offset.left + element.outerWidth()) - offsetCorrection});
    }

    return this;
};