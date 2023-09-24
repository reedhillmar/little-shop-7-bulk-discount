require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  before :each do
    load_test_data
  end

  describe "relationships" do
    it {should belong_to(:invoice)}
    it {should belong_to(:item)}
  end

  describe "validations" do
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:unit_price)}
    it {should validate_presence_of(:status)}
  end

  describe "class methods" do
    describe ".total_revenue" do
      it "can return the total revenue of an invoice" do
        expect(@invoice_1_c5.invoice_items.total_revenue).to eq(
          (@invoice_item_1_i1_c5.quantity * @invoice_item_1_i1_c5.unit_price) +
          (@invoice_item_2_i1_c5.quantity * @invoice_item_2_i1_c5.unit_price) +
          (@invoice_item_3_i1_c5.quantity * @invoice_item_3_i1_c5.unit_price)
        )
      end
    end

    describe ".discounted_revenue" do
      it "can return the discounted revenue of an invoice" do
        @invoice_item_1_i1_c5.best_discount
        @invoice_item_2_i1_c5.best_discount
        @invoice_item_3_i1_c5.best_discount
  
        expect(@invoice_1_c5.invoice_items.discounted_revenue).to eq(
          (((@invoice_item_1_i1_c5.quantity * @invoice_item_1_i1_c5.unit_price) * ((100 - @invoice_item_1_i1_c5.discount) / 100.0)) +
          ((@invoice_item_2_i1_c5.quantity * @invoice_item_2_i1_c5.unit_price) * ((100 - @invoice_item_2_i1_c5.discount) / 100.0)) +
          ((@invoice_item_3_i1_c5.quantity * @invoice_item_3_i1_c5.unit_price) * ((100 - @invoice_item_3_i1_c5.discount) / 100.0))).to_i
        )
      end
    end
  end
  
  describe "instance methods" do
    describe "#item_name" do
      it "can return the item name" do
        expect(@invoice_item_1_i1_c1.item_name).to eq("Sour Dough")
      end
    end
    
    describe "#discount_applied" do
      it "can return the appropriate discount to apply" do
        expect(@invoice_item_2_i1_c5.discount_applied).to eq(@m5_discount3)
      end
    end

    describe "#best_discount" do
      it "can apply the best discount to an invoice_item" do
        @invoice_item_2_i1_c5.best_discount

        expect(@invoice_item_2_i1_c5.discount).to eq(@m5_discount3.percentage_discount)
        expect(@invoice_item_2_i1_c5.discount_event_name).to eq(@m5_discount3.event_name)
      end
    end
  end
end