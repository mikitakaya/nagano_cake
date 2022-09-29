class Public::ItemsController < ApplicationController
  def index
   # itemsテーブルに保存されている全てのデータを取得する
   @items = Item.all
   # 個別で表示1ページあたりの表示件数を「8」に指定
   @item = Item.page(params[:page]).per(8)
  end

  def show
   # 登録済みのデータを取得する
   @item = Item.find(params[:id])
   @cart_item = CartItem
   @customer_id = current_customer.id
  end

  private
  # 商品データのストロングパラメータ
  def item_params
   params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active)
  end
end
