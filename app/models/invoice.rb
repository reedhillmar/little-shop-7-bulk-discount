class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  validates_presence_of :status

  enum :status, [:in_progress, :completed, :cancelled]

  def self.items_not_yet_shipped
        joins(:items)
        .where("invoice_items.status != '2'")
        .group(:id)
        .order("invoices.created_at ASC")
  end

  def date_created
    created_at.strftime("%A, %B %e, %Y")
  end

  def customer_name
    customer.full_name
  end

  ## These methods got moved to invoice_items model
  # def total_revenue
  #   invoice_items.sum("quantity * unit_price")
  # end

  # def discounted_revenue
  #   ## This is my first solution - not enough AR
  #   # invoice_items.each do |invoice_item|
  #   #   invoice_item.best_discount
  #   # end

  #   # invoice_items.sum("(invoice_items.quantity * invoice_items.unit_price) * ((100 - invoice_items.discount) / 100.0)").to_i

  #   invoice_items.sum do |invoice_item|
  #     invoice_item.best_discount

  #     (invoice_item.quantity * invoice_item.unit_price) * ((100 - invoice_item.discount) / 100.0)
  #   end.to_i
  # end

  def format_created_at
    self.created_at.strftime("%A, %B %d, %Y")
  end
end