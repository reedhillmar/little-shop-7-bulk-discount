class Merchants::InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    # require 'pry';binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @invoice_items = InvoiceItem.joins(:item).where(invoice_id: params[:id], items: { merchant_id: @merchant.id })
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update(status: params[:status])
  
    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end
end