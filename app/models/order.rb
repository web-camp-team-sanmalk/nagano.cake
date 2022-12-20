class Order < ApplicationRecord
  
  belongs_to :customers
  has_many :items, dependent: :destroy
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum buy_status: {入金待ち:0, 入金確認:1,  製作中:2, 発送準備中:3, 発送済み:4}
  
  def shipping_cost
    800
  end
  
  def cal_price(customer)
    shipping_cost + customer.cart_items.sum(&:subtotal)
  end
  
  def order_item_status_auto_update
    if self.buy_status == "入金確認"
      self.order_items.each do |order_item|
        order_item.update(make_status: "製作待ち")
      end
    #デフォルトで「着手不可」にはなるが、誤って「入金確認」を押した際に製作ステータスを再度「着手不可」へ戻すために以下が必要
    elsif self.buy_status == "入金待ち"
      self.order_items.each do |order_item|
        order_item.update(make_status: "着手不可")
      end
    end
  end
end
