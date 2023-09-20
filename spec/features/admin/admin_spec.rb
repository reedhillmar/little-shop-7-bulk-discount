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
  it "displays a link to the admin invoices index" do
    visit "/admin"

    expect(page).to have_link("Invoices")
    click_link("Invoices")
    expect(page).to have_current_path("/admin/invoices")
  end

# US21
  it "displays the names of the top 5 customers who have conducted the largest number of successful transactions" do 
    visit "/admin"

    within "#top_five_customers" do
      expect(@customer_3.first_name).to appear_before(@customer_5.first_name)
      expect(@customer_5.first_name).to appear_before(@customer_6.first_name)
      expect(@customer_6.first_name).to appear_before(@customer_2.first_name)
      expect(@customer_2.first_name).to appear_before(@customer_1.first_name)
      expect(page).to have_content(@customer_3.first_name)
      expect(page).not_to have_content(@customer_4.first_name)
    end
  end

# US22 
  it "I see a section for 'Incompleted Invoices' - in that section I see a list of the ids of all invoices that have not yet shipped" do
    visit "/admin"

    within "#incompleted_invoices" do
      expect(page).to have_content("Incompleted Invoices")
      expect(page).to_not have_content("Invoice ID: #{@invoice_4_c1.id}")
      expect(page).to have_content("Invoice ID: #{@invoice_1_c1.id}")
    end
  end

  # US22
  it "And each invoice id links to that invoice's admin show page" do
    visit "/admin"
    click_link("#{@invoice_1_c1.id}")

    expect(current_path).to eq("/admin/invoices/#{@invoice_1_c1.id}")
  end

  # US23
  it "In the section for 'Incomplete Invoices',
  Next to each invoice id I see the date that the invoice was created
  And I see the date formatted like 'Monday, July 18, 2019'" do
    visit "/admin"

    within "#incompleted_invoices" do
      expect(page).to have_content("Date Created: #{@invoice_1_c1.date_created} - Invoice ID: #{@invoice_1_c1.id}")
    end
  end

  # US23
  it "And I see that the list is ordered from oldest to newest" do
    visit "/admin"

    within "#incompleted_invoices" do
     expect(@invoice_2_c1.date_created).to appear_before(@invoice_1_c1.date_created)
    # save_and_open_page
    end
  end
end