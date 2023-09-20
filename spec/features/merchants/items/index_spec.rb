require "rails_helper"

RSpec.describe "Merchant items index", type: :feature do
  before :each do
    load_test_data
  end

  # User Story 6
  it "I see a list of the names of all of my items, And I do not see items for any other merchant" do
    # visit "/merchants/#{@merchant_1.id}/items"
    visit merchant_items_path(@merchant_1)
    
    expect(page).to have_content(@item_1_m1.name)
    expect(page).to have_content(@item_2_m1.name)
    expect(page).to have_content(@item_3_m1.name)
    expect(page).to have_content(@item_4_m1.name)
    expect(page).to have_content(@item_5_m1.name)
    expect(page).to have_content(@item_6_m1.name)
    expect(page).to have_content(@item_7_m1.name)
    expect(page).to have_content(@item_8_m1.name)
    expect(page).to have_content(@item_9_m1.name)
    expect(page).to have_content(@item_10_m1.name)
  end

    # User Story 9
  it "I see a list of the names of all of my items, And I do not see items for any other merchant" do
    # visit "/merchants/#{@merchant_1.id}/items"
    visit merchant_items_path(@merchant_1)
      
    within("##{@item_1_m1.id}") do
      expect(page).to have_button("Disable")
      click_button "Disable"
    end
    # expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    expect(current_path).to eq(merchant_items_path(@merchant_1))

    within("##{@item_1_m1.id}") do
      expect(page).to have_button("Enable")
      click_button "Enable"
    end

    # expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    expect(current_path).to eq(merchant_items_path(@merchant_1))

    within("##{@item_1_m1.id}") do
      expect(page).to have_button("Disable")
    end
  end

    # User Story 10
  it "Then I see two sections, one for 'Enabled Items' and one for 'Disabled Items'" do
    # visit "/merchants/#{@merchant_1.id}/items"
    visit merchant_items_path(@merchant_1)
      
    within (".enabled_items") do
      expect(page).to have_content(@item_1_m1.name)
      expect(page).to have_content(@item_2_m1.name)
      expect(page).to have_content(@item_3_m1.name)
      expect(page).to have_content(@item_4_m1.name)
      expect(page).to have_content(@item_5_m1.name)
      expect(page).to have_content(@item_6_m1.name)
    end
    
    within (".disabled_items") do 
      expect(page).to have_content(@item_7_m1.name)
      expect(page).to have_content(@item_8_m1.name)
      expect(page).to have_content(@item_9_m1.name)
      expect(page).to have_content(@item_10_m1.name)
    end
  end

   # User Story 11
   it "I see a link to create a new item" do
    # visit "/merchants/#{@merchant_1.id}/items"
    visit merchant_items_path(@merchant_1)
      
    expect(page).to have_link("Create New Item")

    click_link "Create New Item"

    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items/new")
    expect(current_path).to eq(new_merchant_item_path(@merchant_1))
    
    fill_in "Name", with: "Gold Stuff"
    fill_in "Description", with: "Expensive"
    fill_in "Unit price", with: "126"
    
    click_button "Create Item"

    # expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    expect(current_path).to eq(merchant_items_path(@merchant_1))

    expect(page).to have_content("Gold Stuff")
  end
end