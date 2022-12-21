class Public::HomesController < ApplicationController
  def top
    @item = Item.all
    @item = Item.all.order(created_at: :desc)
  end
  
  def about
  end
end
