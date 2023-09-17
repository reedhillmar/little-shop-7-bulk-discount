class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :status

  enum :status, [:in_progress, :completed, :cancelled]

  # User Story 15
  def customer_name
    "#{customer.first_name} #{customer.last_name}"
  end

  # User Story 15
  def format_created_at
    self.created_at.strftime("%A, %B %d, %Y")
  end
end