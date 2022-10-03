class Admin::OrderDetailsController < ApplicationController

  def update
   # レコードを1件だけ取得
   @order_detail = OrderDetail.find(params[:id])
   @order_detail.update(order_detail_params)
   # 注文履歴詳細にリダイレクト
   redirect_to admin_order_path(@order_detail.order.id)
  end

  private
  # 注文データのストロングパラメータ
  def order_detail_params
   params.require(:order_detail).permit(:crafting_status)
  end

end
