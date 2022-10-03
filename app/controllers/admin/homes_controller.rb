class Admin::HomesController < ApplicationController
  def top
   # ordersテーブルに保存されている全てのデータを取得する
   @orders = Order.page(params[:page])
  end

end
