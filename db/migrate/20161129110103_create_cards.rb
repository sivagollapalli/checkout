class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :credit_card
      t.string :card_expiry_date
      t.string :card_expiry_year
      t.string :card_cvv

      t.timestamps
    end
  end
end
