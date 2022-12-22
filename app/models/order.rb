class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  validates :customer_id, :address,:status, :shipping_cost, :payment_method, :total_payment, presence: true 
  validates :postal_code, length: {is: 7}, numericality: { only_integer: true } 
  validates :shipping_cost, :total_payment, numericality: { only_integer: true }
  
  
  enum payment_method: { credit_card: 0, transfer: 1 }

  enum status: {入金待ち:0, 入金確認:1,  製作中:2, 発送準備中:3, 発送済み:4}

  def shipping_cost
    800
  end

  def cal_price(customer)
    shipping_cost + customer.cart_items.sum(&:subtotal)
  end


  def order_details_status_auto_update
    if self.status == "入金確認"
      self.order_details.each do |order_details|
        order_details.update(production_status: "製作待ち")
      end
    #デフォルトで「着手不可」にはなるが、誤って「入金確認」を押した際に製作ステータスを再度「着手不可」へ戻すために以下が必要
    elsif self.status == "入金待ち"
      self.order_details.each do |order_details|
        order_details.update(production_status: "着手不可")
        

      end
    end
  end

  def address_display
    '〒' + self.postal_code + ' ' + self.address + ' ' + self.name
  end
end

