require "rails_helper"

RSpec.describe Item, type: :model do
  before :each do
    load_test_data
  end

  describe "relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
  end

  describe "instance methods" do
    describe "#format_created_at" do
      it "can format created_at" do
        expect(@item_7_m4.format_created_at).to eq("Thursday, March 08, 2012")
      end
    end
  end

end