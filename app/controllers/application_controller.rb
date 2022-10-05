class ApplicationController < ActionController::Base
 

 private
 # サインイン後のリダイレクト先を指定
 def after_sign_in_path_for(resource_or_scope)
  if resource_or_scope.is_a?(Admin)
   # 管理者の場合は注文画面一覧画面
   admin_top_path
  else
   # 上記に当てはまらない（顧客）場合、ルートパス
   root_path
  end
 end

 # サインアウト後のリダイレクト先を設定
 def after_sign_out_path_for(resource_or_scope)
  # 管理者の場合
  if resource_or_scope == :admin
   # 管理者ログイン画面
   new_admin_session_path
  # 顧客の場合
  elsif resource_or_scope == :public
   # ルートパス
   root_path
  else
   root_path
  end
 end

end
