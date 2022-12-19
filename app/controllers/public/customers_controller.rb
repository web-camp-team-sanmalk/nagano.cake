class Public::CustomersController < ApplicationController
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
  end

  def withdrawal
  end
  
  private

  def customer_params
   params.require(:customer).permit(:is_enabled, :last_name, :first_name, :last_name_kana, :first_name_kana,:telephone_number, :email, :password, :postal_code, :address)
  end
end
