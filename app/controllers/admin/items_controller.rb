class Admin::ItemsController < ApplicationController
  
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def show
  end

  def edit
  end

  def create
  end

  def update
  end
end
