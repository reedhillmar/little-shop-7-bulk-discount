require "rails_helper"

RSpec.describe "Merchant items show page", type: :feature do
  before :each do
    load_test_data
  end

  # User Story 7
  it "When I click on the name I am taken to that merchant's item's show page " do
    visit "/merchants/#{@merchant_1.id}/items"
    click_link "Watch"
    expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items/#{@item_1_m1.id}")
  end

  # User Story 7
  it "I see a list of the names of all of my items, And I do not see items for any other merchant" do
    visit "/merchants/#{@merchant_1.id}/items/#{@item_1_m1.id}"

    expect(page).to have_content(@item_1_m1.name)
    expect(page).to have_content(@item_1_m1.description)
    expect(page).to have_content(@item_1_m1.unit_price)
  end
end