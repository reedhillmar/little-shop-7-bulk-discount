class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates_presence_of :status

  enum :status, [:in_progress, :completed, :cancelled]

  def date_created
    created_at.strftime("%A, %B %e, %Y")
  end

  def customer_name
    customer.full_name
  end

  def total_revenue #this needs to be refactored with AR query
    total_revenue = 0

    invoice_items.each do |invoice_item|
      total_revenue += invoice_item.quantity * invoice_item.unit_price
    end
    
    total_revenue
  end
end