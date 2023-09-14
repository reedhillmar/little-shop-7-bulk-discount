require "rails_helper"

RSpec.describe "Merchant Dashboard show page", type: :feature do
  before :each do
    load_test_data
  end
  # Story 1
  it "displays the name of the merchant" do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_content(@merchant_1.name)
  end
  # Story 2
  it "displays a link to merchant items index" do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_link("#{@merchant_1.name} Items")
    click_link ("#{@merchant_1.name} Items")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
  end

  it "displays a link to merchant invoices index" do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_link("#{@merchant_1.name} Invoices")
    click_link ("#{@merchant_1.name} Invoices")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
  end

  # Story 3
  xit "shows top 5 customers with successful transactions" do
  
  end

end