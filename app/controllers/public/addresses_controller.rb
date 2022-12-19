class Public::AddressesController < ApplicationController

  # before_action :ensure_correct_customer

  def index
    @customer = current_customer
    @addresses = current_customer.addresses.all
    @address = Address.new
  end

  def edit
    @customer = current_customer
    @address = Address.find(params[:id])
  end

  def create
    @customer = current_customer
    @address = current_customer.addresses.new(address_params)
    @address.customer_id = @customer.id
    if @address.save
      redirect_to addresses_path
    else
      @customer = current_customer
      @addresses = current_customer.addresses.all
      @address = Address.new
      render :index
    end
  end

  def update
    @customer = current_customer
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @customer = current_customer
    @address = Address.find(params[:id])
    @address.destroy
    @address = Address.new
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

  # ログインしているユーザーの住所編集画面かの判断
  # def ensure_correct_customer
    # @customer = Customer.find(params[:id])
    # unless @customer == current_customer
      # redirect_to customer_path(current_customer)
    # end
  # end
end
