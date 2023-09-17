require 'rails_helper'

RSpec.describe "As a visitor when I visit 'admin/invoices'" do
  before :each do
    load_test_data
  end

  #user story 32
  it "I see a list of all invoice ids in the system" do
    visit 'admin/invoices'

    expect(page).to have_content(@invoice_2_c1.id)
    expect(page).to have_content(@invoice_1_c2.id)
    expect(page).to have_content(@invoice_5_c6.id)
  end
end