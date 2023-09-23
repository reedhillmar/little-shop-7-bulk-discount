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

    fill_in :discount_event_name, with: "It's Fall AF Out Here"
    fill_in :discount_percentage_discount, with: 99
    fill_in :discount_quantity_threshold, with: 1

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

  #BD_US3
  it "next to each bulk discount I see a button to delete it" do
    visit merchant_discounts_path(@merchant_5)

    within "#discounts" do
      within "#discount-#{@m5_discount1.id}" do
        click_button "Delete Discount"
      end
    end

    expect(current_path).to eq(merchant_discounts_path(@merchant_5))

    within "#discounts" do
      expect(page).not_to have_content(@m5_discount1.event_name)
    end
  end
end