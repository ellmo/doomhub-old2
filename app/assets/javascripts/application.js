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
//= require jquery_ujs
//= require foundation
//= require vendor/angular
//= require vendor/angular-route
//= require angular/app
//= require_tree ./angular


$(function(){
  Foundation.set_namespace = function(){
    // workaround for non-css browsers, like PhantomJS
    var namespace = false;
    this.global.namespace = ( namespace === undefined || /false/i.test(namespace) ) ? '' : namespace;
  };
  $(document).foundation();
});
