class AddRefnoToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :ref_no, :string, default: ''
  end
end
