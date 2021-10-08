// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require toastr
//= require counterPlugin.min
//= require bootstrap
//= require readmore
//= require jquery-ui
//= require jquery_ujs
//= require autocomplete-rails
//= require jquery.atwho
//= require social-share-button
//= require clipboard
//= require shuffle
//= require_tree .


$(document).ready(function(){  
  var clipboard = new Clipboard('.clipboard-btn');
  console.log(clipboard);

  var Shuffle = window.Shuffle;

  var myShuffle = new Shuffle(document.querySelector('._shuffle_container'), {
    itemSelector: '._item_shuffle',
    sizer: '.my-sizer-element',
    buffer: 1,
  });

});



