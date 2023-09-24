class AddDiscountEventNameToInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    add_column :invoice_items, :discount_event_name, :string, :default => "No Discount Applied"
  end
end
