require "rails_helper"

RSpec.describe "Merchant Invoice Show Page", type: :feature do
  before :each do
    load_test_data
  end

  # User Story 16
  it "displays all items and their attributes(name, quantity, price, invoice item status) for that invoice" do
    visit "/merchants/#{@merchant_5.id}/invoices/#{@invoice_3_c6.id}"

    expect(page).to_not have_content(@item_1_m3.name)
    expect(page).to have_content(@item_6_m5.name)
    expect(page).to have_content( @invoice_item_1_i3_c6.quantity)
    expect(page).to have_content(@item_6_m5.unit_price)
    expect(page).to have_content(@invoice_item_1_i3_c6.status)
    save_and_open_page
  end 

  # User Story 17
  it "displays total revenue generated from all items on the invoice" do
    visit "/merchants/#{@merchant_5.id}/invoices/#{@invoice_3_c6.id}"

    expect(page).to have_content("Total Revenue for Invoice: #{@invoice_3_c6.total_revenue}")
  end
end