class Public::CustomersController < ApplicationController
  def show
   # 現在ログインしているcustomer
   @customer = current_customer
  end

  def edit
   # 現在ログインしているcustomer
   @customer = current_customer
  end

  def update
   # 現在ログインしているcustomer
   @customer = current_customer
   @customer.update(customer_params)
   # マイページにリダイレクト
   redirect_to show_path
  end

  def unsubscribe
   # 現在ログインしているcustomer
   @customer = current_customer
  end

  def withdraw
  end

  private
  # 会員データのストロングパラメータ
  def customer_params
   params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
