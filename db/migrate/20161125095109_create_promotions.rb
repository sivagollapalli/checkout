class CreatePromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :promotions do |t|
      t.references :order, foreign_key: true
      t.references :promocode, foreign_key: true
    end
  end
end
