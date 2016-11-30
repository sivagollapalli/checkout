class RenameCardExpiryDateColumnToExpiryMonth < ActiveRecord::Migration[5.0]
  def change
    rename_column :cards, :card_expiry_date, :card_expiry_month
  end
end
