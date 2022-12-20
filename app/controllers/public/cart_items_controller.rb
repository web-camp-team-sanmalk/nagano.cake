class Public::CartItemsController < ApplicationController
  def index
    
    @items = current_customer.cart_items.all
  end

  def update
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @items = current_customer.cart_items.all
    @items.destroy_all
    
  end

  def create
      binding.pry
  end
  
  private
  
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

end
