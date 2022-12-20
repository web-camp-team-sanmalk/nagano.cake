class Public::OrdersController < ApplicationController
  def new
  end

  def about
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @orders = current_customer.orders
    @order = Order.find(params[:id])
  end

  def confirm
  end

  def create
  end

end
