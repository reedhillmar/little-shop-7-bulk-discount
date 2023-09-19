class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates_presence_of :status

  def self.items_not_yet_shipped # model test, plz
    # require 'pry'; binding.pry
        joins(:items)
        .where("invoice_items.status = '0'")
        .group(:id)
  end

  enum :status, [:in_progress, :completed, :cancelled]

  def date_created
    created_at.strftime("%A, %B %e, %Y")
  end

  def customer_name
    customer.full_name
  end

  def total_revenue
    total_revenue = 0

    invoice_items.each do |item|
      total_revenue += item.quantity * item.unit_price
    end
    
    total_revenue
  end
end