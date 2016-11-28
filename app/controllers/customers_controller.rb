class CustomersController < ApplicationController
  def edit
    @customer = Customer.find(params[:id])
    @order = Order.find(params[:order_id])
  end

  def update
    @order = Order.find(customer_params[:order_id])
    @customer = Customer.find_or_initialize_by(email: customer_params[:email])
    @customer.attributes = customer_params

    if @customer.valid?
      # call payment gateway
      @customer.save
      @order.update_attributes(customer: @customer, state: 'confirmed')
      @order.add_tracking_no
      flash[:notice] = 'Order successfully placed'
      redirect_to order_path(@order) 
    else
      render 'edit'
    end
  end

  def customer_params
    params.require(:customer).permit(:order_id, :email, :credit_card, :card_expiry_date, 
                                     :card_cvv, :card_expiry_year, :address)
  end
end
