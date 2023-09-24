class AddDiscountToInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    add_column :invoice_items, :discount, :integer, :default => 0
  end
end
