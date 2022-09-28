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
   # 全てのカート内商品
   @cart_items = CartItem.all
   @shipping_fee = 800
   @total = 0

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

  private
  # オーダーデータのストロングパラメータ
  def order_params
   params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_fee, :bill, :payment_method, :order_status)
  end

end
