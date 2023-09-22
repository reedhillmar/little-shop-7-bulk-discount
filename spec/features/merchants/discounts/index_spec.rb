require "rails_helper"

RSpec.describe "As a merchant when I visit the bulk discounts index" do
  before :each do
    load_test_data
  end

  #BD_US2
  it "I see a link to create a new discount" do
    visit merchant_discounts_path(@merchant_5)

    click_link "Create a New Discount"

    expect(current_path).to eq(new_merchant_discount_path(@merchant_5))

    fill_in :event_name, with: "It's Fall AF Out Here"
    fill_in :percentage_discount, with: 99
    fill_in :quantity_threshold, with: 1

    click_button "Submit"

    expect(current_path).to eq(merchant_discounts_path(@merchant_5))

    within "#discounts" do
      within "#discount-#{Discount.last.id}" do
        expect(page).to have_link(Discount.last.event_name)
        expect(page).to have_content("Percentage Discount: #{Discount.last.percentage_discount}")
        expect(page).to have_content("Quantity Threshold: #{Discount.last.quantity_threshold}")
      end
    end
  end
end