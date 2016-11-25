class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name, default: ''
      t.decimal :price, default: 0.0

      t.timestamps
    end
  end
end
