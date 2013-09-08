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
//= require_tree .
Array.prototype.remove = function(from, to) {
    var rest = this.slice((to || from) + 1 || this.length);
      this.length = from < 0 ? this.length + from : from;
        return this.push.apply(this, rest);
};
$(document).ready(prepare)
  
function prepare() {
  $('.button').button();
  $('#login-dialog').dialog({ autoOpen: false, modal: true});
  $('#register-dialog').dialog({ autoOpen: false, modal: true});
  $('.login-button').click(function() {
    $('#login-dialog').dialog('open');
    $('.button').button();
  });
  $('.register-button').click(function() {
    $('#register-dialog').dialog('open');
    $('.button').button();
  });
  $('#nav').buttonset();
  $('.ui-current').addClass('ui-state-active');
  $('.ui-current').hover(function() { $('.ui-current').addClass('ui-state-active')});
}
