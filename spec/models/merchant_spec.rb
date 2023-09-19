require "rails_helper"

RSpec.describe Merchant, type: :model do
  before :each do
    load_test_data
  end
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  describe "class methods" do
    it ".top_five_customers shows top 5 customers and transaction count" do
      top_customers = @merchant_5.top_five_customers

      expect(top_customers.length).to eq(5)

      expect(top_customers[0]).to eq(@customer_3)
      expect(top_customers[1]).to eq(@customer_2)
      expect(top_customers[2]).to eq(@customer_5)
      expect(top_customers[3]).to eq(@customer_6)
      expect(top_customers[4]).to eq(@customer_1)
    end

    it "enabled_items" do
      items = @merchant_1.enabled_items

      expect(items.length).to eq(6)

      expect(items[0]).to eq(@item_1_m1)
      expect(items[1]).to eq(@item_2_m1)
      expect(items[2]).to eq(@item_3_m1)
      expect(items[3]).to eq(@item_4_m1)
      expect(items[4]).to eq(@item_5_m1)
      expect(items[5]).to eq(@item_6_m1)   
    end
    it ".disabled_items" do
      items = @merchant_1.disabled_items

      expect(items.length).to eq(4)

      expect(items[0]).to eq(@item_7_m1)
      expect(items[1]).to eq(@item_8_m1)
      expect(items[2]).to eq(@item_9_m1)
      expect(items[3]).to eq(@item_10_m1)
    end
  end
end