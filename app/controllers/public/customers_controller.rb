class Public::CustomersController < ApplicationController
  def show
   # 現在ログインしているcustomer
   @customer = current_customer
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

  private
  # 会員データのストロングパラメータ
  def customer_params
   params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
