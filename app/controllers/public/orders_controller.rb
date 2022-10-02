class Public::OrdersController < ApplicationController
  # 注文情報入力画面(支払方法・配送先の選択)
  def new
   # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する
   @order = Order.new
  end

  # 注文履歴一覧画面
  def index
   @orders = current_customer.orders
  end

  # 注文履歴詳細画面
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

  # 注文確定処理
  def create
   # データを受け取り新規登録するためのインスタンス作成
   @order = Order.new(order_params)
   # 新規オーダーを保存する
   @order.save

   # 注文詳細（order_details）の保存
   #カートの商品を1つずつ取り出す
   current_customer.cart_items.each do |cart_item|
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する
    @order_detail = OrderDetail.new
    # 注文詳細の商品IDにカート内商品の商品IDを代入する
    @order_detail.item_id = cart_item.item_id
    # 注文詳細の数量にカート内商品の数量を代入する
    @order_detail.quantity = cart_item.amount
    # 購入時価格（税込）にカート内商品の小計を代入する
    @order_detail.purchase_amount = cart_item.subtotal
    # 注文詳細IDに注文IDを紐付ける
    @order_detail.order_id = @order.id
    # 注文詳細を保存する
    @order_detail.save
   end

   # カート内商品を全て削除する
   current_customer.cart_items.destroy_all
   # 注文完了画面にリダイレクトする
   redirect_to complete_path
  end


  # 注文情報確認画面
  def confirm
   # 全てのカート内商品
   @cart_items = CartItem.all
   @shipping_fee = 800
   @total = 0

   # 新規オーダーのカスタマーID ＝　ログイン中のカスタマーID
   @customer = current_customer.id

   @cart_items.each do |cart_item|
    @total += cart_item.subtotal
   end
   @bill = @total + @shipping_fee

   # データを受け取り新規登録するためのインスタンス作成
   @order = Order.new(order_params)
   # [:select_address]=="0"のデータ（顧客の住所）を呼び出す
   if params[:order][:select_address] == "0"
    # ログインユーザーの登録郵便番号
    @order.postal_code = current_customer.postal_code
    # ログインユーザーの登録住所
    @order.address = current_customer.address
    # ログインユーザーの登録氏名
    @order.name = current_customer.full_name

   # 上記条件に当てはまらない場合、[:select_address]=="1"のデータ（登録済みの配送先）を呼び出す
   elsif params[:order][:select_address] == "1"
    # 配送先として登録済みのデータを取得する
    @address = Address.find(params[:order][:address_id])
    # 登録済みの配送先郵便番号
    @order.postal_code = @address.postal_code
    # 登録済みの配送先住所
    @order.address =  @address.address
    # 登録済みの宛名
    @order.name = @address.name

   # 上記二つの条件に当てはまらない場合、[:select_address]=="2"のデータ（新しい配送先）を呼び出す
   elsif params[:order][:select_address] == "2"
    # 新たな配送先の郵便番号
    @order.postal_code = params[:order][:postal_code]
    # 新たな配送先の住所
    @order.address = params[:order][:address]
    # 新たな配送先の宛名
    @order.name = params[:order][:name]
   end
  end

  # 注文完了画面
  def complete
  end

  # 小計を求めるメソッド
  def subtotal
   item.with_tax_price * amount
  end

  # 消費税を求めるメソッド
  def with_tax_price
   (price * 1.1).floor
  end

  # def destroy
  #  @order = Order.find(params[:id])
  #  @order.destroy
  #  redirect_to '/orders'
  # end

  private
  # オーダーデータのストロングパラメータ
  def order_params
   params.require(:order).permit(:customer_id, :postal_code, :address, :name, :bill, :payment_method, :order_status)
  end

end
