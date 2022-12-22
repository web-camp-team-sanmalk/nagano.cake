class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    if params[:customer_id]
      #遷移してきたIDをカスタマーIDに入れて、whereで取得
      @orders = Order.where(customer_id: params[:customer_id])
    else
      #オーダーのデーター全部
      @orders = Order.page(params[:page]).per(10)
    end
    @orders_page = Order.page(params[:page]).per(10)
  end
  
end
