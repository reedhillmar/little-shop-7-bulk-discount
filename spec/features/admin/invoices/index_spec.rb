require 'rails_helper'

RSpec.describe "As a visitor when I visit 'admin/invoices'" do
  before :each do
    load_test_data
  end

  #user story 32
  it "I see a list of all invoice ids in the system" do
    # visit 'admin/invoices'
    visit admin_invoices_path

    expect(page).to have_link("Invoice #{@invoice_1_c1.id}")
    expect(page).to have_link("Invoice #{@invoice_1_c2.id}")
    expect(page).to have_link("Invoice #{@invoice_5_c6.id}")

    click_link "Invoice #{@invoice_1_c1.id}"
    
    # expect(current_path).to eq("/admin/invoices/#{@invoice_1_c1.id}")
    expect(current_path).to eq(admin_invoice_path(@invoice_1_c1))
  end
end