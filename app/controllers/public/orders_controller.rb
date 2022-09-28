class Public::OrdersController < ApplicationController
  # 注文情報入力画面(支払方法・配送先の選択)
  def new
   # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する
   @order = Order.new
  end

  # 注文履歴画面
  def index
   @orders = Order.all
  end

  # 注文履歴詳細画面
  def show
  end

  # 注文確定処理
  def create
  end

  # 注文情報確認画面
  def confirm
   @order = Order.new(order_params)
   if params[:order][:select_address] == "0"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.full_name
   end
   # @address = Address.find(params[:order][:address_id])
   # @order.postal_code = @address.postal_code
   # @order.address = @address.address
   # @order.name = @address.name

   # 全てのカート内商品
   @cart_items = CartItem.all
   @shipping_fee = 800

   # カートの中身を一個ずつ取り出す
   @cart_items.each do |cart_item|
    # 小計金額の合計を@totalに代入
    @total = cart_item.subtotal
   end
   # @total（小計金額の合計）と@shipping_fee（送料）の合算を@billに代入する
   @bill = @total + @shipping_fee
  end

  # 注文完了画面
  def complete
  end

  # 小計を求めるメソッド
  def subtotal
   item.with_tax_price * amount
  end

  private
  # オーダーデータのストロングパラメータ
  def order_params
   params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_fee, :bill, :payment_method, :order_status)
  end

end
