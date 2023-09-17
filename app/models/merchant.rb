class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  
  validates_presence_of :name

  # User Story 3
  def top_five_customers
    Customer.joins(:transactions)
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

  # User Story 3
  def transaction_count
    customers.joins(:transactions)
              .where("transactions.result = '1'") 
              .group('customers.id')
              .select("CONCAT(customers.first_name, ' ', customers.last_name) AS customer_name, customers.*, COUNT(DISTINCT transactions.id) AS transaction_count")
              .order('transaction_count DESC')
              .limit(5)
  end

  # User Story 4 & 5
  def items_ready_to_ship
    self.items.joins(invoice_items: :invoice)
        .where("invoice_items.status = '1'") 
        .select("items.*, invoice_items.invoice_id")
        .order('invoices.created_at ASC')
  end

  #US 30 - top 5 merchants by revenue
  def self.top_5_by_revenue
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue").joins(:transactions).where("transactions.result = '1'").group(:id).order("revenue desc").limit(5)
  end

  #US31 - best sales day
  def best_day
    # This is bad code that doesn't even begin to do what I wanted. I was coding too late last night
    # invoices.order("created_at desc").first.created_at.to_date
    # require 'pry';binding.pry
    # this give me...something...not sure what
    # invoices.joins(:invoice_items).group("invoices.created_at.to_date AS created_date").order(Arel.sql("sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue desc"))
    #This is so close!!!
    best_day = invoices.joins(:invoice_items).select("invoices.created_at, invoices.created_at::date AS date_created, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue").group(:date_created).order("total_revenue desc")[0]

    best_day.created_at
  end
end