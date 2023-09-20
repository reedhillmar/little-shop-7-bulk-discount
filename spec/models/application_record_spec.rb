require 'rails_helper'

RSpec.describe "Application record methods" do
  before :each do
    load_test_data
  end

  describe "#best_day" do
    it "can return the date with highest total revenue for a merchant" do
      expect(@merchant_2.best_day).to eq(@invoice_2_c1.date_created)
    end

    it "can return the date with highest total revenue for an item" do
      expect(@item_2_m2.best_day).to eq(@invoice_2_c1.date_created)
    end
  end
end