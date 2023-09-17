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
  end