class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :email, default: ''
      t.string :credit_card, default: ''
      t.integer :card_expiry_date, default: ''
      t.integer :card_expiry_year, default: ''
      t.integer :card_cvv, default: ''

      t.timestamps
    end
  end
end
