require 'rails_helper'

RSpec.describe "As a visitor when I visit 'admin/invoices/:id'" do
  before :each do
    load_test_data
  end

  #user story 33
  it "I see a information related to  the invoice" do
    visit "admin/invoices/#{@invoice_1_c1.id}"

    expect(page).to have_content(@invoice_1_c1.id)

    within("#invoice-information") do
      expect(page).to have_content("Status: #{@invoice_1_c1.status}")
      expect(page).to have_content("Date Created: #{@invoice_1_c1.date_created}")
      expect(page).to have_content("Customer Name: #{@customer_1.full_name}")
    end
  end

  # user story 34
  it "I see all items on the invoice with details" do
    visit "admin/invoices/#{@invoice_1_c1.id}"

    within("#invoice_items-information") do
      within("#invoice_item-#{@invoice_item_1_i1_c1.id}") do
        expect(page).to have_content(@invoice_item_1_i1_c1.item_name)
        expect(page).to have_content("Quantity: #{@invoice_item_1_i1_c1.quantity}")
        expect(page).to have_content("Unit Purchase Price: #{@invoice_item_1_i1_c1.unit_price}")
        expect(page).to have_content("Status: #{@invoice_item_1_i1_c1.status}")
      end
    end
  end
end