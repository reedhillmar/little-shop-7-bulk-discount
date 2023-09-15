class AdminController < ActionController::Base
  def index
    @customers = Customer.all
    @top_customers = Customer.top_customers
  end
end