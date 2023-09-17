class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  validates_presence_of :first_name
  validates_presence_of :last_name

  def self.top_customers
    Customer.joins(:transactions)
            .where("transactions.result = '1'")
            .group("customers.id")
            .select("CONCAT(customers.first_name, ' ', customers.last_name) AS customer_name, customers.*, COUNT(DISTINCT transactions.id) AS transaction_count")
            .order('transaction_count DESC')
            .limit(5)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
