class Admin::OrdersController < ApplicationController
  def show
   # レコードを1件だけ取得
   @order = Order.find(params[:id])
  end

  def update
  end

  private
  # ストロングパラメータ
  def order_params
   params.require(:order).permit(:order_status, :crafting_status)
  end
end
