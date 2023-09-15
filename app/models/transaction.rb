class Transaction < ApplicationRecord
  
  belongs_to :invoice
  has_many :customers, through: :invoice

  validates_presence_of :credit_card_number
  validates_presence_of :credit_card_expiration_date
  validates_presence_of :result

  enum :result, [:failed, :success]
end