class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  # User Story 5
  def format_created_at
    self.created_at.strftime("%A, %B %d, %Y")
  end

  # User Story 9

  def update_status
    self.toggle!(:status)
  end

  # User Story 13
  # def best_day
  #   best_day = invoices.joins(:invoice_items).select("invoices.created_at::date AS created_date, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue").group(:created_date).order("total_revenue desc")[0]

  #   best_day.created_date.strftime("%A, %B %e, %Y")
  # end
end