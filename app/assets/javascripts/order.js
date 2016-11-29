$(document).ready(function(){
  $('.items').slick({
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 3
  });

  $('.item').click(function(){
    if($(this).is(':checked')) {
      $('.final-submit').attr('class', 'btn btn-primary final-submit disabled')
      $.ajax({
        type: 'post', 
        url: '/orders/select_item',
        data: { 'order' : { 'item': $(this).attr('id') } }
      })
      $('#summary').attr('class', 'show')
    } else {
      $("#row_"+$(this).attr('id')).remove()

      if($('.item:checked').length == 0) {
        $('#summary').attr('class', 'hide')
      } 
    }
    calculate_order_price();
    validate_qty();
  })

  $('.apply').click(function(){
    $.ajax({
      type: 'post', 
      url: '/orders/apply_promocode',
      data: { 'order' : { 'total_price': $('#total_price').attr('data-total-price'),
                          'promocodes': $('#order_promocodes').val() } }
    })
  });
});
