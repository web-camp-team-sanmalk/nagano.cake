class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order_detail.production_status_auto_update
    @order_detail.status_auto_update
    redirect_to admin_order_path(@order_detail.order_id)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end

end
