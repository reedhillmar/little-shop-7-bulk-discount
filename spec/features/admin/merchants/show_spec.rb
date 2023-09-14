require 'rails_helper'

RSpec.describe "As a visitor when I visit 'admin/merchants/:id'" do
  before :each do
    load_test_data
  end

  #user story 26
  it "I see a link to update the merchant's info" do
    visit "/admin/merchants/#{@merchant_1.id}"

    click_link "Update Merchant Name"

    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")

    fill_in :name, with: ""

    click_button "Submit"

    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")
    expect(page).to have_content("Error: Name can't be blank")

    fill_in :name, with: "Baby Gap"

    click_button "Submit"

    @merchant_1.reload

    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(@merchant_1.name).to eq("Baby Gap")
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content("Merchant name has been updated")
  end

end