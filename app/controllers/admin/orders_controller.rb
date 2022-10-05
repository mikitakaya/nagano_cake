class Admin::OrdersController < ApplicationController
  def show
   # レコードを1件だけ取得
   @order = Order.find(params[:id])
   # 配送料は800円
   @shipping_fee = 800

   @total = 0
   # order.idに紐づく全ての注文詳細を出す
   @order.order_details.each do |order_detail|
    # order_detail.purchase_amountに購入時価格（カートに入れていた商品の小計）が入っている
    @total += order_detail.purchase_amount
   end
  end

  def update
   # レコードを1件だけ取得
   @order = Order.find(params[:id])
   # 更新する
   @order.update(order_params)

   # 注文ステータスが「入金確認（deposited）」の場合
   if @order.order_status == "deposited"
    # 全ての製作ステータスを「製作待ち（wait）」に更新する
    @order.order_details.update_all(crafting_status: "wait")
   end
   # 注文履歴詳細にリダイレクト
   redirect_to admin_order_path(@order.id)
  end

  # 消費税を求めるメソッド
  def with_tax_price
   (price * 1.1).floor
  end

  private
  # 注文データのストロングパラメータ
  def order_params
   params.require(:order).permit(:order_status)
  end
end
