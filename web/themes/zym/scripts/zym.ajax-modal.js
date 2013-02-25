!function( $ ){
    "use strict"

    $(document).ready(function () {
        $('body').delegate('[data-toggle="ajax-modal"]', 'click.modal.data-api', function (e) {
            e.preventDefault();

            var $this  = $(this);
            var target = $this.attr('data-target');
            var option = $(target).data('modal') ? 'toggle' : $this.data();

            if ($(target)) {
                target = document.createElement('div');
                $(target).addClass('modal hide fade');
            }

            $(target).html('<div class="modal-header"><a href="#" class="close" data-dismiss="modal">&times;</a></div><div class="modal-body"></div><div class="modal-footer"></div>');

            $.get($this.attr('href') + '.ajax', function(data) {
                  $(target).html(data);
            });

            $(target).modal(option);
        })
    });
}( window.jQuery || window.ender )