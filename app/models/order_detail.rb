class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum production_status: {着手不可:0, 製作待ち:1,  製作中:2, 製作完了:3}


  def production_status_auto_update
    if self.production_status == "製作中"
      self.order.update(status: "製作中")
    end
  end

  def status_auto_update
    order_details = self.order.order_details
    production_status = order_details.pluck(:production_status)
     if production_status.all?{ |production_status| production_status == "製作完了"}
       self.order.update(status: "発送準備中")
     end
  end

  def subtotal
    self.item.tax_included_price * self.quantity
  end


end
