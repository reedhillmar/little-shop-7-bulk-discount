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
end