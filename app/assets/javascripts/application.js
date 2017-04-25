// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

/*global $*/

$(function() {
    // Adds AJAX request for liking a post
    $('.post-like').click(function(event) {
        event.preventDefault();
        var el = $(this);
        var post_id = el.data('post-id');
        var liked;
        // Toggle appearance of like buttons
        if (el.hasClass('btn')) {
            liked = el.hasClass('btn-info');
            el.toggleClass('btn-info');
            $('.post-like:not(.btn)').toggleClass('text-info');
        } else {
            liked = el.hasClass('text-info');
            el.toggleClass('text-info');
            $('.post-like.btn').toggleClass('btn-info');
        }
        // If post is already liked, unlike it.
        var num_el = $('#post-'+post_id+'-likes');
        if (liked) {
            $.post( "/posts/"+post_id+"/unlike");
            num_el.text(parseInt(num_el.text()) - 1);
        } else {
            $.post( "/posts/"+post_id+"/like");
            num_el.text(parseInt(num_el.text()) + 1);
        }
    });
});

