require "rails_helper"

RSpec.describe "As a merchant when I visit the bulk discounts show page" do
  before :each do
    load_test_data
  end

  #BD_US4
  it "I see the bulk discout's percentage discount and quality threshold" do
    visit merchant_discount_path(@merchant_5, @m5_discount1)

    within "#discount-details" do
      expect(page).to have_content("Percentage Discount: #{@m5_discount1.percentage_discount}")
      expect(page).to have_content("Quantity Threshold: #{@m5_discount1.quantity_threshold}")
    end
  end
end