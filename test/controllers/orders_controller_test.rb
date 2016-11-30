require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = create(:item)
  end

  test 'should able to place order' do
    item = create(:item, name: 'Second Item')
    post orders_path, params: { order:  { "items"=>{ "#{@item.id}"=>{"qty"=>"1"}, "#{item.id}"=>{"qty"=>"2"} }, 
                                          "promocodes" => [""] } } 

    @order = Order.last
    assert_equal 1, Order.count
    assert_equal @item, @order.order_items.first.item
    assert_equal item, @order.order_items.last.item
  end

  test 'should be able to apply promocode' do
    promocode = create(:promocode, name: '20POUDNSOFF', promo_type: 'flat', value: 20)

    post orders_path, params: { order:  { "items"=>{ "#{@item.id}"=>{"qty"=>"1"} }, 
                                          "promocodes" => ["", promocode.id] } } 

    @order = Order.last
    assert_equal promocode, @order.promotions.last.promocode
  end

  test "should calculate final price of an order" do
    promocode = create(:promocode, name: '10POUDNSOFF', promo_type: 'flat', value: 10)

    post orders_path, params: { order:  { "items"=>{ "#{@item.id}"=>{"qty"=>"1"} }, 
                                          "promocodes" => ["", promocode.id] } } 

    @order = Order.last
    assert_not_equal 0.0, @order.total_price.to_f
    assert_equal 10.0, @order.price_after_discount.to_f
  end

  test 'should redirect to invoice if price after discount is zero' do
    promocode = create(:promocode, name: '20POUDNSOFF', promo_type: 'flat', value: 20)

    post orders_path, params: { order:  { "items"=>{ "#{@item.id}"=>{"qty"=>"1"} }, 
                                          "promocodes" => ["", promocode.id] } } 

    @order = Order.last
    assert_redirected_to order_path(@order) 
  end

  test 'should redirect to payment page if price after discount is not zero' do
    promocode = create(:promocode, name: '10POUDNSOFF', promo_type: 'flat', value: 10)

    post orders_path, params: { order:  { "items"=>{ "#{@item.id}"=>{"qty"=>"1"} }, 
                                          "promocodes" => ["", promocode.id] } } 

    @order = Order.last
    assert_redirected_to payment_order_path(@order) 
  end

  test 'should be able to do payment for an order' do
    order = create(:order)
    order.order_items.create(item: @item, qty: 2)

    post payment_order_path(order), params: { customer: { email: 'test@test.com', 
      address: 'delivery address', cards_attributes: { '0' => { credit_card: '1234567890123456', 
        card_expiry_month: '8', card_expiry_year: '2020', card_cvv: '123' } } } }

    customer = order.reload.customer

    assert_equal 'test@test.com', customer.email
    assert_equal 'delivery address', 'delivery address'
  end

  test 'order should confirm once payment has been done' do
    order = create(:order)
    order.order_items.create(item: @item, qty: 2)

    post payment_order_path(order), params: { customer: { email: 'test@test.com', 
      address: 'delivery address', cards_attributes: { '0' => { credit_card: '1234567890123456', 
        card_expiry_month: '8', card_expiry_year: '2020', card_cvv: '123' } } } }

    assert_equal 'confirmed', order.reload.state
  end

  test 'should relate order to prev customer if email already exists' do
    order = create(:order)
    order.order_items.create(item: @item, qty: 2)
    customer = Customer.create(email: 'test@test.com', address: 'delivery address')
    order.update_attributes(customer: customer)

    _order = create(:order)
    _order.order_items.create(item: @item, qty: 2)

    post payment_order_path(_order), params: { customer: { email: 'test@test.com', 
      address: 'delivery address', cards_attributes: { '0' => { credit_card: '1234567890123456', 
        card_expiry_month: '8', card_expiry_year: '2020', card_cvv: '123' } } } }

    assert_equal customer, _order.reload.customer
  end
end
