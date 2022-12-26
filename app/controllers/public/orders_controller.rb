class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:show]
  before_action :cart_item_empty, only:[:new, :confirm, :create]
  def new
    @order = Order.new
  end

  def about
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
    # 自分の住所を選択した場合
    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    # 登録済みの住所を選択した場合
    elsif params[:order][:address_number] == "2"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
    # 商品合計金額
    @total = 0
    @cart_items.each do |cart_item|
      @total = cart_item.item.add_tax_price * cart_item.amount + @total
    end
  end


  def create
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.order_id = @order.id
        order_detail.item_id = cart_item.item_id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.add_tax_price * cart_item.amount
        order_detail.save
      end
      redirect_to orders_about_path
      @cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  private

  def order_params
    params.permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment)
  end

  def ensure_correct_customer
    @order = Order.find(params[:id])
    @customer = Customer.find(@order.customer_id)
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end

  def cart_item_empty
    @cart_items = current_customer.cart_items.all
    if @cart_items.present?

    else
      redirect_to customer_path(current_customer)
    end
  end
end
