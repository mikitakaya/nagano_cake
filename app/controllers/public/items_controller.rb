class Public::ItemsController < ApplicationController
  def index
   # itemsテーブルに保存されている全てのデータを取得する
   @items = Item.page(params[:page])
  end

  def show
  end
end
