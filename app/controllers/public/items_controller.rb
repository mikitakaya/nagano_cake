class Public::ItemsController < ApplicationController
  def index
   # itemsテーブルに保存されている全てのデータを取得する
   @items = Item.all
   # 個別で表示1ページあたりの表示件数を「8」に指定
   @item = Item.page(params[:page]).per(8)
  end

  def show
   @item = Item.find(params[:id])
  end

  private

  def item_params
   params.require(:item).permit(:name, :introduction, :price)
  end
end
