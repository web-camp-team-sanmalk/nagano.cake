class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    order.order_details_status_auto_update
    redirect_to admin_order_path(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end