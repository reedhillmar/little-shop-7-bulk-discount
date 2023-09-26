class Merchants::DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.discounts.create!(discount_params)
    redirect_to merchant_discounts_path(merchant)
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    Discount.find(params[:id]).destroy
    redirect_to merchant_discounts_path(merchant)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])

    if @discount.update(discount_params)
      redirect_to "/merchants/#{@merchant.id}/discounts/#{@discount.id}"
    end
  end

  private
  def discount_params
    params.require(:discount).permit(:event_name, :percentage_discount, :quantity_threshold)
  end
end