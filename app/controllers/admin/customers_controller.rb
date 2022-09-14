class Admin::CustomersController < ApplicationController
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
  end

  private
  # 顧客データのストロングパラメータ
  def customer_params
   params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
