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

  $("._btn_out_sidebar").click(function(){
      $("#_sidenav").toggleClass("out");
      // $("#_sidenav_2").toggleClass("out");
      $("._header._1").toggleClass("_on");
      $("._logo_navbar").toggleClass("_on");
      $("._content_principal").toggleClass("_p_off");
      $(".content_big_1").toggleClass("offset-md-3");
      $(".content_big_1").toggleClass("offset-xl-2");
  });

  $("._btn_out_sidebar").click(function(){
      $("._content_principal").toggleClass("full");
  });

  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })
  $("._btn_comment").click(function(){
      $("._modalreview").addClass("show");
      $(".modal-mock aside._container_mock._1 > ._mock").addClass("_on");
  });
  $("._close_review").click(function(){
      $("._modalreview").removeClass("show");
      $(".modal-mock aside._container_mock._1 > ._mock").removeClass("_on");
  });
  $("._action._menu").click(function(){
      $("._fullnav").toggleClass("_on");
      $(this).toggleClass("_on");
  });
  $("._action._search").click(function(){
      $("._search_modern").addClass("_on");
      $(this).addClass("_on");
  });
  $("._close._search").click(function(){
      $("._search_modern").removeClass("_on");
      $(this).removeClass("_on");
  });





  // REVIEWS
    $( "textarea#review_comment" ).focusin(function() {
      $( this ).addClass("_focus");
      $( "form.new_review input._btn._1" ).addClass("_focus");
    });
    $( "textarea#review_comment" ).focusout(function() {
      $( this ).removeClass("_focus");
      $( "form.new_review input._btn._1" ).removeClass("_focus");
    });
    // ------------------------
    $( "form.new_review input.btn._btn._1" ).hover(function() {
      $( this ).addClass("_focus");
      $( "textarea#review_comment" ).addClass("_focus");
    });
    $( ".reviews ._btn._simple" ).click(function() {
      $( "form.new_review input.btn._btn._1" ).addClass("_focus");
      $( "textarea#review_comment" ).addClass("_focus");
    });
    // -------------

    $( "textarea._textarea_comment_answer" ).focusin(function() {
      $( this ).addClass("_focus");
      $( "form.new_answer input._btn._1" ).addClass("_focus");
    });
    $( "textarea._textarea_comment_answer" ).focusout(function() {
      $( this ).removeClass("_focus");
      $( "form.new_answer input._btn._1" ).removeClass("_focus");
    });
    // ------------------------
    $( "form.new_answer input.btn._btn._1" ).hover(function() {
      $( this ).addClass("_focus");
      $( "textarea._textarea_comment_answer" ).addClass("_focus"); 
    });
    $( ".reviews ._btn._simple" ).click(function() {
      $( "form.new_answer input.btn._btn._1" ).addClass("_focus");
      $( "textarea._textarea_comment_answer" ).addClass("_focus");
    });
  // END REVIEWS




  $( "form>._head" ).focusin(function() {
    $( this ).addClass("_focus");
    $( "form>._head>._btn._1" ).addClass("_focus");
  });
  $( "form>._head" ).focusout(function() {
    $( this ).removeClass("_focus");
    $( "form>._head>._btn._1" ).removeClass("_focus");
  });
});
  

