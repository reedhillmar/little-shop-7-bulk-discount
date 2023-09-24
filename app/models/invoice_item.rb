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
    item.discounts.each do |discount|
      if quantity >= discount.quantity_threshold
        update(discount: discount.percentage_discount) if discount.percentage_discount > self.discount
        update(discount_event_name: discount.event_name)
      end
    end
  end
end