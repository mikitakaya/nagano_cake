# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
 before_action :customer_state, only: [:create]

 protected
 # 退会しているかを判断するメソッド
 def customer_state
  # 【処理内容1】 入力されたemailからアカウントを1件取得
  @customer = Customer.find_by(email: params[:customer][:email])
  # アカウントを取得できなかった場合、このメソッドを終了する
  return if !@customer
  # 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
  if @customer.valid_password?(params[:customer][:password])
   # 【処理内容3】取得したアカウントのis_deletedがno_active（true、退会）の場合
   if @customer.is_deleted == "no_active"
    # 退会済みのため、新規登録画面へリダイレクトする
    redirect_to new_customer_registration_path
   end
  end
 end
end
