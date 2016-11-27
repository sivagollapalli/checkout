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
      flash.now[:notice] = 'Order successfully placed'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def customer_params
    params.require(:customer).permit(:order_id, :email, :credit_card, :card_expiry_date, 
                                     :card_cvv, :card_expiry_year, :address)
  end
end
