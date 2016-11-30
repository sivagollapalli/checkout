require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'should apply promocodes on final price' do
    item = create(:item)
    promocode1 = create(:promocode, name: '10POUNDSOFF', promo_type: 'flat', value: 10.0)
    promocode2 = create(:promocode, name: '5% OFF', promo_type: 'percentage', value: 5)
    order = create(:order)

    order.order_items.create(item: item, qty: 1)
    order.promotions.create(promocode: promocode1)
    order.promotions.create(promocode: promocode2)

    order.calculate_order_price

    assert_equal 20.0, order.reload.total_price.to_f
    assert_equal 9.5, order.price_after_discount.to_f
  end

  test 'should not store as zero if user get 100% discount' do
    item = create(:item)
    promocode1 = create(:promocode, name: '25POUNDSOFF', promo_type: 'flat', value: 25.0)
    order = create(:order)

    order.order_items.create(item: item, qty: 1)
    order.promotions.create(promocode: promocode1)

    order.calculate_order_price

    assert_equal 20.0, order.reload.total_price.to_f
    assert_equal 0.0, order.price_after_discount.to_f
  end

  test 'should check if promocodes can be applicable together' do
    promocode1 = create(:promocode, name: '25POUNDSOFF', promo_type: 'flat', value: 25.0, used_in_conjuncation: false)
    promocode2 = create(:promocode, name: '25POUNDSOFF', promo_type: 'flat', value: 25.0)

    error, success, discount_price = Order.apply_promocode([promocode1.id, promocode2.id], 100)

    assert_equal 'You cant use these promocodes together', error
    refute success
    assert_equal discount_price, 0.0 
  end

  test 'should check if promocodes can be together applicable' do
    promocode1 = create(:promocode, name: '25POUNDSOFF', promo_type: 'flat', value: 25.0)
    promocode2 = create(:promocode, name: '25POUNDSOFF', promo_type: 'flat', value: 25.0)

    error, success, discount_price = Order.apply_promocode([promocode1.id, promocode2.id], 100)

    assert_equal '', error
    assert success
    assert_equal discount_price, 50.0 
  end

  test 'should be able confirm order and unique ref no' do
    order = create(:order)
    order.confirm!

    assert_equal 'confirmed', order.state
    assert_not_equal '', order.ref_no
  end
end
