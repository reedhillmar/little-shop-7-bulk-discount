class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def best_day
    best_day = invoices.joins(:invoice_items).select("invoices.created_at::date AS created_date, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue").group(:created_date).order("total_revenue desc")[0]

    best_day.created_date.strftime("%A, %B %e, %Y")
  end
end
