class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def about
  end

  def index
  end

  def show
  end

  def confirm
  end

  def create
  end

  private
  def order_params
    params.require()

end
