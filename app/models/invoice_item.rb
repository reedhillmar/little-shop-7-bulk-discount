class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status
  validates_presence_of :discount
  validates_presence_of :discount_event_name

  enum :status, [:pending, :packaged, :shipped]

  def item_name
    item.name
  end
  
  def discount_applied
    item.merchant.discounts.where("discounts.quantity_threshold <= ?", quantity).order(percentage_discount: :desc)[0]
  end

  def best_discount_name
    best_discount.event_name
  end
  
  def best_discount
    ## This is my first solution - not enough AR
    # best_discount = 0
    
    # item.discounts.each do |discount|
    #   if quantity >= discount.quantity_threshold
    #     best_discount = discount.percentage_discount if discount.percentage_discount > best_discount
    #   end
    # end
    
    # best_discount
    
    if discount_applied
      update(discount: discount_applied.percentage_discount)
      update(discount_event_name: discount_applied.event_name)
    end
  end
  
  def self.total_revenue
    sum("invoice_items.quantity * invoice_items.unit_price")
  end
  
  def self.discounted_revenue
    sum do |invoice_item|
      # invoice_item.apply_discount
      if invoice_item.best_discount
        (invoice_item.quantity * invoice_item.unit_price) * ((100 - invoice_item.best_discount.percentage_discount) / 100.0)
      else
        (invoice_item.quantity * invoice_item.unit_price)
      end
    end.to_i
  end
end