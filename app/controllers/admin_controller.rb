class AdminController < ActionController::Base
  def index
    @customers = Customer.all
    @top_customers = Customer.top_customers
    @invoices_to_ship = Invoice.items_not_yet_shipped
  end
end