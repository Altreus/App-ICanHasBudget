$.fn.toggleClass = function (c) {
    var t = $(this);
    if (t.hasClass(c)) t.removeClass(c); else t.addClass(c);
    return t;
};

$(function () {
    function showhide_nearest_form(event) {
        var $box = $(this).closest('.add-kitty');

        $box.toggleClass('open');
    }

    function showhide_save_icon(event) {
        var $this = $(this),
            $box = $this.closest('.add-kitty');

        if ($this.val()) {
            $box.addClass('changed');
        }
        else {
            $box.removeClass('changed');
        }
    }

    function showhide_nearest_transactions(event) {
        $(this).closest('.kitty').toggleClass('open');
        event.preventDefault();
    }

    $('.add-kitty .add-icon, .add-account .add-icon').on('click', showhide_nearest_form);
    $('.add-kitty form input').on('input', showhide_save_icon);
    $('.show-transactions').on('click', showhide_nearest_transactions);
});
