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

end
