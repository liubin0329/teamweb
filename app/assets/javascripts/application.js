// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//

//= require jquery
//= require jquery_ujs
//= require peek
//= require peek/views/performance_bar
//= require peek/views/rblineprof
//= require rails_javascript_log
//= require bootstrap-wysihtml5/b3
//= require modernizr/modernizr
//= require bootstrap/dist/js/bootstrap 
//= require_tree .


$(document).ready(function(){

  $('.wysihtml5').each(function(i, elem) {
    $(elem).wysihtml5();
  });

});