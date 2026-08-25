// Renamed from application.js (Hotwire stage): app/javascript/application.js
// (the importmap ES module entrypoint) has the same logical name -
// Sprockets was resolving the "application" importmap pin to THIS
// file instead, silently loading jQuery instead of Turbo/Stimulus.
// Found by checking window.Turbo in a real browser, not by reading
// the diff - no error was thrown, it just quietly loaded the wrong
// bundle.
//
// This is a manifest file that'll be compiled into legacy.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
