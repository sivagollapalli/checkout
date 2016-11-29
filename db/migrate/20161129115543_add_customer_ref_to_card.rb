class AddCustomerRefToCard < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :customer_id, :integer
  end
end
