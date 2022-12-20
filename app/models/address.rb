class Address < ApplicationRecord

  belongs_to :customer

<<<<<<< HEAD





 def address_display
    '〒'+ postal_code + ' ' + address + ' ' + name
  end
=======
  validates :postal_code, presence: true, length: { is: 7 }
  validates :address, presence: true
  validates :name, presence: true
>>>>>>> origin/develop

end
