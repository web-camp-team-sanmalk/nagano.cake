class Order < ApplicationRecord
  
  belongs_to :customers
  has_many :items, dependent: :destroy
  
end
