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
//= require bootstrap-sprockets
//= require jquery_ujs
//= require_tree .
//= require jquery.slick

$('.alert').on('show', function(){
  $(".alert").delay(5000).fadeOut('slow');
})

function calculate_order_price() {
  var total = 0;
  $('td.total_price').each(function(i, obj) {
    total += parseFloat($(obj).text());
  });

  $('#total_price').html("Total Price: £ "+ total.toFixed(2)).attr('data-total-price', total);
  $('#final_price').html("Final Price: £ "+ total.toFixed(2)).attr('data-final-price', total);
}

function validate_qty() {
  $.each($('.qty'), function(key, obj) { 
    value = $(obj).val();

    if(value == "" || isNaN(value)) {
      $('.final-submit').attr('class', 'btn btn-primary final-submit disabled');
      return false; 
    }
    $('.final-submit').attr('class', 'btn btn-primary final-submit');
  });
}
