class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum make_status: {着手不可:0, 製作待ち:1,  製作中:2, 製作完了:3}

  def production_status_auto_update
    if self.make_status == "製作中"
      self.order.update(buy_status: "製作中")
    end
  end

  def status_auto_update
    order_items = self.order.order_items
    make_status = order_items.pluck(:make_status)
     if make_status.all?{ |make_status| make_status == "製作完了"}
       self.order.update(buy_status: "発送準備中")
     end
  end

  def subtotal
    self.item.tax_included_price * self.quantity
  end

end
