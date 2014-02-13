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
//= require bootstrap
//= require bootstrap-datepicker
//= require turbolinks
//= require_tree .


$(function() {
    $('.editable-select').editableSelect(
        {
            bg_iframe: true,
            onSelect: function(list_item) {
            },
            case_sensitive: false, // If set to true, the user has to type in an exact
            // match for the item to get highlighted
            items_then_scroll: 10 // If there are more than 10 items, display a scrollbar
        }
    );
});
