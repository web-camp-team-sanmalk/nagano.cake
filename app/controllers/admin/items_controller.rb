class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
    @genres = Genre.all

  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def edit
     @item = Item.find(params[:id])
    @genres = Genre.all
  end


  def create
    @item = Item.new(item_params)
    if  @item.save
      redirect_to admin_item_path(@item.id)
      flash[:notice] = "商品が追加されました"
    else
      render :new
    end
  end


  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
       flash[:notice] = "商品を変更しました"
       redirect_to admin_item_path(@item.id)
    else
       render :edit
    end
  end


private

def item_params
  params.require(:item).permit(:image, :name, :introduction, :price, :is_active, :genre_id)
end

end