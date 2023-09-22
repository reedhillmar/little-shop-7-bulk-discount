class Merchants::DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.create(discount_params)
    redirect_to merchant_discounts_path(merchant)
  end

  private
  def discount_params
    params.require(:discount).permit(:event_name, :percentage_discount, :quantity_threshold)
  end
end