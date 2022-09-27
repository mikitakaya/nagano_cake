class Public::OrdersController < ApplicationController
  # 注文情報入力画面(支払方法・配送先の選択)
  def new
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
   binding.pry
  end

  # 注文完了画面
  def complete
  end

  private
  # オーダーデータのストロングパラメータ
  def order_params
   params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

end
