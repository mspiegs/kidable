// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require fancybox
//= require jquery_ujs
//= require raty.min.js
//= require bootstrap/bootstrap
//= require turbolinks
//= require underscore
//= require gmaps/google
//= require_tree .
$(document).ready(function(){

	$('.carousel').carousel();

	$('#myModal').modal({
		show: false
	});

	$(window).scroll(function(){
	    $(".filter").css("top",Math.max(48,141-$(this).scrollTop()));
		});

	$('#places_search').submit(function(){
			$.get(this.action, $(this).serialize(), null, "script");
			return false;
		});
	$('#selections').submit(function(){
			$.get(this.action, $(this).serialize(), null, "script");
			return false;
		});
});

// var mediaTop = $('.filter').offset().top;
// var media = $('.filter');

// $(document).scroll( function() {
// 	var scrollTop = $(document).scrollTop();

// 	if (mediaTop < scrollTop) {
// 		$(media).addClass('fixed');
// 	}
// 	else {
// 		$(media).removeClass('fixed');
// 	}
// });

var setupPlace = function(rating, user_score, rating_id) {
	$('#star').raty({
	    readOnly: true,
	    score: rating,
	    path: '/assets'
	  });

	$('#user_star').raty({
		score: user_score,
		path: '/assets',
		click: function(score, evt) {
			$.ajax({
				url: '/ratings/' + rating_id,
				type: 'PATCH',
				data: { score: score }
				});
		}
	});

};

