class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
  @item = Item.find(params[:id])

  if params[:button_update] == "true"
    @item.update_status
    redirect_to "/merchants/#{@item.merchant.id}/items"

  elsif @item.update(item_params)
    flash[:notice] = "Item information was successfully updated."
    redirect_to "/merchants/#{@item.merchant.id}/items/#{@item.id}"
  end
  end


  def new
    params.permit(:name, :description, :unit_price)
  end
  
  def create
    @merchant = Merchant.find(params[:merchant_id])
    item = @merchant.items.create(item_params)
    redirect_to "/merchants/#{@merchant.id}/items"
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end 
end

