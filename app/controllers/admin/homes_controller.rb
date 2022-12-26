class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    unless params[:customer_id].nil?
      #遷移してきたIDをカスタマーIDに入れて、whereで取得
      @orders = Order.where(customer_id: params[:customer_id]).page(params[:page]).per(10)
      @customer = Customer.find(params[:customer_id])
      @num =1
    else
      #オーダーのデーター全部
      @orders = Order.page(params[:page]).per(10)
      @num =2
    end
  end

end
