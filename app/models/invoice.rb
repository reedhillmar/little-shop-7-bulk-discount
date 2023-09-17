class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :status

  enum :status, [:in_progress, :completed, :cancelled]

  def date_created
    created_at.strftime("%A, %B %e, %Y")
  end

  def customer_name
    customer.full_name
  end
end