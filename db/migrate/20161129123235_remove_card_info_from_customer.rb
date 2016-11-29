class RemoveCardInfoFromCustomer < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :credit_card
    remove_column :customers, :card_expiry_date
    remove_column :customers, :card_expiry_year 
    remove_column :customers, :card_cvv
  end
end
