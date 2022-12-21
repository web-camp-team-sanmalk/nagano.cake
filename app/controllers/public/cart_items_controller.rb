class Public::CartItemsController < ApplicationController
  
  def index
    @cart_items = current_customer.cart_items.all
  end

  def update
    
    
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
       @cart_items.amount + @cart_item.amount = @cart_item.amount
       @cart_items.destroy
    end
          @cart_item.save
          redirect_to cart_items_path
      end


  private

  def cart_item_params
    params.require(:cart_item).permit(:amount,:item_id,:customer_id)
  end


end
