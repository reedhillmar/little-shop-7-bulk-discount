require "rails_helper"

RSpec.describe "Merchant Invoice Show Page", type: :feature do
  before :each do
    load_test_data
  end

  # User Story 16
  it "displays all items and their attributes(name, quantity, price, invoice item status) for that invoice" do
    # visit "/merchants/#{@merchant_5.id}/invoices/#{@invoice_3_c6.id}"
    visit merchant_invoice_path(@merchant_5, @invoice_3_c6)

    expect(page).to_not have_content(@item_1_m3.name)
    expect(page).to have_content(@item_6_m5.name)
    expect(page).to have_content( @invoice_item_1_i3_c6.quantity)
    expect(page).to have_content(@item_6_m5.unit_price)
    expect(page).to have_content(@invoice_item_1_i3_c6.status)
    
  end 

  # User Story 17
  it "displays total revenue generated from all items on the invoice" do
    # visit "/merchants/#{@merchant_5.id}/invoices/#{@invoice_3_c6.id}"
    visit merchant_invoice_path(@merchant_5, @invoice_3_c6)

    expect(page).to have_content("Total Revenue for Invoice: #{@invoice_3_c6.invoice_items.total_revenue}")
  end

  # User Story 18
  it "displays invoice status in a select field that allows users to update the status" do
    # visit "/merchants/#{@merchant_5.id}/invoices/#{@invoice_2_c6.id}"
    visit merchant_invoice_path(@merchant_5, @invoice_2_c6)

    expect(@invoice_item_1_i2_c6.status).to eq("pending")

    select "shipped", from: "status"
    click_button "Update Item Status"

    @invoice_item_1_i2_c6.reload

    expect(@invoice_item_1_i2_c6.status).to eq("shipped")
  end

  
  # BD_US6
  it "I visit my merchant invoice show page
  Then I see the total revenue for my merchant from this invoice (not including discounts)
  And I see the total discounted revenue for my merchant from this invoice which includes bulk discounts in the calculation" do
    visit merchant_invoice_path(@merchant_5, @invoice_1_c5)

    @invoice_items = InvoiceItem.joins(:item).where(invoice_id: @invoice_1_c5.id, items: { merchant_id: @merchant_5.id })

    within "#revenue" do
      within "#total_revenue" do
        expect(page).to have_content("Total Revenue for Invoice: #{@invoice_items.total_revenue}")
      end

      within "#discounted_revenue" do
        expect(page).to have_content("Discounted Revenue for Invoice: #{@invoice_items.discounted_revenue}")
      end
    end
  end

  # BD_US7
  it "next to each invoice item I see a link to the show page for the bulk discount that was applied (if any)" do
    visit merchant_invoice_path(@merchant_5, @invoice_1_c5)

    within("#invoice_item-#{@invoice_item_1_i1_c5.id}") do
      expect(page).to have_content("Bulk Discount: No Discount Applied")
    end

    within("#invoice_item-#{@invoice_item_2_i1_c5.id}") do
      expect(page).to have_content("Bulk Discount: We're Going Under (The Sea)")
      
      click_link "We're Going Under (The Sea)"
    end

    expect(current_path).to eq(merchant_discount_path(@merchant_5, @m5_discount3))
  end
end