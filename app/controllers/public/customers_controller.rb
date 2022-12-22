class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer,except: [:unsubscribe, :withdrawal]
  def show
    @customer = Customer.find(params[:id])
  end
  def edit
    @customer = Customer.find(params[:id])
  end
 
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = "You have edited user data successfully."
      redirect_to customer_path(@customer)
    else
      render 'edit'
    end
    
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdrawal
     @customer = current_customer
       if @customer.update(is_deleted: true)
          sign_out current_customer 
       end
       redirect_to root_path
  end
  
  private

  def customer_params
   params.require(:customer).permit(:is_deleted, :last_name, :first_name, :last_name_kana, :first_name_kana,:telephone_number, :email, :password, :postal_code, :address)
  end
  
  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
end
