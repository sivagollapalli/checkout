class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def add_items 
    if !order_params[:item].blank? || order_params[:qty].to_i > 0
      @order = Order.where(id: order_params[:id]).first || Order.new
      @order.customer = Customer.create

      if @order.save
        order_item = @order.order_items.find_or_initialize_by(item_id: order_params[:item])
        order_item.qty = order_item.qty + order_params[:qty].to_i
        order_item.save

        @order.calculate_order_price
      end
    else
      flash.now[:error] = 'Please select an item'
    end
  end

  def checkout
    @order = Order.find(params[:id])
    redirect_to edit_customer_path(id: @order.customer, order_id: @order.id)
  end

  private 

  def order_params
    params.require(:order).permit(:id, :item, :qty)
  end
end
