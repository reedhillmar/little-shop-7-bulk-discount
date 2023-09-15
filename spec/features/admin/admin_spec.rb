require "rails_helper"

RSpec.describe "admin dashboard" do
  before(:each) do
    load_test_data
  end
# US19
  it "displays a header indicating that I am on the admin dashboard" do
    visit "/admin"
    
    expect(page).to have_content("Welcome to the admin dashboard!")
  end
# US20
  it "displays a link to the admin merchants index" do
    visit "/admin"
    expect(page).to have_link("Merchants")
    click_link("Merchants")
    expect(page).to have_current_path("/admin/merchants")
  end
# US20
  xit "displays a link to the admin invoices index" do
    visit "/admin"

    expect(page).to have_link("Invoices")
    click_link("Invoices")
    expect(page).to have_current_path("/admin/invoices")
  end
# US21
  it "displays the names of the top 5 customers who have conducted the largest number of successful transactions" do 
    visit "/admin"
    
    expect(@customer_3.first_name).to appear_before(@customer_2.first_name)
    expect(@customer_2.first_name).to appear_before(@customer_5.first_name)
    expect(@customer_5.first_name).to appear_before(@customer_6.first_name)
    expect(@customer_6.first_name).to appear_before(@customer_1.first_name)
    expect(page).to have_content(@customer_3.first_name)
    expect(page).not_to have_content(@customer_4.first_name)
    save_and_open_page
  end
end