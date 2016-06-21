// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//= require jquery.singlePageNav.min.js

jQuery('#nav').singlePageNav({
    offset: jQuery('#nav').outerHeight(),
    filter: ':not(.external)',
    speed: 2000,
    currentClass: 'current',
    easing: 'easeInOutExpo',
    updateHash: true,
    beforeStart: function() {
        console.log('begin scrolling');
    },
    onComplete: function() {
        console.log('done scrolling');
    }
});