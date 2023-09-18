class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :status

  def self.items_not_yet_shipped # model test, plz
    # require 'pry'; binding.pry
        joins(:items)
        .where("invoice_items.status = '0'")
        .group(:id)
  end

  enum :status, [:in_progress, :completed, :cancelled]
end

# Invoice.joins(:items).select("items.*, invoice_items.invoice_id").where("invoice_items.status = '0'").group("invoice_id")