require 'rails_helper'

RSpec.describe "As a visitor when I visit 'admin/merchants'" do
  before :each do
    load_test_data
  end

  #user story 24
  it "I see the name of each merchant in the system" do
    # visit 'admin/merchants'
    visit admin_merchants_path

    within("#merchant-#{@merchant_1.id}") do
      expect(page).to have_content(@merchant_1.name)
    end

    within("#merchant-#{@merchant_2.id}") do
      expect(page).to have_content(@merchant_2.name)
    end

    within("#merchant-#{@merchant_3.id}") do
      expect(page).to have_content(@merchant_3.name)
    end
  end

  #user story 25
  it "each name is a link to the merchant's show page" do
    # visit 'admin/merchants'
    visit admin_merchants_path

    within("#merchant-#{@merchant_1.id}") do
      click_link "#{@merchant_1.name}"
    end

    # expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(current_path).to eq(admin_merchant_path(@merchant_1))
    expect(page).to have_content(@merchant_1.name)
  end

  # user story 27
  it "I see a button to disable or enable a merchant" do
    # visit "/admin/merchants"
    visit admin_merchants_path

    within("#merchant-#{@merchant_1.id}") do
      expect(page).to have_content("Status: Disabled")
      expect(page).to have_button("Enable")
      click_button "Enable"
    end

    # expect(current_path).to eq("/admin/merchants")
    expect(current_path).to eq(admin_merchants_path)

    within("#merchant-#{@merchant_1.id}") do
      expect(page).to have_content("Status: Enabled")
      expect(page).to have_button("Disable")
      click_button "Disable"
    end

    # expect(current_path).to eq("/admin/merchants")
    expect(current_path).to eq(admin_merchants_path)

    within("#merchant-#{@merchant_1.id}") do
      expect(page).to have_content("Status: Disabled")
      expect(page).to have_button("Enable")
    end
  end

  #user story 28
  it "I see two sections, one for 'Enabled Merchants' and one for 'Disabled Merchants'" do
    # visit "/admin/merchants"
    visit admin_merchants_path
    
    within('#disabled_merchants') do
      expect(page).not_to have_button("Disable")
      within("#merchant-#{@merchant_1.id}") do
        expect(page).to have_content("Status: Disabled")
        expect(page).to have_button("Enable")
        click_button "Enable"
      end
    end

    within('#enabled_merchants') do
      expect(page).not_to have_button("Enable")
      within("#merchant-#{@merchant_1.id}") do
        expect(page).to have_content("Status: Enabled")
        expect(page).to have_button("Disable")
      end
    end
  end

  # user story 29
  it "I see a link to create a new merchant" do
    # visit "/admin/merchants"
    visit admin_merchants_path

    click_link "Create New Merchant"

    # expect(current_path).to eq("/admin/merchants/new")
    expect(current_path).to eq(new_admin_merchant_path)

    fill_in :name, with: "Terry's Top-Dollar Trinkets"

    click_button "Create Merchant"

    # expect(current_path).to eq("/admin/merchants")
    expect(current_path).to eq(admin_merchants_path)
    within('#disabled_merchants') do
      within("#merchant-#{Merchant.maximum(:id).to_i}") do
        expect(page).to have_content("Terry's Top-Dollar Trinkets")
        expect(page).to have_content("Status: Disabled")
      end
    end
  end

  #user story 30
  it "I see the names of the top 5 merchants by total revenue generated" do
    @top_5_merchants = Merchant.top_5_by_revenue

    # visit "/admin/merchants"
    visit admin_merchants_path

    within('#top_5_merchants') do
      expect(page).to have_content("Top 5 Merchants by Revenue")
      expect("#{@top_5_merchants.first.revenue}").to appear_before("#{@top_5_merchants.last.revenue}")

      within("#top_merchant-#{@merchant_2.id}") do
        expect(page).to have_link("#{@merchant_2.name}")
        expect(page).to have_content("Total Revenue: #{@top_5_merchants.first.revenue}")
      end

      within("#top_merchant-#{@merchant_4.id}") do
        expect(page).to have_link("#{@merchant_4.name}")
        expect(page).to have_content("Total Revenue: #{@top_5_merchants.last.revenue}")
      end
    end
  end

  #user story 31
  it "I see the best sales day of the top 5 merchants" do
    # visit "/admin/merchants"
    visit admin_merchants_path

    within('#top_5_merchants') do
      within("#top_merchant-#{@merchant_2.id}") do
        expect(page).to have_content("Top selling date for #{@merchant_2.name} was #{@merchant_2.best_day}")
      end

      within("#top_merchant-#{@merchant_6.id}") do
        expect(page).to have_link("#{@merchant_6.name}")
        expect(page).to have_content("Top selling date for #{@merchant_6.name} was #{@merchant_6.best_day}")
      end
    end
  end
end
