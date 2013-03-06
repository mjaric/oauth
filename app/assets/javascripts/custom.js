$(document).ready(function() {

    $.rails.confirm = function(message, element){
        var state = element.data('state');
        var txt = element.text();
        if (!state){
            element.data('state', 'last');
            element.text('Sure?');
            setTimeout(function(){
                element.data('state', null);
                element.text(txt);
            }, 3000);
            return false;
        }
        else{
            return true;
        }
        return false
    };

    $.rails.allowAction = function(element){
        var message = element.data('confirm'),
            answer = false, callback;
        if (!message) { return true; }

        if ($.rails.fire(element, 'confirm'))
        {
            // le extension.
            answer = $.rails.confirm(message, element);
            callback = $.rails.fire(element, 'confirm:complete', [answer]);
        }
        return answer && callback;
    };

    $.rails.handleLink = function(link){
        if (link.data('remote') !== undefined)        {
            $.rails.handleRemote(link);
        }
        else if (link.data('method')){
            $.rails.handleMethod(link);
        }ß
        return false;
    };

    $('[data-toggle="tabajax"]').on('click', function(e) {
        e.preventDefault();
        $this = $(this);
        var loadurl = $(this).attr('href');
        var targ = $(this).attr('data-target');
        $(targ).load(loadurl, function(){
            $this.tab('show');
        });
    });

//    // side bar
//    setTimeout(function () {
//        $('.bs-docs-sidenav').affix({
//            offset: {
//                top: function () { return $(window).width() <= 980 ? 190 : 110 },
//                bottom: 190
//            }
//        })
//    }, 50);

});

