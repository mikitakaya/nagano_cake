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
   # 現在ログインしているcustomer
   @customer = current_customer
   # is_deletedカラムをtrueに変更することにより削除フラグを立てる
   @customer.update(is_deleted: true)
   # すべてのセッション情報を削除
   reset_session
   flash[:notice] = "退会処理を実行いたしました"
   # トップ画面へリダイレクト
   redirect_to root_path
  end

  private
  # 会員データのストロングパラメータ
  def customer_params
   params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
