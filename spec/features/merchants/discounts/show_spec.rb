require "rails_helper"

RSpec.describe "As a merchant when I visit the bulk discounts show page" do
  before :each do
    load_test_data
  end

  #BD_US4
  it "I see the bulk discout's percentage discount and quality threshold" do
    visit merchant_discount_path(@merchant_5, @m5_discount1)

    expect(page).to have_content(@m5_discount1.event_name)

    within "#discount-details" do
      expect(page).to have_content("Percentage Discount: #{@m5_discount1.percentage_discount}")
      expect(page).to have_content("Quantity Threshold: #{@m5_discount1.quantity_threshold}")
    end
  end

  #BD_US5
  it "I see a link to edit the bulk discount" do
    visit merchant_discount_path(@merchant_5, @m5_discount1)

    click_link "Edit Discount"

    expect(current_path).to eq(edit_merchant_discount_path(@merchant_5, @m5_discount1))

    expect(page).to have_field(:discount_event_name, with: @m5_discount1.event_name)
    expect(page).to have_field(:discount_percentage_discount, with: @m5_discount1.percentage_discount)
    expect(page).to have_field(:discount_quantity_threshold, with: @m5_discount1.quantity_threshold)

    fill_in :discount_event_name, with: "It's Fall AF Out Here"
    fill_in :discount_percentage_discount, with: 99
    fill_in :discount_quantity_threshold, with: 1

    click_button "Submit"

    expect(current_path).to eq(merchant_discount_path(@merchant_5, @m5_discount1))

    @m5_discount1.reload

    expect(@m5_discount1.event_name).to eq("It's Fall AF Out Here")
    expect(@m5_discount1.percentage_discount).to eq(99)
    expect(@m5_discount1.quantity_threshold).to eq(1)


    expect(page).to have_content(@m5_discount1.event_name)

    within "#discount-details" do
      expect(page).to have_content("Percentage Discount: #{@m5_discount1.percentage_discount}")
      expect(page).to have_content("Quantity Threshold: #{@m5_discount1.quantity_threshold}")
    end
  end
end