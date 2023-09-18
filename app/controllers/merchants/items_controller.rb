class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def edit
    @item = Item.find(params[:item_id])
  end
  
  def update
  @item = Item.find(params[:item_id])

  if @item.update(item_params)
    flash[:notice] = "Item information was successfully updated."
    redirect_to "/merchants/#{@item.merchant.id}/items/#{@item.id}"
  end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end 
end

