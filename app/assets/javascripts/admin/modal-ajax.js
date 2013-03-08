$(function() {

    $.fn.modalFix = function(opts) {
        // set default options
        opts            =       opts            ||      {};
        opts.filter     =       opts.filter     ||      '';

        var modal = opts.filter ? $('.modal').filter(opts.filter) : $(this);
        var bodyModalOpen = $('body.modal-open');
        var pageYOffset = getScrollY();

        var modalHeight = modal.outerHeight();
        var modalWidth = modal.outerWidth();
        //var windowHeight =  window.innerHeight;
        var windowHeight =  $(window).height();


        // Define top offset for oversize modals (in px)
        var pageTopOffset = 40;

        var marginTop = - modalHeight / 2;
        var marginLeft = - modalWidth / 2;

        var modalCss = {
            'top': '50%',
            'position': 'fixed',
            'margin-top': marginTop,
            'margin-left': marginLeft
        };

        var bodyModalOpenCss = {
            'overflow': 'hidden'
        };

        if(modalHeight > windowHeight){
            marginTop = pageYOffset + pageTopOffset;

            modalCss = {
                'top': 0,
                'position': 'absolute',
                'margin-top': marginTop,
                'margin-left': marginLeft
            };

            bodyModalOpenCss = {
                'overflow': 'auto'
            };
        } else {

        }

        modal.css(modalCss);
        bodyModalOpen.css(bodyModalOpenCss);
    };

    var getScrollY = function getScroll() {
        var scrOfY = 0;
        //var scrOfX = 0;
        if( typeof( window.pageYOffset ) == 'number' ) {
            //Netscape compliant
            scrOfY = window.pageYOffset;
            //scrOfX = window.pageXOffset;
        } else if( document.body && ( document.body.scrollLeft || document.body.scrollTop ) ) {
            //DOM compliant
            scrOfY = document.body.scrollTop;
            // scrOfX = document.body.scrollLeft;
        } else if( document.documentElement && ( document.documentElement.scrollLeft || document.documentElement.scrollTop ) ) {
            //IE6 standards compliant mode
            scrOfY = document.documentElement.scrollTop;
            //scrOfX = document.documentElement.scrollLeft;
        }
        return scrOfY;
    }

})

$(document).ready(function() {

    var updateDiv = function(target, url){
        var div = $(target);
        if(div.length > 0 && url != ''){
            $.ajax({
                type: 'GET',
                url: url,
                dataType: "html",
                success: function(data){
                    div.html(data);
                }
            });
        }
    };

    $(document).on("click", ".modal-ajax", function (e) {
        e.preventDefault();
        // console.log('in modal ajax');
        var $this = $(this);
        var label = $(this).html();
        var id = $(this).attr('id');
        var url = $(this).attr('href');

        var reloadTarget = $(this).data('reloadtarget');
        var reloadUrl = $(this).data('reloadurl');

        var modalAjax = $('<div></div>').attr({
            id: 'modal-ajax',
            class: 'modal hide fade',
            style: 'display:none'
        });

        $.ajax({
            type: 'GET',
            url: url,
            dataType: "html",
            beforeSend: function(){
//                $this.loading();
            },
            success: function(data){

                if($('#modal-ajax').length == 0){
                    $('body').append(modalAjax);
                }

                var modalObj = $('#modal-ajax');

                modalObj.html(data);

                modalObj.modal('show').modalFix();

                modalObj.on('hidden', function(){
                    $(this).removeData('modal');
                    $('div').remove('#modal-ajax');
                    if(reloadTarget) updateDiv(reloadTarget, reloadUrl);
                })
            },
            complete: function(){
//                $this.loading();
            }
        });
    });

    

    // Fix modal position when window change size
    window.onresize = function(){
        // $('.modal').modalFix({filter:':visible'});
    };

    $('.modal').bind('hidden', function(){
        $('body').css({
            'overflow': 'auto'
        });
    });
    // Fix modal - end

});