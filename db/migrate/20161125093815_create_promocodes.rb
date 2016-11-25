class CreatePromocodes < ActiveRecord::Migration[5.0]
  def change
    create_table :promocodes do |t|
      t.string :name, default: ''
      t.string :type, default: ''
      t.decimal :value, default: 0.0
      t.boolean :used_in_conjuncation, default: true

      t.timestamps
    end
  end
end
