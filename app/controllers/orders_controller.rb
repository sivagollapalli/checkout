class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def select_item
    @item = Item.find(order_params[:item])
  end

  def create
    @order = Order.create!

    @items = Item.find(order_params[:items].keys)
    @promocodes = Promocode.find(order_params[:promocodes].reject(&:blank?))

    @items.each do |item|
      @order.order_items.create(item: item, qty: order_params[:items].dig("#{item.id}", 'qty').to_i)
    end

    @promocodes.each do |promo|
      @order.promotions.create(promocode: promo)
    end

    @order.calculate_order_price

    if @order.price_after_discount.zero?
      flash[:notice] = 'Order successfully placed'
      @order.confirm!
      redirect_to order_path(@order)
    else
      redirect_to payment_order_path(@order)
    end
  end

  def apply_promocode
    @total_price = order_params[:total_price].to_f

    error, success, @discount_price = Order.apply_promocode(order_params[:promocodes], @total_price)

    if success 
      @final_price = (@total_price - @discount_price) < 0 ? 0 : (@total_price - @discount_price)
      flash.now[:notice] = 'Promocode applied successfully'
    else
      flash.now[:error] = error
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def payment
    @customer = Customer.new
    @order = Order.find(params[:id])

    if request.post?
      @customer = Customer.find_or_initialize_by(email: customer_params[:email])
      @customer.attributes = customer_params 

      if @customer.save
        @order.update_attributes(customer: @customer)
        @order.confirm!
        flash[:notice] = 'Order successfully placed'
        redirect_to order_path(@order)
      else
        @card = @customer.cards.last
      end
    end
  end

  private 

  def order_params
    whitelisted = params.require(:order).permit(:id, :email, :item, :qty, :total_price, promocodes: [])
    whitelisted.merge!(items: params.dig(:order, :items))
  end

  def customer_params
    params.require(:customer).permit(:email, :address, cards_attributes: [:credit_card, :card_expiry_date, 
                                     :card_expiry_year, :card_cvv])
  end
end
