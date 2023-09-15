class Merchant < ApplicationRecord
  
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  

  validates_presence_of :name



  def top_five_customers
    customers.joins(:transactions)
                        .where("transactions.result = '1'") 
                        .group('customers.id')
                        .select("CONCAT(customers.first_name, ' ', customers.last_name) AS customer_name, customers.*, COUNT(DISTINCT transactions.id) AS transaction_count")
                        .order('transaction_count DESC')
                        .limit(5)
  end

  def enabled_or_disabled
    if enabled == true
      "Enabled"
    elsif enabled == false
      "Disabled"
    end
  end

  def button_text
    if enabled == true
      "Disable"
    elsif enabled == false
      "Enable"
    end
  end

  def self.enabled_merchants
    where(enabled: true).order(:name)
  end

  def self.disabled_merchants
    where(enabled: false).order(:name)

  end
end