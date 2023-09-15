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
    it ".top_five_customers shows top 5 customers with successful transactions" do
      top_customers = @merchant_5.top_five_customers

      expect(top_customers.length).to eq(5)

      expect(top_customers[0]).to eq(@customer_3)
      expect(top_customers[1]).to eq(@customer_2)
      expect(top_customers[2]).to eq(@customer_5)
      expect(top_customers[3]).to eq(@customer_6)
      expect(top_customers[4]).to eq(@customer_1)
    end
  end
end