class Order < ApplicationRecord

  belongs_to :customer
  has_many :items, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }

  def address_display
    '〒' + self.postal_code + ' ' + self.address + ' ' + self.name
  end
end
