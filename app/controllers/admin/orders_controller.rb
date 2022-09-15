class Admin::OrdersController < ApplicationController
  def show
   # レコードを1件だけ取得
   @order = Order.find(params[:id])
  end

  def update
   # レコードを1件だけ取得
   @order = Order.find(params[:id])
   @order.update(order_params)
   # 注文履歴詳細にリダイレクト
   redirect_to admin_order_path(@order.id)
  end

  private
  # 注文データのストロングパラメータ
  def order_params
   params.require(:order).permit(:order_status, :crafting_status)
  end
end
