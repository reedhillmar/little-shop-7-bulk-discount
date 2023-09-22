class Discount < ApplicationRecord
  belongs_to :merchant
  
  validates_presence_of :event_name
  validates_presence_of :percentage_discount
  validates_presence_of :quantity_threshold
end