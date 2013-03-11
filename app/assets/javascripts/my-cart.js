!function ($) {
    
    "use strict"; // jshint ;_;

    /* MYCART CLASS DEFINITION
     * ====================== */

    var toggle = '[data-toggle=mycart]' 
        ,MyCart = function (element, options) {        
        this.options = $.extend({}, $.fn.mycart.defaults, options)
        this.$window = $(window)
        this.$element = $(element)
        
        var $el = $(element).on('click.mycart.data-api', this.toggle)
        $('html').on('click.mycart.data-api', function () {
          $el.parent().removeClass('open')
        })

    }

    MyCart.prototype = {

        constructor: MyCart

        , toggle: function (e) {
            
            var $this = $(this)
            , $parent
            , isActive

            if ($this.is('.disabled, :disabled')) return

            $parent = getParent($this)

            isActive = $parent.hasClass('open')

            if (!isActive) {
                $parent.toggleClass('open')
            }

            $this.focus()

            return false

        }

        , checkPosition = function (e) {
            var windowWidth = this.$window.width()
            , offset = this.options.offset
            , offsetVertical = offset.vertical
            , offsetHorizontal = offset.horizontal
            , heightOffset = this.$element.outerHeight()
        }

        // var windowHalf = $(window).width() / 2;
    }

    function getParent($this) {
        var selector = $this.attr('data-target')
        , $parent

        if (!selector) {
            selector = $this.attr('href')
            selector = selector && /#/.test(selector) && selector.replace(/.*(?=#[^\s]*$)/, '') //strip for ie7
        }

        $parent = selector && $(selector)

        if (!$parent || !$parent.length) $parent = $this.parent()

        return $parent
    }


}(window.jQuery);