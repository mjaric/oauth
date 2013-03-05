$(function() {

    $("#my-cart").fixPosition($(".show-cart"));

    var hideMyCart = function(){
        $(".show-cart").parent('li').removeClass('active');
        $("#my-cart").removeClass('visi');    
    }

    var showMyCart = function(){
        $(".show-cart").parent('li').addClass('active');
        $("#my-cart").addClass('visi');    
    }

    $(".show-cart").on("click", function(event){
        event.preventDefault();
        $(this).parent('li').toggleClass('active');
        $("#my-cart").fixPosition($(this)).toggleClass('visi');
    });

    $("#my-cart a.close").on("click", function(event){
        event.preventDefault();
        $(".show-cart").parent('li').removeClass('active');
        $("#my-cart").removeClass('visi');
    });

    $(window).resize(function() {
        $("#my-cart").fixPosition($(".show-cart"));
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
            $(".show-cart").parent('li').removeClass('active');
            $('#my-cart').removeClass('visi');
        }
    });

});

jQuery.fn.fixPosition = function(element) {
    var windowWidth = $(window).width();
    var windowHalf = $(window).width() / 2;

    var offset = element.offset();
    var offsetCorrection = 10;
    var heightOffset = element.outerHeight();

    var position = element.position();

    this.css({top: offset.top + heightOffset});

    if(offset.left < windowHalf){
        this.css({left: offset.left - offsetCorrection});
    } else {
        this.css({right: windowWidth - (offset.left + element.outerWidth()) - offsetCorrection});
    }

    return this;
};