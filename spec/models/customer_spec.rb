require "rails_helper"

RSpec.describe Customer, type: :model do
  before :each do
    load_test_data
  end

  describe "relationships" do
    it { should have_many(:invoices)}
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe "validations" do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
  end

  describe "class methods" do
    describe ".top_customers" do
      it "can return the top 5 customers" do
        expect(Customer.top_customers).to eq([@customer_3, @customer_5, @customer_6, @customer_2, @customer_1])
      end
    end
  end

  describe "instance methods" do
    describe "#full_name" do
      it "can return the full name of a customer" do
        expect(@customer_1.full_name).to eq("#{@customer_1.first_name} #{@customer_1.last_name}")
      end
    end
  end
end