class Admin::ItemsController < ApplicationController
  def index
  end

  def new
   # Viewのform_withへ渡すための「空のモデル」を生成する
   @item = Item.new
   @genres = Genre.all
  end

  def create
   # データを受け取り新規登録するためのインスタンス作成
   @item = Item.new(item_params)
   # データをデータベースに保存する
   @item.save
   # 商品詳細画面にリダイレクト
   redirect_to admin_item_path(@item.id)
  end

  def show
   # レコードを1件だけ取得
   @item = Item.find(params[:id])
  end

  def edit
   # レコードを1件だけ取得
   @item = Item.find(params[:id])
   @genres = Genre.all
  end

  def update
   # レコードを1件だけ取得
   @item = Item.find(params[:id])
   @item.update(item_params)
   # 商品詳細画面にリダイレクト
   redirect_to admin_item_path(@item.id)
  end

  # 商品データのストロングパラメータ
  private

  def item_params
   params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

end
