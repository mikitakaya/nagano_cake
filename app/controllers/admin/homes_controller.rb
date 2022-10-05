class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
   # ordersテーブルに保存されている全てのデータを取得する
   @orders = Order.page(params[:page])
  end

end
