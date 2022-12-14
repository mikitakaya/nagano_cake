class Admin::CustomersController < ApplicationController
 before_action :authenticate_admin!

  def index
   # customersテーブルに保存されている全てのデータを取得する
   @customers = Customer.page(params[:page])
  end

  def show
   # レコードを1件だけ取得
   @customer = Customer.find(params[:id])
  end

  def edit
   # レコードを1件だけ取得
   @customer = Customer.find(params[:id])
  end

  def update
   # レコードを1件だけ取得
   @customer = Customer.find(params[:id])
   @customer.update(customer_params)
   # 会員詳細画面にリダイレクト
   redirect_to admin_customer_path(@customer.id)
  end

  private
  # 顧客データのストロングパラメータ
  def customer_params
   params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
