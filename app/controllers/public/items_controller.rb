class Public::ItemsController < ApplicationController
  def index
   # itemsテーブルに保存されている全てのデータを取得する
   # 個別で表示1ページあたりの表示件数を「8」に指定
   @items = Item.page(params[:page]).per(8)
  end

  def show
  end
end
