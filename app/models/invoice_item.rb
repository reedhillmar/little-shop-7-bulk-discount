class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status
  validates_presence_of :discount

  enum :status, [:pending, :packaged, :shipped]

  def item_name
    item.name
  end

  def best_discount
    best_discount = 0

    item.discounts.each do |discount|
      if quantity >= discount.quantity_threshold
        best_discount = discount.percentage_discount if discount.percentage_discount > best_discount
      end
    end
    
    best_discount
  end
end