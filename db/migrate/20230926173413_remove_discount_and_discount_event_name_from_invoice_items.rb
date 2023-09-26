class RemoveDiscountAndDiscountEventNameFromInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :invoice_items, :discount, :integer
    remove_column :invoice_items, :discount_event_name, :string
  end
end
