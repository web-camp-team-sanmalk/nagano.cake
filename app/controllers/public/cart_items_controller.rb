class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer,only: [:update, :destroy]
  def index
    @cart_items = current_customer.cart_items.all
    @total = 0
    @cart_items.each do |cart_item|
    @total = cart_item.subtotal + @total
  end
    #@total = @cart_items.inject(0) { |sum, item| sum + item.add_tax_price }
  end

  def update
      @cart_item = CartItem.find(params[:id])
      @cart_item.update(cart_item_params)
      redirect_to cart_items_path
  end

   def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
   end

  def destroy_all
    @cart_items = current_customer.cart_items.all
    @cart_items.destroy_all
     redirect_to cart_items_path
  end


  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
# カートに別タイミングで同商品を入れたときにカート内で個数が統合されるコード
    @cart_items = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if @cart_items.present?
       @cart_item.amount = @cart_items.amount + @cart_item.amount 
       @cart_items.destroy
    end
          @cart_item.save
          redirect_to cart_items_path
  end



  private

  def cart_item_params
    params.require(:cart_item).permit(:amount,:item_id,:customer_id)
  end
  
  def ensure_correct_customer
    @cart_item = CartItem.find(params[:id])
    @customer = Customer.find(@cart_item.customer_id)
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end


end
