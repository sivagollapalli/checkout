require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item = create(:item)
  end

  test "able to add items to order" do
    post add_items_orders_path, params: { order: { item: @item.id, qty: 1} }, xhr: true

    @order = Order.last
    assert_equal 1, Order.count
    assert_equal @item, @order.order_items.first.item
    assert_equal 1, @order.order_items.first.qty
  end

  test 'should not add items to order if qty is zero' do
    post add_items_orders_path, params: { order: { item: @item.id, qty: 0} }, xhr: true

    assert_equal 0, Order.count
  end

  test 'should not add items to order if item didnt selected' do
    post add_items_orders_path, params: { order: { item: '', qty: 1 } }, xhr: true

    assert_equal 0, Order.count
  end

  test 'should be able to add multiple items to order' do
    item = create(:item)
    post add_items_orders_path, params: { order: { item: @item.id, qty: 1} }, xhr: true
    post add_items_orders_path, params: { order: { id: Order.last.id, item: item.id, qty: 2} }, xhr: true

    @order = Order.last
    assert_equal 1, Order.count
    assert_equal @item, @order.order_items.first.item
    assert_equal item, @order.order_items.last.item
    assert_equal 1, @order.order_items.first.qty
    assert_equal 2, @order.order_items.last.qty
  end
end
