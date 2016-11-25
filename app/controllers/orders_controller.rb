class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def calculate_order_summary
    @order = Order.where(id: order_params[:id]).first || Order.new

    if @order.save
      order_item = @order.order_items.find_or_initialize_by(item_id: order_params[:item_id])
      order_item.qty = order_item.qty + order_params[:qty].to_i
      order_item.save

      @order.calculate_order_price
    end
  end

  private 

  def order_params
    params.require(:order).permit(:id, :item_id, :qty)
  end
end
