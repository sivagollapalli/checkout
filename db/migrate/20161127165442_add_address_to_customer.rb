class AddAddressToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :address, :text, default: ''
  end
end
