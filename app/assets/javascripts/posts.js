// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
/*global $*/

var add_comment_scroll = function() {
    $(".js-add-comment-helper").click(function(event) {
        event.preventDefault();
        $('html, body').animate({
            scrollTop: $("#js-add-comment").offset().top
        }, 1200);
    });
};

$(document).on('turbolinks:load', add_comment_scroll);