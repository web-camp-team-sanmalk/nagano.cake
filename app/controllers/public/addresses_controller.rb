class Public::AddressesController < ApplicationController

  before_action :ensure_correct_customer

  def index
    @customer = current_customer
    @addresses = @customer.addresses
    @address = Addresses.new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end

  # ログインしているユーザーの住所編集画面かの判断
  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
end
