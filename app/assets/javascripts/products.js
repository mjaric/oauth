$(function() {

    $("#my-cart").fixPosition($(".show-cart"));

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