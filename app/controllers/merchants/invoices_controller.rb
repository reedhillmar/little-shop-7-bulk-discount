class Merchants::InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:invoice_id])
    @invoice_items = InvoiceItem.joins(:item).where(invoice_id: params[:invoice_id], items: { merchant_id: @merchant.id })
  end
end