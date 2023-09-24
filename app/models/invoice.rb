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

  def total_revenue
    invoice_items.sum("quantity * unit_price")
  end

  def discounted_revenue
  # for each invoice_item
    # do any discounts apply?
      # no
        # no discount
      # yes
        # does more than one discount apply?
          # no
            # use discount
          # yes
            # use highest applicable discount
              # see examples

# invoice.items.joins(:discounts).select("sum((invoice_items.quantity * invoice_items.unit_price) * ((100 - discounts.percentage_discount) / 100))")

# invoice.items.joins(:discounts).select("")
# select("sum((invoice_items.quantity * invoice_items.unit_price) * ((100 - discounts.percentage_discount) / 100))")

  # universal revenue calculation
    # (quantity * unit_price) * ((100 - highest percentage discount item qualifies for) / 100)

    # invoice_items.sum do |item|
    #   require 'pry';binding.pry
    # end
    invoice_items.each do |invoice_item|
      invoice_item.update(discount: invoice_item.best_discount)
    end

    invoice_items.sum("(invoice_items.quantity * invoice_items.unit_price) * ((100 - invoice_items.discount) / 100.0)").to_i
  end

  def format_created_at
    self.created_at.strftime("%A, %B %d, %Y")
  end
end