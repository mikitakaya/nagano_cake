class Admin::OrderDetailsController < ApplicationController

  def update
   # レコードを1件だけ取得
   @order_detail = OrderDetail.find(params[:id])
   # 注文詳細に紐づく注文
   @order = @order_detail.order
   # 注文に紐づく全ての注文詳細
   @order_details = @order.order_details
   # 注文詳細を更新する
   @order_detail.update(order_detail_params)

   # 製作ステータスが一つでも「製作中（make）」の場合
   if @order_detail.crafting_status == "make"
    # 注文ステータスを「製作中（make）」に更新する
    @order_detail.order.update(order_status: "make")
   # 注文詳細の数と、全ての注文詳細の製作ステータスが「製作完了（manufactured）」になっている数が合致する場合
   elsif @order.order_details.count == @order_details.where(crafting_status: "manufactured").count
    # 注文ステータスを「発送準備中（preparation）」に更新する
    @order_detail.order.update(order_status: "preparation")
   else
   end

   # 注文履歴詳細にリダイレクト
   redirect_to admin_order_path(@order_detail.order.id)
  end

  private
  # 注文データのストロングパラメータ
  def order_detail_params
   params.require(:order_detail).permit(:crafting_status)
  end

end
